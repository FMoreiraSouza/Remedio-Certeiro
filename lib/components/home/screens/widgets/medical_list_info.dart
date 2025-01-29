import 'package:flutter/material.dart';
import 'package:remedio_certeiro/utils/date_utils.dart';

class MedicalListInfo extends StatelessWidget {
  const MedicalListInfo({
    super.key,
    required this.name,
    required this.purpose,
    required this.useMode,
    required this.expiration,
    required this.dosage,
    required this.pharmaceuticalForm,
    required this.therapeuticCategory,
  });

  final String name;
  final String purpose;
  final String useMode;
  final String expiration;
  final String dosage;
  final String pharmaceuticalForm;
  final String therapeuticCategory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFDC9502),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  color: Colors.yellow,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: Text(
                          name,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Text(
                      dosage,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      leading: const Icon(Icons.medication),
                      title: Text(
                        therapeuticCategory,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      leading: const Icon(Icons.local_pharmacy),
                      title: Text(
                        pharmaceuticalForm,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
              ListTile(
                leading: const Icon(Icons.description),
                title: Text(
                  purpose,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: Text(
                  useMode,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.date_range),
                title: Text(
                  formatExpirationDate(expiration),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
