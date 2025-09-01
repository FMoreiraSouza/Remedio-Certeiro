class MedicineModel {
  final String id;
  final String? name;
  final String? purpose;
  final String? useMode;
  final String? dosage;
  final int? interval;
  final String? pharmaceuticalForm;
  final String? therapeuticCategory;
  final DateTime? expirationDate;

  MedicineModel({
    required this.id,
    this.name,
    this.purpose,
    this.useMode,
    this.dosage,
    this.interval,
    this.expirationDate,
    this.pharmaceuticalForm,
    this.therapeuticCategory,
  });

  factory MedicineModel.fromMap(Map<String, dynamic> map) {
    return MedicineModel(
      id: map['\$id'] ?? map['id'] as String,
      name: map['name'] as String?,
      purpose: map['purpose'] as String?,
      useMode: map['useMode'] as String?,
      dosage: map['dosage'] as String?,
      interval: map['interval'] as int?,
      expirationDate:
          map['expirationDate'] != null ? DateTime.parse(map['expirationDate'] as String) : null,
      pharmaceuticalForm: map['pharmaceuticalForm'] as String?,
      therapeuticCategory: map['therapeuticCategory'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dosage': dosage,
      'purpose': purpose,
      'useMode': useMode,
      'interval': interval,
      'expirationDate': expirationDate?.toIso8601String(),
      'pharmaceuticalForm': pharmaceuticalForm,
      'therapeuticCategory': therapeuticCategory,
    };
  }
}
