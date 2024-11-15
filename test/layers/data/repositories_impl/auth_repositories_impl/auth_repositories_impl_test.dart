import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:project_setup/core/network/retrofit_api_client.dart';
import 'package:project_setup/layers/data/models/auth_models/request_models/login_request.dart';
import 'package:project_setup/layers/data/models/auth_models/response_models/login_response_data.dart';
import 'package:project_setup/layers/data/models/base_response_model.dart';
import 'package:project_setup/layers/data/models/meta.dart';
import 'package:project_setup/layers/data/repositories_impl/auth_repository_impl/auth_repository_impl.dart';
import 'package:retrofit/dio.dart';

class MockRetrofitClient extends Mock implements RetrofitApiClient {}

void main() {
  LoginRequest loginRequest = LoginRequest(email: "test@gmail.com", password: "test@123");

  final Map<String, dynamic> value = {
    "id": 1,
    "first_name": "test",
    "last_name": "case",
    "profile_image": "test.png",
    'country_code': "+91",
    "country_number": "+91",
    "dob": "27/10/1998",
    "email": "test@gmail.com"
  };
  final expected = HttpResponse<BaseResponseModel<LoginResponseData>>(
    BaseResponseModel.fromJson(
      value,
      (value) => LoginResponseData.fromJson(value as Map<String, dynamic>),
    ),
    Response(
      requestOptions: RequestOptions(),
    ),
  );
  late AuthRepositoryImpl authRepositoryImpl;
  late MockRetrofitClient mockRetrofitClient;

  setUp(
    () {
      mockRetrofitClient = MockRetrofitClient();
      authRepositoryImpl = AuthRepositoryImpl(retrofitApiClient: mockRetrofitClient);
    },
  );

  test(
    "Should return a LoginResponseData object when the user logs in with valid credentials",
    () {
      //arrange
      when(mockRetrofitClient.login(loginRequest)).thenAnswer((_) async => expected);
      //act
      final result = authRepositoryImpl.login(loginRequest: loginRequest);
      //assert
      verify(mockRetrofitClient.login(loginRequest));
      expect(result, isNotNull);
    },
  );
}
