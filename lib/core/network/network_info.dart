import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';

/// TODO: todo23 - create Folder network and NetworkInfo class

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}