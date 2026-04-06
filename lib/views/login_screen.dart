import 'package:clinica_vida_app/controllers/paciente_controller.dart';
import 'package:clinica_vida_app/models/user_model.dart';
import 'package:clinica_vida_app/views/about_us.dart';
import 'package:clinica_vida_app/views/main_client.dart';
import 'package:clinica_vida_app/views/register_step_1.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  //secra objeto clase controller
  final UserController _userController = UserController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Validar que los campos no estén vacíos y que el correo tenga un formato válido
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, introduce tu correo electrónico';
    }
    // Expresión regular para validar el formato del correo electrónico
    final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Introduce un correo electrónico válido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, introduce tu contraseña';
    }
    return null;
  }

  //login
  void _login() async {
    if (_formKey.currentState!.validate()) {
      UserModel? user = await _userController.loginUser(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (user != null) {
        // Limpiar los campos de texto
      _emailController.clear();
      _passwordController.clear();
      
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => MainClient(
              userId: user.uid,
              userName: '${user.nombre} ${user.apellido}',
              userType: user.tipoUsuario,
            ),
          ),
        );
      } else {
        // Mostrar un mensaje de error al usuario
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Correo o contraseña incorrectos')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Header: Image, Title, Subtitle
                // ignore: sized_box_for_whitespace
                Container(
                  width: double.infinity,
                  height: 270, // Header background color
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Placeholder image
                        Image(
                          image: AssetImage(
                            'assets/LogClinicaVida4.png',
                          ),
                          width: 430, // Set your desired width here
                          height: 265, // Add your image path here
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Inicio de sesión',
                    style: TextStyle(
                        fontSize: 25.0, // Font size of the label
                        fontWeight: FontWeight.bold, // Make the label bold
                        color: Colors.black),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 15.0)),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Inicia sesión con tu cuenta',
                    style: TextStyle(
                        fontSize: 14.0, // Font size of the label
                        fontWeight: FontWeight.normal, // Make the label bold
                        color: Colors.black),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 30.0)),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Correo',
                    style: TextStyle(
                        fontSize: 14.0, // Font size of the label
                        fontWeight: FontWeight.normal, // Make the label bold
                        color: Colors.black),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 12.0)),

                // Email TextField
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Color(0xFF229BB6), // Color del borde
                        width: 2.0, // Grosor del borde
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Color(
                            0xFF229BB6), // Color del borde cuando está enfocado
                        width: 3.0,
                      ),
                    ),
                    hintText: 'hey@tuemail.com',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                    hintStyle: TextStyle(
                      color: Colors.grey, // Color of the placeholder text
                      fontSize: 16.0, // Size of the placeholder text
                      fontStyle:
                          FontStyle.normal, // Italic style for the placeholder
                    ),
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateEmail,
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Contraseña',
                    style: TextStyle(
                        fontSize: 14.0, // Font size of the label
                        fontWeight: FontWeight.normal, // Make the label bold
                        color: Colors.black),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 12.0)),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Color(0xFF229BB6), // Color del borde
                        width: 2.0, // Grosor del borde
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Color(
                            0xFF229BB6), // Color del borde cuando está enfocado
                        width: 3.0,
                      ),
                    ),
                    hintText: 'Introduce tu contraseña',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                    hintStyle: TextStyle(
                      color: Colors.grey, // Color of the placeholder text
                      fontSize: 16.0, // Size of the placeholder text
                      fontStyle:
                          FontStyle.normal, // Italic style for the placeholder
                    ),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: _validatePassword,
                ),
                const SizedBox(height: 30),
                // Login Button
                ElevatedButton(
                  //login
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(149, 34, 155, 182),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Iniciar sesión'),
                ),
                const SizedBox(height: 20),
                // Footer Links: Register and About Us
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        // crear usuario
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterStep1()),
                        );
                      },
                      child: const Text('¿No tienes  cuenta? registrate',
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Add register functionality here
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutUs()),
                        );
                      },
                      child: const Text('Información de contacto',
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
