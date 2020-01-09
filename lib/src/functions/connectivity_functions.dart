import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';

/// ConnectionChecker used for internet connection listener
class ConnectionChecker {
  DataConnectionChecker _instance;

  getInstance() {
    if (_instance == null) {
      _instance = DataConnectionChecker();
      return this;
    }
    return this;
  }

  setDuration(Duration duration) {
    getInstance();
    _instance.checkInterval = duration;
    return this;
  }

  listener(
      {Function connected, Function disconnected, Function onError}) async {
    getInstance();
    return _instance.onStatusChange.listen(
      (DataConnectionStatus status) {
        switch (status) {
          case DataConnectionStatus.connected:
            print("Connected.");
            connected();
            break;
          case DataConnectionStatus.disconnected:
            print("Disconnected.");
            if (disconnected != null) {
              disconnected();
            }
            break;
        }
      },
      onError: (Object error, [StackTrace stackTrace]) {
        print("Connection Error!");
        if (onError != null) {
          onError(error, stackTrace);
        }
      },
    );
  }
}

/// Instant check internet connection by providing the lookup address default is google.com
Future<bool> checkInternet({lookupAddress: "google.com"}) async {
  bool internet = false;
  try {
    final result = await InternetAddress.lookup(lookupAddress);
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      internet = true;
    }
  } on SocketException catch (_) {
    internet = false;
  }

  return internet;
}
