import 'package:flutter/material.dart';
import 'package:remedio_certeiro/api-setup/app_write_service.dart';

class MedicineRegisterController extends ChangeNotifier {
  final AppWriteService _appWriteService = AppWriteService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  List<String> pharmaceuticalForms = [];
  List<String> therapeuticCategories = [];
  String? selectedPharmaceuticalForm; // Variável para armazenar a forma farmacêutica selecionada
  String?
      selectedTherapeuticCategory; // Variável para armazenar a categoria terapêutica selecionada
  DateTime? expirationDate;

  bool isLoading = true;

  Future<void> loadData() async {
    try {
      final formsResponse = await _appWriteService.database.listDocuments(
        databaseId: "67944210001fd099f8bc",
        collectionId: "67983990002f46e18dc2",
      );
      pharmaceuticalForms =
          formsResponse.documents.map((doc) => doc.data['name'] as String).toList();

      final categoriesResponse = await _appWriteService.database.listDocuments(
        databaseId: "67944210001fd099f8bc",
        collectionId: "679839650029fc39778e",
      );
      therapeuticCategories =
          categoriesResponse.documents.map((doc) => doc.data['name'] as String).toList();

      isLoading = false;
      notifyListeners();
    } catch (e) {
      throw ('Erro ao carregar dados: $e');
    }
  }

  Future<void> saveMedicine(BuildContext context) async {
    try {
      await _appWriteService.database.createDocument(
        databaseId: "67944210001fd099f8bc",
        collectionId: "679989e700274100acf1",
        documentId: 'unique()',
        data: {
          'name': nameController.text,
          'dosage': dosageController.text,
          'quantity': int.parse(quantityController.text),
          'pharmaceuticalForm': selectedPharmaceuticalForm,
          'therapeuticCategory': selectedTherapeuticCategory,
          'expiration': expirationDate?.toIso8601String(),
        },
      );

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 50,
            ),
            content: const Text(
              'Cadastro realizado com sucesso!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      throw ('Erro ao salvar medicamento: $e');
    }
  }
}
