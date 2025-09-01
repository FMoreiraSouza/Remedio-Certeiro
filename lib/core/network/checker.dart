import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:remedio_certeiro/core/constants/texts.dart';

class Checker {
  // Verifica a conectividade de rede antes de operações
  static Future<void> checkNetworkConnectivity({String? context}) async {
    final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
    log('Connectivity check: $connectivityResult');
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw const SocketException('No network connection available',
          osError: OSError(Texts.noConnection));
    }
  }
}
