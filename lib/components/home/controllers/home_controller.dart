import 'package:flutter/material.dart';
import 'package:remedio_certeiro/database/database_helper.dart';

class HomeController extends ChangeNotifier {
  List<Map<String, dynamic>> _medicineHours = [];

  List<Map<String, dynamic>> get medicineHours => _medicineHours;

  Future<void> fetchMedicineHours() async {
    _medicineHours = await DatabaseHelper.instance.fetchMedicineHours();
    notifyListeners();
  }
}
