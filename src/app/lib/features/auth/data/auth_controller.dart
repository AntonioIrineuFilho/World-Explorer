import 'package:flutter/foundation.dart';
import 'auth_service.dart';
import 'auth_user.dart';

class AuthController extends ChangeNotifier {
  final AuthService _service = AuthService();
  AuthUser? user;
  bool isLoading = false;
  String? errorMessage;
  bool get isAuthenticated => user != null;

  Future<void> login(String email, String password) async {
    isLoading = true; errorMessage = null; notifyListeners();
    try { user = await _service.login(email: email, password: password); }
    catch (e) { errorMessage = e.toString(); rethrow; }
    finally { isLoading = false; notifyListeners(); }
  }

  Future<void> register(String name, String email, String password) =>
      _service.register(name: name, email: email, password: password);

  Future<void> loadProfile() async {
    isLoading = true; notifyListeners();
    try { user = await _service.fetchMe(); }
    catch (error) {
      if (error is ApiException && error.statusCode == 401) {
        user = null;
        try { await _service.logout(); } catch (_) {}
      }
      rethrow;
    }
    finally { isLoading = false; notifyListeners(); }
  }

  Future<void> logout() async {
    await _service.logout(); user = null; errorMessage = null; notifyListeners();
  }
}
