import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remedio_certeiro/core/states/base_viewmodel.dart';
import 'package:remedio_certeiro/core/constants/texts.dart';
import 'package:remedio_certeiro/data/models/medicine_model.dart';
import 'package:remedio_certeiro/data/repositories/i_medicine_repository.dart';
import 'package:remedio_certeiro/core/utils/failure_handler.dart';

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
    } catch (e) {
      final errorMessage = FailureHandler.handleException(e, context: 'fetch');

      if (errorMessage == Texts.noConnection) {
        setNoConnection(errorMessage);
      } else {
        setError(errorMessage);
      }
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
      _showToast('Medicamento excluído com sucesso!');
    } catch (e) {
      final errorMessage = FailureHandler.handleException(e, context: 'delete');
      _showToast(errorMessage);

      if (errorMessage == Texts.noConnection) {
        setNoConnection(errorMessage);
      } else {
        setError(errorMessage);
      }
    }
  }

  Future<void> saveMedicineHour(String name, DateTime doseTime) async {
    try {
      await repository.saveMedicineHour(name, doseTime);
      _showToast('Horário de medicamento salvo!');
    } catch (e) {
      final errorMessage = FailureHandler.handleException(e, context: 'save');
      _showToast(errorMessage);
      throw errorMessage;
    }
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
}
