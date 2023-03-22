import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class INetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements INetworkInfo {
  final InternetConnectionChecker internetConnectionChecker;

  const NetworkInfoImpl({
    required this.internetConnectionChecker,
  });

  @override
  Future<bool> get isConnected {
    return internetConnectionChecker.hasConnection;
  }
}
