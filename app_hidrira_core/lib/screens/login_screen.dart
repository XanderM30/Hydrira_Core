import 'package:app_hidrira_core/screens/DashboardScreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    // Aquí iría la lógica para autenticar el usuario, por ahora solo mostramos un mensaje
    String username = _usernameController.text;//
    String password = _passwordController.text;

    if (username == 'user' && password == 'password') {
      // Si las credenciales son correctas, redirigimos a la siguiente pantalla (por ejemplo, Dashboard)
      // Aquí podemos navegar a otra pantalla de la app
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    } else {
      // Si las credenciales son incorrectas, mostramos un error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario o contraseña incorrectos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Usuario'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: Text('Iniciar sesión')),
          ],
        ),
      ),
    );
  }
}
