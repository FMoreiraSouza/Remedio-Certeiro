import 'dart:async';
import 'dart:io';

import 'package:remedio_certeiro/core/states/base_viewmodel.dart';
import 'package:remedio_certeiro/data/models/medicine_model.dart';
import 'package:remedio_certeiro/data/repositories/i_medicine_repository.dart';

class MyMedicineListViewModel extends BaseViewModel {
  final IMedicineRepository repository;
  List<MedicineModel> _medicines = [];
  int _intervalHours = 8;

  MyMedicineListViewModel(this.repository);

  List<MedicineModel> get medicines => _medicines;
  int get intervalHours => _intervalHours;

  void setIntervalHours(int newHours) {
    _intervalHours = newHours;
    notifyListeners();
  }

  Future<void> fetchMedicines({bool isFirstFetch = false}) async {
    try {
      setLoading(isFirstLoad: isFirstFetch);

      _medicines = await repository.fetchMedicines();

      if (_medicines.isEmpty) {
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

  Future<void> deleteMedicine(String id) async {
    try {
      setLoading();

      await repository.deleteMedicine(id);
      _medicines.removeWhere((medicine) => medicine.id == id);

      if (_medicines.isEmpty) {
        setEmpty();
      } else {
        setSuccess();
      }
    } on SocketException catch (e) {
      setNoConnection('Erro de conexão: ${e.message}');
    } on HttpException catch (e) {
      setError('Erro no servidor: ${e.message}');
    } catch (e) {
      setError('Erro ao deletar medicamento: ${e.toString()}');
    }
  }

  Future<void> saveMedicineHour(String name, DateTime doseTime) async {
    try {
      await repository.saveMedicineHour(name, doseTime);
    } catch (e) {
      // Você pode tratar erros específicos aqui
      rethrow;
    }
  }
}
