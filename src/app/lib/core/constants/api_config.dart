/// Configure com --dart-define=API_BASE_URL=https://seu-dominio.com
/// Android Emulator: http://10.0.2.2:3000 | Web/Linux/iOS Simulator: http://localhost:3000
class ApiConfig {
  ApiConfig._();
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:3000',
  );
  static const Duration timeout = Duration(seconds: 12);
}
