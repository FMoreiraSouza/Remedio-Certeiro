import 'package:flutter/material.dart';
import 'package:remedio_certeiro/database/database_helper.dart';
import 'package:remedio_certeiro/models/medicine_model.dart';
import 'package:remedio_certeiro/utils/date_utils.dart';

class MedicalListInfo extends StatelessWidget {
  const MedicalListInfo({
    super.key,
    required this.medicine,
  });

  final MedicineModel medicine;

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
                          '${medicine.name}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Text(
                      '${medicine.dosage}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              // Detalhes do medicamento
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      leading: const Icon(Icons.medication),
                      title: Text(
                        '${medicine.therapeuticCategory}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      leading: const Icon(Icons.local_pharmacy),
                      title: Text(
                        '${medicine.pharmaceuticalForm}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
              ListTile(
                leading: const Icon(Icons.description),
                title: Text(
                  '${medicine.purpose}',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: Text(
                  '${medicine.useMode}',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.date_range),
                title: Text(
                  formatExpirationDate('${medicine.expirationDate}'),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Verifica o intervalo de horas em minutos
                      final intervalInMinutes = (medicine.interval ?? 0) * 60;

                      // Calcula a próxima hora de dose considerando o intervalo
                      final nextDoseTime = DateTime.now().add(Duration(minutes: intervalInMinutes));

                      // Salva o horário da próxima dose no banco de dados
                      await DatabaseHelper.instance.saveMedicineHour(
                        medicine.name ?? "Nome Indefinido",
                        nextDoseTime,
                      );

                      // Exibe a mensagem de confirmação
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Dose aplicada para ${medicine.name}")),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text("Aplicar Dose"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
