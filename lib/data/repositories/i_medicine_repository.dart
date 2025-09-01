import 'package:remedio_certeiro/data/models/medicine_model.dart';

abstract class IMedicineRepository {
  Future<List<MedicineModel>> fetchMedicines();
  Future<void> saveMedicine(MedicineModel medicine);
  Future<void> deleteMedicine(String id);
  Future<List<Map<String, dynamic>>> fetchMedicineHours();
  Future<void> saveMedicineHour(String name, DateTime nextDoseTime);
  Future<void> updateMedicineNextDoseTime(int id, DateTime nextDoseTime);
  Future<void> deleteMedicineHour(int id);
  Future<void> renewDosage(int id, String name);
  Future<List<String>> fetchPharmaceuticalForms();
  Future<List<String>> fetchTherapeuticCategories();
}
