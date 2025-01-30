import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/api-setup/app_write_service.dart';
import 'package:remedio_certeiro/components/my-medicine-list/controllers/my_medicine_list_controller.dart';

class MedicineRegisterController extends ChangeNotifier {
  final AppWriteService _appWriteService;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  final TextEditingController purposeController = TextEditingController();
  final TextEditingController useModeController = TextEditingController();
  final TextEditingController intervalController = TextEditingController();
  List<String> pharmaceuticalForms = [];
  List<String> therapeuticCategories = [];
  String? selectedPharmaceuticalForm;
  String? selectedTherapeuticCategory;
  DateTime? expirationDate;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  MedicineRegisterController(this._appWriteService);

  void setExpirationDate(DateTime pickedDate) {
    expirationDate = pickedDate;
    notifyListeners();
  }

  // Método para atualizar o intervalo e o valor no controlador
  void setIntervalHours(int interval) {
    intervalController.text = interval.toString();
    notifyListeners(); // Para atualizar a UI
  }

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

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      throw ('Erro ao carregar dados: $e');
    }
  }

  void clearData() {
    nameController.clear();
    dosageController.clear();
    purposeController.clear();
    useModeController.clear();
    intervalController.clear();
  }

  void clearExpirationDate() {
    expirationDate = null;
  }

  Future<void> saveMedicine(
    BuildContext context,
  ) async {
    final medicineController = Provider.of<MyMedicineListController>(context, listen: false);

    _isLoading = true;
    notifyListeners();
    try {
      await _appWriteService.database.createDocument(
        databaseId: "67944210001fd099f8bc",
        collectionId: "679989e700274100acf1",
        documentId: 'unique()',
        data: {
          'name': nameController.text,
          'dosage': dosageController.text,
          'purpose': purposeController.text,
          'useMode': useModeController.text,
          'interval': int.parse(intervalController.text),
          'pharmaceuticalForm': selectedPharmaceuticalForm,
          'therapeuticCategory': selectedTherapeuticCategory,
          'expirationDate': expirationDate?.toIso8601String(),
        },
      );

      _isLoading = false;
      notifyListeners();

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
                  medicineController.fetchMedicines();
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
