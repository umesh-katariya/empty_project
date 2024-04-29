import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;

import '../logger/app_logger.dart';

class SocketHelper {
  String url;
  late socket_io.Socket _socket;

  SocketHelper(this.url, {String? token}) {
    /*_socket = IO.io(url, <String, dynamic>{
      'transports': ['websocket'],
      'upgrade': false
    });*/

    final options = socket_io.OptionBuilder()
        .setTransports(['websocket'])
        .setPath("/ws/chat")
        .setAuth({"token": "$token"})
        // .disableAutoConnect()
        // .setExtraHeaders(
        // {'Authorization': 'Bearer ${AppService.authToken}'})
        .build();
    _socket = socket_io.io(url, options);
  }

  socket_io.Socket get socket => _socket;

  void connect(
      {final VoidCallback? onConnecting,
      final VoidCallback? onConnect,
      final Function(dynamic)? onConnectError,
      final Function(dynamic)? onConnectTimeout,
      final VoidCallback? onReconnect,
      final VoidCallback? onDisconnect,
      final String? token}) {
    if (!_socket.connected) {
      try {
        if (token != null) {
          _socket.auth = {"token": token};
        }
      } on Exception catch (e) {
        AppLog.e(e);
      }
      _socket.connect();
    } else {
      if (kDebugMode) {
        print('Socket connected From Helper');
      }
      if (onConnect != null) onConnect();
    }

    if (onConnecting != null) {
      _socket.onConnecting((final data) => onConnecting());
    }

    if (onConnect != null) {
      _socket.onConnect((final data) => onConnect());
    }

    if (onConnectError != null) {
      _socket.onConnectError(onConnectError);
    }

    if (onConnectTimeout != null) {
      _socket.onConnectTimeout(onConnectTimeout);
    }

    if (onReconnect != null) {
      _socket.onReconnect((final data) => onReconnect());
    }

    if (onDisconnect != null) {
      _socket.onDisconnect((final data) => onDisconnect());
    }
  }

  void disconnect({final VoidCallback? onDisconnect}) {
    if (_socket.connected) {
      _socket.disconnect();
      if (onDisconnect != null) {
        _socket.onDisconnect((final data) => onDisconnect());
      }
    }
  }

  bool isConnected() {
    return _socket.connected;
  }

  void dispose() {
    _socket.dispose();
  }

  void destroy() {
    _socket.destroy();
  }

  void listenEvent(final String event, final Function(dynamic) handler) {
    _socket.on(event, handler);
  }

  void offListenEvent(
    final String event,
  ) {
    _socket.off(event);
  }

  void emitData(final String event, [final dynamic data]) {
    if (_socket.connected) {
      _socket.emit(event, data);
    }
  }
}

class SocketEvents {
  static const String registerFCMToken = 'registerFCMToken';
}
