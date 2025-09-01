import 'dart:async';

import 'package:flutter/material.dart';
import 'package:remedio_certeiro/core/utils/alarm_service.dart';
import 'package:remedio_certeiro/core/utils/notifications.dart';
import 'package:remedio_certeiro/data/repositories/i_medicine_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final IMedicineRepository repository;
  List<Map<String, dynamic>> _medicineHours = [];
  final Map<int, bool> _loadingStates = {};
  final Map<int, bool> _renewingStates = {};
  bool _isFirstLoading = false;
  Timer? _fetchTimer;

  HomeViewModel(this.repository) {
    _startFetchTimer();
  }

  List<Map<String, dynamic>> get medicineHours => _medicineHours;
  Map<int, bool> get loadingStates => _loadingStates;
  Map<int, bool> get renewingStates => _renewingStates;
  bool get isFirstLoading => _isFirstLoading;

  Future<void> fetchMedicineHours({bool isFirstFetch = false}) async {
    if (isFirstFetch) {
      _isFirstLoading = true;
      notifyListeners();
    }
    try {
      await Future.delayed(const Duration(seconds: 2));
      _medicineHours = await repository.fetchMedicineHours();
    } finally {
      if (isFirstFetch) {
        _isFirstLoading = false;
      }
      notifyListeners();
    }
  }

  Future<void> deleteMedicine(int id) async {
    _loadingStates[id] = true;
    notifyListeners();
    try {
      await repository.deleteMedicineHour(id);
      await fetchMedicineHours();
      AlarmService.stopAlarm();
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
    } finally {
      _renewingStates[id] = false;
      notifyListeners();
    }
  }

  void checkNotifications() {
    for (var medicine in _medicineHours) {
      final nextDoseTime = DateTime.parse(medicine['nextDoseTime']);
      final difference = nextDoseTime.difference(DateTime.now());
      if (difference.inMinutes == 5) {
        NotificationService.showNotification(medicine['name']);
      }
      if (nextDoseTime.minute == DateTime.now().minute) {
        AlarmService.playAlarm();
      }
    }
  }

  void _startFetchTimer() {
    _fetchTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      fetchMedicineHours();
      checkNotifications();
    });
  }

  @override
  void dispose() {
    _fetchTimer?.cancel();
    super.dispose();
  }
}
