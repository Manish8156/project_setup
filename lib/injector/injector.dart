import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:project_setup/core/network/dio_client.dart';
import 'package:project_setup/core/network/network_info.dart';
import 'package:project_setup/core/network/retrofit_api_client.dart';
import 'package:project_setup/core/utils/app_common_imports.dart';
import 'package:project_setup/core/utils/hive_helper.dart';
import 'package:project_setup/layers/data/models/auth_models/response_models/login_response_data.dart';
import 'package:project_setup/layers/data/repositories_impl/auth_repository_impl/auth_repository_impl.dart';
import 'package:project_setup/layers/domain/repositories/auth_repository/auth_repository.dart';
import 'package:project_setup/layers/domain/usecases/auth_usecases/login_use_case.dart';

import '../core/utils/fcm_helper.dart';

GetIt sl = GetIt.instance;

abstract class Injector {
  static Future setUp() async {
    await registerLocalCache();
    _registerNetworkModules();
    _registerMiscModules();
    _registerRepositories();
    _registerUseCases();
    _registerBlocs();
  }

  static Future<void> _registerMiscModules() async {
    sl.registerLazySingleton(() => AppTheme());
    sl.registerLazySingleton(() => FCMHelper());
  }

  static Future<void> registerLocalCache() async {
    sl.registerSingleton(
      HiveAppRepository(
        loginResponseDataHiveRepo: EncryptedHiveDataRepository<LoginResponseData>(
          boxKey: HiveEntityKeys.loggedInUser.value,
        ),
        fcmTokenValue: EncryptedHiveDataRepository<String>(
          boxKey: HiveEntityKeys.fcmToken.value,
        ),
      ),
    );
  }

  static void _registerNetworkModules() {
    sl.registerSingleton(Connectivity());
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectivity: sl()));
    sl.registerSingleton(AuthInterceptor());
    sl.registerLazySingleton<Dio>(() => DioClient.getInstance());
    sl.registerLazySingleton(() => RetrofitApiClient(dio: sl()));
  }

  static void _registerRepositories() {
    sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(retrofitApiClient: sl()));
  }

  static void _registerUseCases() {
    /// Auth usecases
    sl.registerLazySingleton(() => LoginUseCase(authRepository: sl()));
  }

  static void _registerBlocs() {
    /// register blocs
  }
}
