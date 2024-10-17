import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl extends NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl({
    required this.connectivity,
  });

  @override
  Future<bool> get isConnected => connectivity.checkConnectivity().then(
        (value) {
          return value.any(
            (element) => [
              ConnectivityResult.mobile,
              ConnectivityResult.wifi,
              ConnectivityResult.ethernet,
              ConnectivityResult.vpn,
            ].contains(element),
          );
        },
      );
}
