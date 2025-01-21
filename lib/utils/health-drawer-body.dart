import 'package:flutter/material.dart';

class HealthDrawerBody extends StatelessWidget {
  const HealthDrawerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      width: 200,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 100.0,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.yellow,
              ),
              child: Align(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.person),
                SizedBox(width: 8),
                Text('Perfil'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.medical_services),
                SizedBox(width: 8),
                Text('Serviços Médicos'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
