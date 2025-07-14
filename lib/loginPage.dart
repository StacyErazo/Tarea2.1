import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController correoController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();
  bool mostrarContrasena = false;

  final String correoValido = 'usuario@unah.hn';
  final String cuentaValida = '20231234567';

  void _validarLogin() {
    final correo = correoController.text.trim();
    final contrasena = contrasenaController.text.trim();

    if (correo == correoValido && contrasena == cuentaValida) {
      context.go('/home/$correo');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Correo o contraseña incorrectos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'INICIAR SESION',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 40),

              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: correoController,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person, color: Colors.black54),
                    hintText: 'Correo institucional',
                    hintStyle: TextStyle(color: Colors.black45),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: contrasenaController,
                  obscureText: !mostrarContrasena,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    icon: const Icon(Icons.lock, color: Colors.black54),
                    hintText: 'Contraseña',
                    hintStyle: const TextStyle(color: Colors.black45),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(
                        mostrarContrasena ? Icons.visibility : Icons.visibility_off,
                        color: Colors.black45,
                      ),
                      onPressed: () {
                        setState(() => mostrarContrasena = !mostrarContrasena);
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _validarLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  context.go('/registro');
                },
                child: const Text(
                  '¿No tienes cuenta? Regístrate',
                  style: TextStyle(color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
