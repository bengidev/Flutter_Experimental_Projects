import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@immutable
class NetworkInformation {
  final InternetConnectionChecker _internetChecker;

  const NetworkInformation({
    required InternetConnectionChecker internetChecker,
  }) : _internetChecker = internetChecker;

  /// Simple check to see if we have internet connection.
  /// Prints either InternetConnectionStatus.connected
  /// or InternetConnectionStatus.disconnected.
  Future<InternetConnectionStatus> checkInternetConnection() {
    return _internetChecker.connectionStatus;
  }

  /// Listen the connection status through the [Stream] which
  /// contains the value of [InternetConnectionStatus].
  /// This will cause InternetConnectionChecker to check periodically
  /// with the interval specified in InternetConnectionChecker().checkInterval
  /// until listener.cancel() is called.
  Stream<InternetConnectionStatus> listenConnectionStatusUpdates() {
    return _internetChecker.onStatusChange;
  }

  /// Check the availability of the listeners
  /// that attached to the [InternetConnectionChecker].
  bool checkAvailableListeners() {
    return _internetChecker.hasListeners;
  }
}
