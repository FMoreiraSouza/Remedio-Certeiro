import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:remedio_certeiro/api-setup/app_write_service.dart';

class MedicineRegisterController extends ChangeNotifier {
  final AppWriteService _appWriteService = AppWriteService();
  List<String> pharmaceuticalForms = [];
  List<String> therapeuticCategories = [];

  // Método para carregar os dados do banco
  Future<void> loadData() async {
    try {
      // Recuperando as formas farmacêuticas
      final formsResponse = await _appWriteService.database.listDocuments(
        databaseId: "67944210001fd099f8bc",
        collectionId: "67983990002f46e18dc2",
      );
      pharmaceuticalForms =
          formsResponse.documents.map((doc) => doc.data['name'] as String).toList();

      // Recuperando as classes terapêuticas
      final categoriesResponse = await _appWriteService.database.listDocuments(
        databaseId: "67944210001fd099f8bc",
        collectionId: "679839650029fc39778e",
      );
      therapeuticCategories =
          categoriesResponse.documents.map((doc) => doc.data['name'] as String).toList();

      notifyListeners();
    } catch (e) {
      print('Erro ao carregar dados: $e');
    }
  }
}
