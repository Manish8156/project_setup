import 'package:project_setup/core/globals.dart';
import 'package:project_setup/core/network/apis.dart';
import 'dart:developer' as dev;
import 'package:project_setup/core/utils/hive_helper.dart';
import 'package:socket_io_client/socket_io_client.dart' as sio;

class SocketIOHelper {
  final HiveAppRepository hiveAppRepository;

  SocketIOHelper({
    required this.hiveAppRepository,
  });

  sio.Socket? _socket;

  bool get isSocketConnected => _socket?.connected ?? false;

  Future<void> _initializeSocketIoClient() async {
    try {
      String? deviceId = await getDeviceId();

      /// as of now , we pass the header for an example, header will confirm from backend side , what they required.
      final header = {
        'deviceId': deviceId,

        'deviceType': 'defineYourDeviceType',

        /// <-------- for example, if backEnd required the device type , we have to pass in this header.
        'languageCode': 'defineCurrentLanguageCode'

        /// <-------- for example, if backEnd required the language code , we have to pass in this header.
      };

      String? loggedInUsedToken = await hiveAppRepository.getLoggedInUserToken();
      dev.log('::==>> SIO initializeSocketIOClient loggedInUser Token: $loggedInUsedToken');

      if (loggedInUsedToken != null) {
        header.putIfAbsent('Authorization', () => 'Bearer $loggedInUsedToken');
      }

      _socket = sio.io(
        Apis.baseUrlSocket,
        [
          sio.OptionBuilder()
              .setTransports(['websocket'])
              .enableForceNew()
              .enableForceNewConnection()
              .enableAutoConnect()
              .enableReconnection()
              .setExtraHeaders(header)
              .build(),
        ],
      );

      _socket?.onConnect(_onConnect);
      _socket?.onConnectError(_onConnectError);
      _socket?.onDisconnect(_onDisconnect);
      _socket?.onError(_onError);
      _socket?.onReconnect(_onReconnect);
      _socket?.onReconnectAttempt(_onReconnectAttempt);
      _socket?.onReconnectFailed(_onReconnectFailed);
      _socket?.onReconnectError(_onReconnectError);
      _socket?.onPing(_onPing);
      _socket?.onPong(_onPong);
    } on Exception catch (error) {
      dev.log('::==>> SIO initializeSocketIOClient exception :: $error');
    }
  }

  Future<void> connect() async {
    await _initializeSocketIoClient();
    assert(_socket != null, 'socket Client must be initialized before access it.');

    try {
      _socket?.connect();
    } on Exception catch (e) {
      _socket?.disconnect();
      dev.log('::==>> SIO connect exception :: $e');
    }
  }

  Future<void> disconnect() async {
    try {
      _socket?.disconnect();
      _socket?.dispose();
      _socket = null;
    } on Exception catch (e) {
      dev.log('::==>> SIO disconnect exception :: $e');
    }
  }

  Future<void> reconnect() async {
    try {
      await disconnect();
      await connect();
      dev.log('::==>> SIO reconnect');
    } on Exception catch (e) {
      dev.log('::==>> SIO reconnect exception :: $e');
    }
  }

  void emitAnEvent(
    String event,
    Map<String, dynamic> payload,
  ) {
    try {
      _socket?.emit(event, payload);
      dev.log('::==>> SIO emitAnEvent :: $event :: $payload');
    } on Exception catch (e) {
      dev.log('::==>> SIO emitAnEvent exception :: $e');
    }
  }

  Future<void> listenAnEvent(
    String event,
    Function(dynamic data) callBack,
  ) async {
    try {
      _socket?.on(event, callBack);
      dev.log('::==>> SIO listenAnEvent :: $event');
    } on Exception catch (e) {
      dev.log('::==>> SIO listenAnEvent exception :: $e');
    }
  }

  Future<void> removeAnEvent(
    String event,
  ) async {
    try {
      _socket?.off(event);
      dev.log('::==>> SIO removeAnEvent :: $event');
    } on Exception catch (e) {
      dev.log('::==>> SIO removeAnEvent exception :: $e');
    }
  }

  void _onConnect(data) {
    try {
      dev.log('::==>> SIO _onConnect :: $data');
    } on Exception catch (e) {
      dev.log('::==>> SIO _onConnect exception :: $e');
    }
  }

  void _onConnectError(data) {
    try {
      dev.log('::==>> SIO _onConnectError :: $data');
    } on Exception catch (e) {
      dev.log('::==>> SIO _onConnectError exception :: $e');
    }
  }

  void _onDisconnect(data) {
    try {
      dev.log('::==>> SIO _onDisconnect :: $data');
    } on Exception catch (e) {
      dev.log('::==>> SIO _onDisconnect exception :: $e');
    }
  }

  void _onError(data) {
    try {
      dev.log('::==>> SIO _onError :: $data');
    } on Exception catch (e) {
      dev.log('::==>> SIO _onError exception :: $e');
    }
  }

  void _onReconnect(data) {
    try {
      dev.log('::==>> SIO _onReconnect :: $data');
    } on Exception catch (e) {
      dev.log('::==>> SIO _onReconnect exception :: $e');
    }
  }

  void _onReconnectAttempt(data) {
    try {
      dev.log('::==>> SIO _onReconnectAttempt :: $data');
    } on Exception catch (e) {
      dev.log('::==>> SIO _onReconnectAttempt exception :: $e');
    }
  }

  void _onReconnectFailed(data) {
    try {
      dev.log('::==>> SIO _onReconnectFailed :: $data');
    } on Exception catch (e) {
      dev.log('::==>> SIO _onReconnectFailed exception :: $e');
    }
  }

  void _onReconnectError(data) {
    try {
      dev.log('::==>> SIO _onReconnectError :: $data');
    } on Exception catch (e) {
      dev.log('::==>> SIO _onReconnectError exception :: $e');
    }
  }

  void _onPing(data) {
    try {
      dev.log('::==>> SIO _onPing :: $data');
    } on Exception catch (e) {
      dev.log('::==>> SIO _onPing exception :: $e');
    }
  }

  void _onPong(data) {
    try {
      dev.log('::==>> SIO _onPong :: $data');
    } on Exception catch (e) {
      dev.log('::==>> SIO _onPong exception :: $e');
    }
  }
}
