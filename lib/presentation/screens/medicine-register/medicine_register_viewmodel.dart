import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/core/constants/texts.dart';
import 'package:remedio_certeiro/data/models/medicine_model.dart';
import 'package:remedio_certeiro/data/repositories/i_medicine_repository.dart';
import 'package:remedio_certeiro/presentation/screens/my-medicine-list/my_medicine_list_viewmodel.dart';
import 'package:remedio_certeiro/core/utils/failure_handler.dart';

class MedicineRegisterViewModel extends ChangeNotifier {
  final IMedicineRepository repository;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  final TextEditingController purposeController = TextEditingController();
  final TextEditingController useModeController = TextEditingController();
  final TextEditingController intervalController = TextEditingController();
  List<String> _pharmaceuticalForms = [];
  List<String> _therapeuticCategories = [];
  String? _selectedPharmaceuticalForm;
  String? _selectedTherapeuticCategory;
  DateTime? _expirationDate;
  bool _isLoading = false;
  String? _errorMessage;

  MedicineRegisterViewModel(this.repository) {
    intervalController.text = '0';
    loadData();
  }

  List<String> get pharmaceuticalForms => _pharmaceuticalForms;
  List<String> get therapeuticCategories => _therapeuticCategories;
  String? get selectedPharmaceuticalForm => _selectedPharmaceuticalForm;
  String? get selectedTherapeuticCategory => _selectedTherapeuticCategory;
  DateTime? get expirationDate => _expirationDate;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  set selectedPharmaceuticalForm(String? value) {
    _selectedPharmaceuticalForm = value;
    notifyListeners();
  }

  set selectedTherapeuticCategory(String? value) {
    _selectedTherapeuticCategory = value;
    notifyListeners();
  }

  void setExpirationDate(DateTime? date) {
    _expirationDate = date;
    notifyListeners();
  }

  void setIntervalHours(int interval) {
    intervalController.text = interval.toString();
    notifyListeners();
  }

  Future<void> loadData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _pharmaceuticalForms = await repository.fetchPharmaceuticalForms();
      _therapeuticCategories = await repository.fetchTherapeuticCategories();
    } catch (e) {
      _errorMessage = FailureHandler.handleException(e, context: 'loadData');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearData() {
    nameController.clear();
    dosageController.clear();
    purposeController.clear();
    useModeController.clear();
    intervalController.text = '0';
    _selectedPharmaceuticalForm = null;
    _selectedTherapeuticCategory = null;
    _expirationDate = null;
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> saveMedicine(BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final medicine = MedicineModel(
        id: 'unique()',
        name: nameController.text,
        dosage: dosageController.text,
        purpose: purposeController.text,
        useMode: useModeController.text,
        interval: int.parse(intervalController.text),
        expirationDate: _expirationDate,
        pharmaceuticalForm: _selectedPharmaceuticalForm,
        therapeuticCategory: _selectedTherapeuticCategory,
      );

      await repository.saveMedicine(medicine);

      if (context.mounted) {
        context.read<MyMedicineListViewModel>().fetchMedicines();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Icon(Icons.check_circle_outline, color: Colors.green, size: 50),
            content: const Text(Texts.registerSuccess,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
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
      _errorMessage = FailureHandler.handleException(e, context: 'save');
    } finally {
      _isLoading = false;
      notifyListeners();

      if (_errorMessage != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_errorMessage!)),
        );
      }
    }
  }
}
