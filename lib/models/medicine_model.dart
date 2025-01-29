class MedicineModel {
  final String? name;
  final String? purpose;
  final String? useMode;
  final String? dosage;
  final int? interval;
  final String? pharmaceuticalForm;
  final String? therapeuticCategory;
  final DateTime? expirationDate;

  MedicineModel({
    required this.name,
    required this.purpose,
    required this.useMode,
    required this.interval,
    required this.dosage,
    required this.expirationDate,
    required this.pharmaceuticalForm,
    required this.therapeuticCategory,
  });

  factory MedicineModel.fromMap(Map<String, dynamic> map) {
    return MedicineModel(
      name: map['name'] as String,
      purpose: map['purpose'] as String,
      useMode: map['useMode'] as String,
      dosage: map['dosage'] as String?,
      interval: map['interval'] as int?,
      expirationDate:
          map['expirationDate'] != null ? DateTime.parse(map['expirationDate'] as String) : null,
      pharmaceuticalForm: map['pharmaceuticalForm'] as String?,
      therapeuticCategory: map['therapeuticCategory'] as String?,
    );
  }
}
