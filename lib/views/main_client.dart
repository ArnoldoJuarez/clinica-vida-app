import 'package:clinica_vida_app/views/doctor_lista.dart';
import 'package:clinica_vida_app/views/doctor_mantenimiento.dart';
import 'package:clinica_vida_app/views/lista_usuarios.dart';
import 'package:clinica_vida_app/views/login_screen.dart';
import 'package:clinica_vida_app/views/perfil_user.dart';
import 'package:clinica_vida_app/views/register_step_1.dart';
import 'package:clinica_vida_app/views/reservations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainClient extends StatelessWidget {
  final String userId;
  final String userName;
  final String userType;
  // List of SVG icons and their corresponding text
  final List<Map<String, String>> items = [
    {'icon': 'assets/icons/bag.svg', 'text': 'Consulta Medica'},
    {'icon': 'assets/icons/x_ray.svg', 'text': 'Rayos X'},
    {'icon': 'assets/icons/lab.svg', 'text': 'Laboratorio'},
    {'icon': 'assets/icons/kids.svg', 'text': 'Pediatría'},
    {'icon': 'assets/icons/teeth.svg', 'text': 'Odontología'},
    {'icon': 'assets/icons/cervical_cancer.svg', 'text': 'Ginecología'},
    {'icon': 'assets/icons/breast_mammoplasty.svg', 'text': 'Mamografía'},
    {'icon': 'assets/icons/stomatch.svg', 'text': 'Gastroenterología'},
  ];

  MainClient({
    super.key,
    required this.userId,
    required this.userName,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(
            34, 155, 182, 0.72), // Set background color of the AppBar
        title: Text(
          'Inicio - Bienvenido: $userName', // Left title with user name
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        actions: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                'Clinica Vida', // Right title
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          if (userType !=
              'Paciente') // Condición para mostrar el botón solo si el usuario no es Paciente
            IconButton(
              icon: const Icon(Icons.person_add), // Icon for Registrar Usuarios
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const RegisterStep1()), // Navigate to RegistrarUsuarios page
                );
              },
            ),
          if (userType !=
              'Paciente') // Condición para mostrar el botón solo si el usuario no es Paciente
            IconButton(
              icon: const Icon(Icons.list), // Icon for Lista de Usuarios
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          UserListPage()), // Navigate to ListaUsuarios page
                );
              },
            ),
          TextButton.icon(
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            label: const Text(
              'Salir',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              // Acción para el botón de salir
              SystemNavigator.pop(); // Cierra la aplicación
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white, // Back button icon
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(
                  context); // Cierra la vista actual y regresa a la pantalla anterior
            } else {
              // Maneja el caso donde no hay rutas en la pila
             // print('No hay rutas en la pila de navegación');
              Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
         // Reemplaza HomePage con la pantalla deseada
      );
            }
          },
        ),
      ),
      // Body with background color
      body: Container(
        color:
            const Color.fromARGB(255, 255, 255, 255), // Body background color
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Bienvenido:  $userName $userType',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: Row(
                children: [
                  // First Column
                  Expanded(
                    child: Column(
                      children: List.generate(4, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            children: [
                              IconButton(
                                icon: SvgPicture.asset(items[index]['icon']!,
                                    height: 64.0),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DoctorListScreen(
                                        especialidad: items[index]['text']!,
                                        userId: userId,
                                        userName: userName,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Text(
                                items[index]['text']!,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8.0)
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  // Second Column
                  Expanded(
                    child: Column(
                      children: List.generate(4, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            children: [
                              IconButton(
                                icon: SvgPicture.asset(
                                    items[index + 4]['icon']!,
                                    height: 64.0),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DoctorListScreen(
                                        especialidad: items[index + 4]['text']!,
                                        userId: userId,
                                        userName: userName,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Text(
                                items[index + 4]['text']!,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8.0)
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Footer with background color
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromRGBO(34, 155, 182, 0.75),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: IconButton(
                  icon: SvgPicture.asset('assets/icons/clipboard-list.svg'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Reservations(uid: userId)),
                    );
                  },
                ),
              ),
              if (userType != 'Paciente')
                Expanded(
                  child: IconButton(
                    icon: const Icon(Icons.settings),
                    color: Colors.red, // Color del icono de configuración
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorCrudScreen()),
                      );
                    },
                  ),
                ),
              Expanded(
                child: IconButton(
                  icon: SvgPicture.asset('assets/icons/user-cog.svg'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PerfilUser(uid: userId)),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
