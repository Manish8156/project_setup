import 'package:flutter_test/flutter_test.dart';
import 'package:project_setup/layers/data/models/auth_models/request_models/login_request.dart';
import 'package:project_setup/layers/data/models/auth_models/response_models/login_response_data.dart';

void main() {
  final loginRequest = LoginRequest(email: "test@gmail.com", password: "test@123");
  final loginResponseData = LoginResponseData(
      id: 1,
      firstName: "test",
      lastName: "case",
      profileImage: "test.png",
      countryCode: "+91",
      countryNumber: "+91",
      dob: "27/10/1998",
      email: "test@gmail.com");

  group(
    "should containing proper data of loginRequest for fromJson and toJson ",
    () {
      test(
        "should return a JSON map containing the proper data",
        () async {
          //act
          final result = loginRequest.toJson();
          // assert
          final expectedMap = {"email": "test@gmail.com", "password": "test@123"};
          expect(result, expectedMap);
        },
      );

      test(
        "should return a valid LoginRequest object from JSON map",
        () {
          //arrange
          final Map<String, dynamic> value = {"email": "test@gmail.com", "password": "test@123"};
          //act
          final result = LoginRequest.fromJson(value);
          //assert
          expect(result, isA<LoginRequest>());
          expect(result.email, "test@gmail.com");
          expect(result.password, "test@123");
        },
      );
    },
  );

  group(
    "should containing proper data of loginResponseData for fromJson and toJson",
    () {
      test(
        "should return a JSON map containing the proper data",
        () async {
          //act
          final result = loginResponseData.toJson();
          // assert
          final expectedMap = {
            "id": 1,
            "first_name": "test",
            "last_name": "case",
            "profile_image": "test.png",
            'country_code': "+91",
            "country_number": "+91",
            "dob": "27/10/1998",
            "email": "test@gmail.com"
          };
          expect(result, expectedMap);
        },
      );

      test(
        "should return a valid loginResponseData object from JSON map",
        () {
          //arrange
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
          //act
          final result = LoginResponseData.fromJson(value);
          //assert
          expect(result, isA<LoginResponseData>());
          expect(result.id, 1);
          expect(result.firstName, "test");
          expect(result.lastName, "case");
          expect(result.profileImage, "test.png");
          expect(result.countryCode, "+91");
          expect(result.countryNumber, "+91");
          expect(result.dob, "27/10/1998");
          expect(result.email, "test@gmail.com");
        },
      );
    },
  );
}
