import 'package:flutter/material.dart';

class MedicalListInfo extends StatelessWidget {
  const MedicalListInfo({
    super.key,
    required this.name,
    required this.description,
    required this.useMode,
  });

  final String name;
  final String description;

  final String useMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.yellow.shade200,
        ),
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(name),
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: Text(description),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: Text(useMode),
            ),
          ],
        ),
      ),
    );
  }
}
