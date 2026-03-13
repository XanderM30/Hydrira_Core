import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenido al Dashboard!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aquí podrías agregar más acciones (como logout, ver datos, etc.)
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Acción ejecutada')));
              },
              child: Text('Realizar acción'),
            ),
          ],
        ),
      ),
    );
  }
}
