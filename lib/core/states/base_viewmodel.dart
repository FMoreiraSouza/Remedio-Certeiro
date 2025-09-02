import 'package:flutter/foundation.dart';
import 'package:remedio_certeiro/core/states/view_state_enum.dart';

class BaseViewModel with ChangeNotifier {
  ViewStateEnum _state = ViewStateEnum.loading;
  String? _errorMessage;
  bool _isFirstLoad = true;

  ViewStateEnum get state => _state;
  String? get errorMessage => _errorMessage;
  bool get isFirstLoad => _isFirstLoad;
  bool get isLoading => _state == ViewStateEnum.loading;
  bool get isSuccess => _state == ViewStateEnum.success;
  bool get isEmpty => _state == ViewStateEnum.empty;
  bool get hasError => _state == ViewStateEnum.error;
  bool get noConnection => _state == ViewStateEnum.noConnection;

  void setLoading({bool isFirstLoad = false}) {
    _state = ViewStateEnum.loading;
    _isFirstLoad = isFirstLoad;
    _errorMessage = null;
    notifyListeners();
  }

  void setSuccess() {
    _state = ViewStateEnum.success;
    _isFirstLoad = false;
    _errorMessage = null;
    notifyListeners();
  }

  void setEmpty() {
    _state = ViewStateEnum.empty;
    _isFirstLoad = false;
    _errorMessage = null;
    notifyListeners();
  }

  void setError(String message) {
    _state = ViewStateEnum.error;
    _isFirstLoad = false;
    _errorMessage = message;
    notifyListeners();
  }

  void setNoConnection(String message) {
    _state = ViewStateEnum.noConnection;
    _isFirstLoad = false;
    _errorMessage = message;
    notifyListeners();
  }
}
