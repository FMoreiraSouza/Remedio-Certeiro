import 'package:appwrite/appwrite.dart';
import 'package:remedio_certeiro/core/network/checker.dart';
import 'package:remedio_certeiro/core/utils/database_helper.dart';
import 'package:remedio_certeiro/core/utils/failure_handler.dart';
import 'package:remedio_certeiro/data/api/app_write_service.dart';
import 'package:remedio_certeiro/data/models/medicine_model.dart';
import 'package:remedio_certeiro/data/repositories/i_medicine_repository.dart';

class MedicineRepository implements IMedicineRepository {
  final AppWriteService appwriteService;
  final DatabaseHelper databaseHelper;

  MedicineRepository(this.appwriteService, this.databaseHelper);

  @override
  Future<List<MedicineModel>> fetchMedicines() async {
    try {
      await Checker.checkNetworkConnectivity(context: 'fetch');
      final response = await appwriteService.database.listDocuments(
        databaseId: '67944210001fd099f8bc',
        collectionId: '679989e700274100acf1',
      );
      return response.documents.map((doc) => MedicineModel.fromMap(doc.data)).toList();
    } on AppwriteException catch (e) {
      throw FailureHandler.convertAppwriteException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveMedicine(MedicineModel medicine) async {
    try {
      await Checker.checkNetworkConnectivity(context: 'save');
      await appwriteService.database.createDocument(
        databaseId: '67944210001fd099f8bc',
        collectionId: '679989e700274100acf1',
        documentId: 'unique()',
        data: medicine.toMap(),
      );
    } on AppwriteException catch (e) {
      throw FailureHandler.convertAppwriteException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteMedicine(String id) async {
    try {
      await Checker.checkNetworkConnectivity(context: 'delete');
      await appwriteService.database.deleteDocument(
        databaseId: '67944210001fd099f8bc',
        collectionId: '679989e700274100acf1',
        documentId: id,
      );
    } on AppwriteException catch (e) {
      throw FailureHandler.convertAppwriteException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> fetchMedicineHours() async {
    try {
      return await databaseHelper.fetchMedicineHours();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveMedicineHour(String name, DateTime nextDoseTime) async {
    try {
      await databaseHelper.saveMedicineHour(name, nextDoseTime);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateMedicineNextDoseTime(int id, DateTime nextDoseTime) async {
    try {
      await databaseHelper.updateMedicineNextDoseTime(id, nextDoseTime);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteMedicineHour(int id) async {
    try {
      await databaseHelper.deleteMedicine(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> renewDosage(int medicineId, String medicineName) async {
    try {
      await Checker.checkNetworkConnectivity(context: 'save');
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
    } on AppwriteException catch (e) {
      throw FailureHandler.convertAppwriteException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<String>> fetchPharmaceuticalForms() async {
    try {
      await Checker.checkNetworkConnectivity(context: 'fetch');
      final response = await appwriteService.database.listDocuments(
        databaseId: '67944210001fd099f8bc',
        collectionId: '67983990002f46e18dc2',
      );
      return response.documents.map((doc) => doc.data['name'] as String).toList();
    } on AppwriteException catch (e) {
      throw FailureHandler.convertAppwriteException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<String>> fetchTherapeuticCategories() async {
    try {
      await Checker.checkNetworkConnectivity(context: 'fetch');
      final response = await appwriteService.database.listDocuments(
        databaseId: '67944210001fd099f8bc',
        collectionId: '679839650029fc39778e',
      );
      return response.documents.map((doc) => doc.data['name'] as String).toList();
    } on AppwriteException catch (e) {
      throw FailureHandler.convertAppwriteException(e);
    } catch (e) {
      rethrow;
    }
  }
}
