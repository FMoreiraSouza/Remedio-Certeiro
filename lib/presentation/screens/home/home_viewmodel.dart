import 'dart:async';
import 'dart:io';
import 'package:remedio_certeiro/core/states/base_viewmodel.dart';
import 'package:remedio_certeiro/core/utils/alarm_service.dart';
import 'package:remedio_certeiro/core/utils/notifications.dart';
import 'package:remedio_certeiro/data/repositories/i_medicine_repository.dart';

class HomeViewModel extends BaseViewModel {
  final IMedicineRepository repository;
  List<Map<String, dynamic>> _medicineHours = [];
  final Map<int, bool> _loadingStates = {};
  final Map<int, bool> _renewingStates = {};
  Timer? _fetchTimer;

  HomeViewModel(this.repository) {
    _startFetchTimer();
  }

  List<Map<String, dynamic>> get medicineHours => _medicineHours;
  Map<int, bool> get loadingStates => _loadingStates;
  Map<int, bool> get renewingStates => _renewingStates;

  Future<void> fetchMedicineHours({bool isFirstFetch = false}) async {
    try {
      setLoading(isFirstLoad: isFirstFetch);

      await Future.delayed(const Duration(seconds: 2)); // Simula delay de rede
      _medicineHours = await repository.fetchMedicineHours();

      if (_medicineHours.isEmpty) {
        setEmpty();
      } else {
        setSuccess();
      }
    } on SocketException catch (e) {
      setNoConnection('Erro de conexão: ${e.message}');
    } on HttpException catch (e) {
      setError('Erro no servidor: ${e.message}');
    } on TimeoutException catch (e) {
      setError('Tempo de conexão excedido: ${e.message}');
    } catch (e) {
      setError('Erro inesperado: ${e.toString()}');
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
      // Você pode tratar erros específicos aqui também
      rethrow;
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
    } catch (e) {
      rethrow;
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
