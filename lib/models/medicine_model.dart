class Medicine {
  final String name;
  final String description;
  final String useMode;
  final String? dosage;
  final DateTime? expiryDate;
  final String? manufacturer;

  Medicine({
    required this.name,
    required this.description,
    required this.useMode,
    this.dosage,
    this.expiryDate,
    this.manufacturer,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'useMode': useMode,
      'dosage': dosage,
      'expiryDate': expiryDate?.toIso8601String(),
      'manufacturer': manufacturer,
    };
  }

  factory Medicine.fromMap(Map<String, dynamic> map) {
    return Medicine(
      name: map['name'] as String,
      description: map['description'] as String,
      useMode: map['useMode'] as String,
      dosage: map['dosage'] as String?,
      expiryDate: map['expiryDate'] != null ? DateTime.parse(map['expiryDate'] as String) : null,
      manufacturer: map['manufacturer'] as String?,
    );
  }
}
