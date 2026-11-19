import 'dart:convert';
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_config.dart';
import 'auth_user.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  const ApiException(this.message, [this.statusCode]);
  @override
  String toString() => message;
}

class AuthService {
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'jwt_access_token';
  static Uri _uri(String path) => Uri.parse('${ApiConfig.baseUrl}/api$path');

  Map<String, dynamic> _decode(http.Response response) {
    try {
      final decoded = jsonDecode(response.body);
      if (decoded is! Map<String, dynamic>) throw const FormatException();
      return decoded;
    } on FormatException {
      throw const ApiException('A API retornou uma resposta JSON inválida.');
    }
  }

  Future<void> register({required String name, required String email, required String password}) async {
    try {
      final response = await http.post(_uri('/register'), headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password})).timeout(ApiConfig.timeout);
      final data = _decode(response);
      if (response.statusCode != 201) throw ApiException(data['message']?.toString() ?? 'Não foi possível cadastrar.', response.statusCode);
    } on ApiException { rethrow; }
      on http.ClientException { throw const ApiException('Não foi possível conectar ao servidor.'); }
      on TimeoutException { throw const ApiException('Tempo de conexão esgotado.'); }
      on Exception catch (e) { if (e.toString().contains('TimeoutException')) throw const ApiException('Tempo de conexão esgotado.'); rethrow; }
  }

  Future<AuthUser> login({required String email, required String password}) async {
    try {
      final response = await http.post(_uri('/login'), headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password})).timeout(ApiConfig.timeout);
      final data = _decode(response);
      if (response.statusCode != 200) throw ApiException(data['message']?.toString() ?? 'Falha na autenticação.', response.statusCode);
      final token = data['accessToken'] as String?;
      final userJson = data['data'];
      if (token == null || userJson is! Map<String, dynamic>) throw const ApiException('Resposta de autenticação incompleta.');
      try { await _storage.write(key: _tokenKey, value: token); }
      catch (_) { throw const ApiException('Falha ao salvar o token no armazenamento seguro.'); }
      try { return AuthUser.fromJson(userJson); }
      on TypeError { throw const ApiException('Os dados do usuário recebidos da API são inválidos.'); }
    } on ApiException { rethrow; }
      on http.ClientException { throw const ApiException('Servidor indisponível. Verifique sua conexão.'); }
      on TimeoutException { throw const ApiException('Tempo de conexão esgotado.'); }
      on Exception catch (e) { if (e.toString().contains('TimeoutException')) throw const ApiException('Tempo de conexão esgotado.'); rethrow; }
  }

  Future<AuthUser> fetchMe() async {
    try {
      String? token;
      try { token = await _storage.read(key: _tokenKey); }
      catch (_) { throw const ApiException('Falha ao ler o token do armazenamento seguro.'); }
      if (token == null || token.isEmpty) throw const ApiException('Sessão não encontrada.', 401);
      final response = await http.get(_uri('/me'), headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'}).timeout(ApiConfig.timeout);
      if (response.statusCode == 401) {
        try { await _storage.delete(key: _tokenKey); }
        catch (_) { throw const ApiException('Token expirado, mas não foi possível removê-lo do armazenamento seguro.'); }
        throw const ApiException('Sua sessão expirou. Entre novamente.', 401);
      }
      final data = _decode(response);
      if (response.statusCode != 200) throw ApiException(data['message']?.toString() ?? 'Falha ao consultar os dados.', response.statusCode);
      final user = data['data'];
      if (user is! Map<String, dynamic>) throw const ApiException('Dados do usuário inválidos.');
      try { return AuthUser.fromJson(user); }
      on TypeError { throw const ApiException('Os dados do usuário recebidos da API são inválidos.'); }
    } on ApiException { rethrow; }
      on http.ClientException { throw const ApiException('Servidor indisponível.'); }
      on TimeoutException { throw const ApiException('Tempo de conexão esgotado.'); }
      on Exception catch (e) { if (e.toString().contains('TimeoutException')) throw const ApiException('Tempo de conexão esgotado.'); rethrow; }
  }

  Future<void> logout() async {
    try { await _storage.delete(key: _tokenKey); }
    catch (_) { throw const ApiException('Falha ao limpar a sessão do armazenamento seguro.'); }
  }
  Future<String?> readToken() async {
    try { return await _storage.read(key: _tokenKey); }
    catch (_) { throw const ApiException('Falha ao ler o armazenamento seguro.'); }
  }
}
