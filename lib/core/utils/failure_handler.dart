import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:appwrite/appwrite.dart';
import 'package:remedio_certeiro/core/constants/texts.dart';

class FailureHandler {
  // Converte exceções em mensagens amigáveis
  static String handleException(dynamic exception, {String? context}) {
    log('Exception: ${exception.runtimeType} - $exception'); // Debug

    if (exception is SocketException) {
      return Texts.noConnection;
    } else if (exception is TimeoutException) {
      return Texts.timeoutError;
    } else if (exception is AppwriteException) {
      return _handleAppwriteException(exception, context: context);
    } else if (exception is String) {
      return exception; // Já é uma mensagem amigável
    } else {
      return _getGenericError(context);
    }
  }

  // Converte AppwriteException em exceções específicas
  static dynamic handleAppwriteException(AppwriteException e) {
    // Como checkNetworkConnectivity está no NetworkChecker, mantemos a exceção original
    return e;
  }

  // Trata exceções específicas do Appwrite
  static String _handleAppwriteException(AppwriteException e, {String? context}) {
    log('AppwriteException: code=${e.code}, message=${e.message}'); // Debug
    switch (e.code) {
      case 401:
        return Texts.invalidCredentials;
      case 404:
        return Texts.documentNotFound;
      case 409:
        return 'Conflito: ${e.message}';
      case 500:
      case 502:
      case 503:
        return Texts.serverError;
      default:
        return _getGenericError(context);
    }
  }

  // Retorna mensagem de erro genérica baseada no contexto
  static String _getGenericError(String? context) {
    switch (context) {
      case 'fetch':
        return Texts.fetchError;
      case 'save':
        return Texts.saveError;
      case 'delete':
        return Texts.deleteError;
      case 'login':
        return Texts.loginError;
      case 'logout':
        return Texts.logoutError;
      case 'register':
        return Texts.errorRegister;
      case 'loadData':
        return Texts.loadDataError;
      default:
        return Texts.genericError;
    }
  }

  // Método para lançar exceções convertidas (para usar nos repositórios)
  static dynamic convertAppwriteException(AppwriteException e) {
    // Como checkNetworkConnectivity está no NetworkChecker, mantemos a exceção original
    return e;
  }
}
