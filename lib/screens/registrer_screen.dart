import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dashboard.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidosController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController anioController = TextEditingController();

  String sexo = "Masculino";

  void _register() async {
    try {
      if (nombreController.text.isEmpty ||
          apellidosController.text.isEmpty ||
          emailController.text.isEmpty ||
          passwordController.text.isEmpty ||
          anioController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Completa todos los campos")),
        );
        return;
      }

      // 🔐 Crear usuario
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      String uid = userCredential.user!.uid;

      // 💾 Guardar datos en Firestore
      await _firestore.collection("usuarios").doc(uid).set({
        "nombre": nombreController.text,
        "apellidos": apellidosController.text,
        "email": emailController.text,
        "sexo": sexo,
        "anioNacimiento": int.parse(anioController.text),
        "fechaRegistro": int.parse(anioController.text),
      });

      // 🚀 Ir al dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String mensaje = "Error al registrar";

      if (e.code == 'email-already-in-use') {
        mensaje = "El correo ya está en uso";
      } else if (e.code == 'weak-password') {
        mensaje = "Contraseña muy débil";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensaje)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crear cuenta"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nombreController,
              decoration: InputDecoration(labelText: "Nombre"),
            ),
            TextField(
              controller: apellidosController,
              decoration: InputDecoration(labelText: "Apellidos"),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Correo"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Contraseña"),
            ),
            TextField(
              controller: anioController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Año de nacimiento"),
            ),

            SizedBox(height: 20),

            DropdownButtonFormField<String>(
              initialValue: sexo,
              items: ["Masculino", "Femenino", "Otro"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  sexo = value!;
                });
              },
              decoration: InputDecoration(labelText: "Sexo"),
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: _register,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Crear cuenta"),
            ),
          ],
        ),
      ),
    );
  }
}