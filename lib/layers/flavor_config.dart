// enum FlavorEnvironment { development, staging, production }
//
// /// [FlavorsConfig] singleton class to initialize the flavors configuration.
// class FlavorsConfig {
//   static FlavorsConfig? _instance;
//   final FlavorEnvironment environment;
//   final String baseUrl;
//
//   factory FlavorsConfig({
//     required FlavorEnvironment environment,
//     required String baseUrl,
//   }) =>
//       _instance ??= FlavorsConfig._(environment, baseUrl);
//
//   FlavorsConfig._(this.environment, this.baseUrl);
//
//   static FlavorsConfig? get instance => _instance;
// }
