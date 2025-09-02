import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remedio_certeiro/core/network/checker.dart';
import 'package:remedio_certeiro/core/states/base_viewmodel.dart';
import 'package:remedio_certeiro/core/constants/texts.dart';
import 'package:remedio_certeiro/core/utils/alarm_service.dart';
import 'package:remedio_certeiro/core/utils/notifications.dart';
import 'package:remedio_certeiro/data/repositories/i_medicine_repository.dart';
import 'package:remedio_certeiro/core/utils/failure_handler.dart';

class HomeViewModel extends BaseViewModel {
  final IMedicineRepository repository;
  List<Map<String, dynamic>> _medicineHours = [];
  final Map<int, bool> _loadingStates = {};
  final Map<int, bool> _renewingStates = {};
  Timer? _fetchTimer;
  final Set<int> _notifiedMedicines = {};
  final Set<int> _alarmedMedicines = {};
  int _lastCheckedSecond = -1;

  HomeViewModel(this.repository) {
    _startFetchTimer();
  }

  List<Map<String, dynamic>> get medicineHours => _medicineHours;
  Map<int, bool> get loadingStates => _loadingStates;
  Map<int, bool> get renewingStates => _renewingStates;

  Future<void> fetchMedicineHours({bool isFirstFetch = false}) async {
    try {
      if (isFirstFetch) {
        setLoading(isFirstLoad: true);
      }

      try {
        await Checker.checkNetworkConnectivity(context: 'fetch');
      } catch (e) {
        final errorMessage = FailureHandler.handleException(e, context: 'fetch');
        if (errorMessage == Texts.noConnection) {
          setNoConnection(errorMessage);
          _medicineHours = await repository.fetchMedicineHours();
          if (_medicineHours.isNotEmpty) {
            setSuccess();
          }
          return;
        }
      }

      await Future.delayed(const Duration(seconds: 2));
      _medicineHours = await repository.fetchMedicineHours();

      if (_medicineHours.isEmpty) {
        setEmpty();
      } else {
        setSuccess();
      }
    } catch (e) {
      final errorMessage = FailureHandler.handleException(e, context: 'fetch');
      if (errorMessage == Texts.noConnection) {
        setNoConnection(errorMessage);
      } else {
        setError(errorMessage);
      }
    }
  }

  Future<void> deleteMedicine(int id) async {
    _loadingStates[id] = true;
    notifyListeners();

    try {
      await repository.deleteMedicineHour(id);
      await fetchMedicineHours();
      AlarmService.stopAlarm();
    } catch (e) {
      final errorMessage = FailureHandler.handleException(e, context: 'delete');
      _showToast(errorMessage);
      if (errorMessage == Texts.noConnection) {
        setNoConnection(errorMessage);
      } else {
        setError(errorMessage);
      }
    } finally {
      _loadingStates[id] = false;
      notifyListeners();
    }
  }

  Future<void> renewDosage(int id, String name) async {
    _renewingStates[id] = true;
    notifyListeners();

    try {
      await repository.renewDosage(id, name);
      await fetchMedicineHours();
      AlarmService.stopAlarm();

      _notifiedMedicines.remove(id);
      _alarmedMedicines.remove(id);
    } catch (e) {
      final errorMessage = FailureHandler.handleException(e, context: 'save');
      _showToast(errorMessage);
      if (errorMessage == Texts.noConnection) {
        setNoConnection(errorMessage);
      } else {
        setError(errorMessage);
      }
    } finally {
      _renewingStates[id] = false;
      notifyListeners();
    }
  }

  void checkNotifications() {
    final now = DateTime.now();
    final currentSecond = now.second;

    if (currentSecond == _lastCheckedSecond) {
      return;
    }

    _lastCheckedSecond = currentSecond;

    for (var medicine in _medicineHours) {
      final int medicineId = medicine['id'];
      final nextDoseTime = DateTime.parse(medicine['nextDoseTime']);
      final difference = nextDoseTime.difference(now);
      final totalSeconds = difference.inSeconds;

      if (totalSeconds == 330) {
        if (!_notifiedMedicines.contains(medicineId)) {
          NotificationService.showNotification(medicine['name']);
          _notifiedMedicines.add(medicineId);
        }
      }

      if (totalSeconds == 30) {
        if (!_alarmedMedicines.contains(medicineId)) {
          AlarmService.playAlarm();
          _alarmedMedicines.add(medicineId);
        }
      }

      if (totalSeconds < 0 || totalSeconds > 300) {
        if (_notifiedMedicines.contains(medicineId)) {
          _notifiedMedicines.remove(medicineId);
        }
        if (_alarmedMedicines.contains(medicineId)) {
          _alarmedMedicines.remove(medicineId);
        }
      }
    }
  }

  void _startFetchTimer() {
    _fetchTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      checkNotifications();
    });

    Timer.periodic(const Duration(seconds: 30), (timer) {
      fetchMedicineHours();
    });
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  void dispose() {
    _fetchTimer?.cancel();
    super.dispose();
  }
}
