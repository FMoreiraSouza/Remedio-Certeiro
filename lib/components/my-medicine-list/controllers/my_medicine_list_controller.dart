import 'package:appwrite/models.dart' as appwrite;
import 'package:flutter/material.dart';
import 'package:remedio_certeiro/api-setup/app_write_service.dart';
import 'package:remedio_certeiro/database/database_helper.dart';
import 'package:remedio_certeiro/models/medicine_model.dart';

class MyMedicineListController extends ChangeNotifier {
  MyMedicineListController(this._appWriteService);

  final AppWriteService _appWriteService;

  List<MedicineModel> _medicines = [];
  List<MedicineModel> get medicines => _medicines;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int _intervalHours = 8;
  int get intervalHours => _intervalHours;

  void setIntervalHours(int newHours) {
    _intervalHours = newHours;
    notifyListeners();
  }

  Future<void> saveMedicine(String name, DateTime doseTime) async {
    await DatabaseHelper.instance.saveMedicineHour(
      name,
      doseTime,
    );
  }

  Future<void> fetchMedicines() async {
    _isLoading = true;
    notifyListeners();
    _errorMessage = null;

    try {
      final appwrite.DocumentList response = await _appWriteService.database.listDocuments(
        databaseId: '67944210001fd099f8bc',
        collectionId: '679989e700274100acf1',
      );

      // Converte cada documento para um objeto MedicineModel
      _medicines = response.documents.map((doc) => MedicineModel.fromMap(doc.data)).toList();
    } catch (e) {
      _errorMessage = 'Erro: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteMedicine(String documentId) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _appWriteService.database.deleteDocument(
        databaseId: '67944210001fd099f8bc',
        collectionId: '679989e700274100acf1',
        documentId: documentId,
      );

      _medicines.removeWhere((medicine) => medicine.id == documentId);
    } catch (e) {
      _errorMessage = 'Erro ao deletar medicamento: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
