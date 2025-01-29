import 'package:flutter/material.dart';
import 'package:remedio_certeiro/api-setup/app_write_service.dart';

class MyMedicineListController extends ChangeNotifier {
  final AppWriteService _appWriteService;

  List<Map<String, dynamic>> _medicines = [];
  bool _isLoading = false;
  String? _errorMessage;

  MyMedicineListController(this._appWriteService);

  List<Map<String, dynamic>> get medicines => _medicines;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchMedicines() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _appWriteService.database.listDocuments(
        databaseId: '67944210001fd099f8bc',
        collectionId: '679989e700274100acf1',
      );
      _medicines = response.documents.map((doc) => doc.data).toList();
    } catch (e) {
      _errorMessage = 'Erro: $e';
    }

    _isLoading = false;
    notifyListeners();
  }
}
