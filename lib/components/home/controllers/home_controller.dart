import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:remedio_certeiro/api-setup/app_write_service.dart';
import 'package:remedio_certeiro/database/database_helper.dart';

class HomeController extends ChangeNotifier {
  HomeController(this._appWriteService);
  final AppWriteService _appWriteService;

  Map<int, bool> loadingStates =
      {}; // Mapa para controlar o estado de carregamento de cada medicamento

  bool get isLoading => loadingStates.isNotEmpty && loadingStates.values.contains(true);

  List<Map<String, dynamic>> _medicineHours = [];

  List<Map<String, dynamic>> get medicineHours => _medicineHours;

  // Função para buscar os horários dos remédios
  Future<void> fetchMedicineHours() async {
    await Future.delayed(const Duration(seconds: 2)); // Simula um atraso

    _medicineHours = await DatabaseHelper.instance.fetchMedicineHours();
    _medicineHours =
        _medicineHours.map((e) => Map<String, dynamic>.from(e)).toList(); // Força mutabilidade

    notifyListeners();
  }

  // Função para deletar medicamento
  Future<void> deleteMedicine(int id) async {
    loadingStates[id] = true;
    notifyListeners();

    await DatabaseHelper.instance.deleteMedicine(id);
    await fetchMedicineHours();

    loadingStates[id] = false;
    notifyListeners();
  }

  Future<void> renewDosage(int medicineId, String medicineName) async {
    try {
      final response = await _appWriteService.database.listDocuments(
        databaseId: '67944210001fd099f8bc',
        collectionId: '679989e700274100acf1',
        queries: [Query.equal('name', medicineName)],
      );

      if (response.documents.isNotEmpty) {
        final documentId = response.documents.first.$id;

        final document = await _appWriteService.database.getDocument(
          databaseId: '67944210001fd099f8bc',
          collectionId: '679989e700274100acf1',
          documentId: documentId,
        );

        int interval = document.data['interval'] ?? 0; // Evita null
        final doseTime = DateTime.now().add(Duration(minutes: interval));
        // Aqui você precisa atualizar o tempo da dose no banco de dados

        await DatabaseHelper.instance.updateMedicineNextDoseTime(medicineId, doseTime);

        await fetchMedicineHours(); // Atualiza a lista de medicamentos na tela

        notifyListeners();
      } else {
        print('Nenhum documento encontrado para o medicamento: $medicineName');
      }
    } catch (e) {
      print('Erro ao buscar documento: $e');
    }
  }
}
