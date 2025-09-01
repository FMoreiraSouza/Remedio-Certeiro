import 'package:appwrite/appwrite.dart';
import 'package:remedio_certeiro/data/api/app_write_service.dart';
import 'package:remedio_certeiro/core/utils/database_helper.dart';
import 'package:remedio_certeiro/data/models/medicine_model.dart';
import 'package:remedio_certeiro/data/repositories/i_medicine_repository.dart';

class MedicineRepository implements IMedicineRepository {
  final AppWriteService appwriteService;
  final DatabaseHelper databaseHelper;

  MedicineRepository(this.appwriteService, this.databaseHelper);

  @override
  Future<List<MedicineModel>> fetchMedicines() async {
    final response = await appwriteService.database.listDocuments(
      databaseId: '67944210001fd099f8bc',
      collectionId: '679989e700274100acf1',
    );
    return response.documents.map((doc) => MedicineModel.fromMap(doc.data)).toList();
  }

  @override
  Future<void> saveMedicine(MedicineModel medicine) async {
    await appwriteService.database.createDocument(
      databaseId: '67944210001fd099f8bc',
      collectionId: '679989e700274100acf1',
      documentId: 'unique()',
      data: medicine.toMap(),
    );
  }

  @override
  Future<void> deleteMedicine(String id) async {
    await appwriteService.database.deleteDocument(
      databaseId: '67944210001fd099f8bc',
      collectionId: '679989e700274100acf1',
      documentId: id,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> fetchMedicineHours() async {
    return await databaseHelper.fetchMedicineHours();
  }

  @override
  Future<void> saveMedicineHour(String name, DateTime nextDoseTime) async {
    await databaseHelper.saveMedicineHour(name, nextDoseTime);
  }

  @override
  Future<void> updateMedicineNextDoseTime(int id, DateTime nextDoseTime) async {
    await databaseHelper.updateMedicineNextDoseTime(id, nextDoseTime);
  }

  @override
  Future<void> deleteMedicineHour(int id) async {
    await databaseHelper.deleteMedicine(id);
  }

  @override
  Future<void> renewDosage(int medicineId, String medicineName) async {
    final response = await appwriteService.database.listDocuments(
      databaseId: '67944210001fd099f8bc',
      collectionId: '679989e700274100acf1',
      queries: [Query.equal('name', medicineName)],
    );
    if (response.documents.isNotEmpty) {
      final document = response.documents.first;
      final interval = document.data['interval'] ?? 0;
      final doseTime = DateTime.now().add(Duration(minutes: interval));
      await databaseHelper.updateMedicineNextDoseTime(medicineId, doseTime);
    } else {
      throw Exception('Nenhum documento encontrado para o medicamento: $medicineName');
    }
  }

  @override
  Future<List<String>> fetchPharmaceuticalForms() async {
    final response = await appwriteService.database.listDocuments(
      databaseId: '67944210001fd099f8bc',
      collectionId: '67983990002f46e18dc2',
    );
    return response.documents.map((doc) => doc.data['name'] as String).toList();
  }

  @override
  Future<List<String>> fetchTherapeuticCategories() async {
    final response = await appwriteService.database.listDocuments(
      databaseId: '67944210001fd099f8bc',
      collectionId: '679839650029fc39778e',
    );
    return response.documents.map((doc) => doc.data['name'] as String).toList();
  }
}
