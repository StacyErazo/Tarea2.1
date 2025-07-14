import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController cuentaController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();
  final TextEditingController confirmarController = TextEditingController();

  bool mostrarContrasena = false;
  bool mostrarConfirmacion = false;

  void _mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensaje)));
  }

  void _registrarUsuario() {
    final nombre = nombreController.text.trim();
    final correo = correoController.text.trim();
    final cuenta = cuentaController.text.trim();
    final contrasena = contrasenaController.text.trim();
    final confirmar = confirmarController.text.trim();

    if (nombre.isEmpty || correo.isEmpty || cuenta.isEmpty || contrasena.isEmpty || confirmar.isEmpty) {
      _mostrarError('Todos los campos son necesarios');
      return;
    }

    if (!correo.endsWith('@unah.hn')) {
      _mostrarError('Solo puede usar su correo institucional');
      return;
    }

    if (contrasena != confirmar) {
      _mostrarError('Las contraseñas no son iguales');
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Se ha registrado correctamente')),
    );

    context.go('/login');
  }

  Widget _campoInput({
    required IconData icono,
    required String hint,
    required TextEditingController controller,
    bool esPassword = false,
    bool mostrarTexto = false,
    VoidCallback? onToggle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: controller,
        obscureText: esPassword && !mostrarTexto,
        decoration: InputDecoration(
          icon: Icon(icono, color: Colors.black54),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black45),
          border: InputBorder.none,
          suffixIcon: esPassword
              ? IconButton(
                  icon: Icon(
                    mostrarTexto ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black45,
                  ),
                  onPressed: onToggle,
                )
              : null,
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.person_add_alt_1, size: 80, color: Colors.black),
              const SizedBox(height: 16),
              const Text(
                'REGISTRO',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 32),

              _campoInput(
                icono: Icons.person,
                hint: 'Nombre completo',
                controller: nombreController,
              ),
              const SizedBox(height: 16),

              _campoInput(
                icono: Icons.email,
                hint: 'Correo institucional',
                controller: correoController,
              ),
              const SizedBox(height: 16),

              _campoInput(
                icono: Icons.numbers,
                hint: 'Número de cuenta',
                controller: cuentaController,
              ),
              const SizedBox(height: 16),

              _campoInput(
                icono: Icons.lock,
                hint: 'Contraseña',
                controller: contrasenaController,
                esPassword: true,
                mostrarTexto: mostrarContrasena,
                onToggle: () => setState(() => mostrarContrasena = !mostrarContrasena),
              ),
              const SizedBox(height: 16),

              _campoInput(
                icono: Icons.lock_outline,
                hint: 'Confirmar contraseña',
                controller: confirmarController,
                esPassword: true,
                mostrarTexto: mostrarConfirmacion,
                onToggle: () => setState(() => mostrarConfirmacion = !mostrarConfirmacion),
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _registrarUsuario,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'REGISTRARSE',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              TextButton(
                onPressed: () => context.go('/login'),
                child: const Text(
                  'Si ya tienes cuenta, Inicia Sesion',
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
