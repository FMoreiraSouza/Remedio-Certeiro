import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:appwrite/appwrite.dart';
import 'package:remedio_certeiro/core/constants/texts.dart';

class FailureHandler {
  static String handleException(dynamic exception, {String? context}) {
    log('Exception: ${exception.runtimeType} - $exception');

    if (exception is SocketException) {
      return Texts.noConnection;
    } else if (exception is TimeoutException) {
      return Texts.timeoutError;
    } else if (exception is AppwriteException) {
      return _handleAppwriteException(exception, context: context);
    } else if (exception is String) {
      return exception;
    } else {
      return _getGenericError(context);
    }
  }

  static dynamic handleAppwriteException(AppwriteException e) {
    return e;
  }

  static String _handleAppwriteException(AppwriteException e, {String? context}) {
    log('AppwriteException: code=${e.code}, message=${e.message}');
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

  static dynamic convertAppwriteException(AppwriteException e) {
    return e;
  }
}
