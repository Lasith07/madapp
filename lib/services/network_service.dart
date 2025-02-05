// lib/services/network_service.dart
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkService with ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  String _connectionStatus = 'Unknown';

  String get connectionStatus => _connectionStatus;

  NetworkService() {
    _checkInitialConnection();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _checkInitialConnection() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        _connectionStatus = 'Connected to Wi-Fi';
        break;
      case ConnectivityResult.mobile:
        _connectionStatus = 'Connected to Mobile Data';
        break;
      case ConnectivityResult.none:
        _connectionStatus = 'No Internet Connection';
        break;
      default:
        _connectionStatus = 'Unknown Connection';
    }
    notifyListeners();  // Notifies widgets listening to this service
  }
}
