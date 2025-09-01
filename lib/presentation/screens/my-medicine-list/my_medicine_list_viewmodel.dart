import 'package:flutter/material.dart';
import 'package:remedio_certeiro/data/models/medicine_model.dart';
import 'package:remedio_certeiro/data/repositories/i_medicine_repository.dart';

class MyMedicineListViewModel extends ChangeNotifier {
  final IMedicineRepository repository;
  List<MedicineModel> _medicines = [];
  bool _isLoading = false;
  String? _errorMessage;
  int _intervalHours = 8;

  MyMedicineListViewModel(this.repository);

  List<MedicineModel> get medicines => _medicines;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get intervalHours => _intervalHours;

  void setIntervalHours(int newHours) {
    _intervalHours = newHours;
    notifyListeners();
  }

  Future<void> fetchMedicines() async {
    _isLoading = true;
    notifyListeners();
    try {
      _medicines = await repository.fetchMedicines();
    } catch (e) {
      _errorMessage = 'Erro: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteMedicine(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await repository.deleteMedicine(id);
      _medicines.removeWhere((medicine) => medicine.id == id);
    } catch (e) {
      _errorMessage = 'Erro ao deletar medicamento: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveMedicineHour(String name, DateTime doseTime) async {
    await repository.saveMedicineHour(name, doseTime);
  }
}
