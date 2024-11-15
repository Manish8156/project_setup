import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:project_setup/core/network/network_info.dart';

class MockNetWorkInfoTest extends Mock implements Connectivity {}

void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockNetWorkInfoTest mockNetWorkInfoTest;

  setUp(
    () {
      mockNetWorkInfoTest = MockNetWorkInfoTest();
      networkInfoImpl = NetworkInfoImpl(connectivity: mockNetWorkInfoTest);
    },
  );

  test('check connectivity for different network types', () async {
    final connectivityResults = [
      ConnectivityResult.wifi, // Connected to Wi-Fi
      ConnectivityResult.mobile, // Connected to mobile data
      ConnectivityResult.none, // No connection
    ];

    final expectedResults = [true, true, false]; // Expected bool results for each case

    for (int i = 0; i < connectivityResults.length; i++) {
      // Mock the checkConnectivity method to return a List of ConnectivityResult
      when(mockNetWorkInfoTest.checkConnectivity()).thenAnswer(
        (_) async => [connectivityResults[i]], // Return a List<ConnectivityResult>
      );

      // Act: Call the method that checks for internet connection
      final result = await networkInfoImpl.isConnected;

      // Assert: Check if the result matches the expected bool value
      expect(result, expectedResults[i]);
    }
  });
}
