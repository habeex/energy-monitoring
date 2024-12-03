enum UrlEnvironment { development, staging, production }

class UrlConfig {
  static UrlEnvironment _environment = UrlEnvironment.development;

  static UrlEnvironment get environment => _environment;
  static String baseUrl = "$_baseUrl/";

  static void setEnvironment(UrlEnvironment env) => _environment = env;

  static get _baseUrl {
    switch (_environment) {
      case UrlEnvironment.development:
        return 'http://localhost:3000';
      case UrlEnvironment.staging:
        return 'http://10.0.2.2:3000';
      case UrlEnvironment.production:
        return '';
    }
  }
}
