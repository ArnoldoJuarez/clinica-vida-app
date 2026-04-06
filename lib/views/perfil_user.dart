import 'package:clinica_vida_app/controllers/paciente_controller.dart';
import 'package:clinica_vida_app/models/user_model.dart';
import 'package:clinica_vida_app/views/main_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PerfilUser extends StatelessWidget {
  final String uid;

  const PerfilUser({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(uid: uid),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String uid;
  final UserController userController = UserController();

  MyHomePage({super.key, required this.uid});

  //obtner el mes
  String obtenerNombreMes(int mes) {
    Map<int, String> meses = {
      1: 'Enero',
      2: 'Febrero',
      3: 'Marzo',
      4: 'Abril',
      5: 'Mayo',
      6: 'Junio',
      7: 'Julio',
      8: 'Agosto',
      9: 'Septiembre',
      10: 'Octubre',
      11: 'Noviembre',
      12: 'Diciembre'
    };

    return meses[mes] ?? 'Mes inválido';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<UserModel?>(
            future: userController.getUserById(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text('Usuario no encontrado'));
              } else {
                UserModel user = snapshot.data!;
                int mes = user.fechaNacimiento.month;
                String nombreMes = obtenerNombreMes(mes);

                return Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(34, 155, 182, 0.75),
                  ),
                  child: Column(
                    children: [
                      // Header
                      Container(
                        color: const Color.fromRGBO(34, 155, 182, 0.10),
                        height: 230,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 8,
                              left: 4,
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back),
                                color: Colors.white, // Back button icon
                                onPressed: () {
                                  if (Navigator.canPop(context)) {
                                    Navigator.pop(
                                        context); // Cierra la vista actual y regresa a la pantalla anterior
                                  } else {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainClient(
                                                userId: user.uid,
                                                userName:
                                                    '${user.nombre} ${user.apellido}',
                                                userType: user.tipoUsuario,
                                              )),
                                    );
                                  }
                                },
                              ),
                            ),
                            Center(
                              child: Column(
                                mainAxisSize: MainAxisSize
                                    .min, // Keeps the column's size as small as possible
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/perfil_user_circle_white.svg', // Path to your SVG
                                    semanticsLabel: 'Profile Image',
                                    height: 110,
                                    width: 110,
                                  ),
                                  const SizedBox(
                                      height:
                                          8), // Adds spacing between image and text
                                  Text(
                                    'Hola ${user.nombre}', // Replace with the desired text
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight
                                          .bold, // Makes the text bold
                                      color: Colors
                                          .white, // Ensures the text is visible on the background
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 4,
                              child: IconButton(
                                icon: SvgPicture.asset(
                                  'assets/icons/edit_white.svg', // Path to your SVG
                                  semanticsLabel: 'My SVG Image',
                                  height: 28,
                                  width: 28,
                                ),
                                onPressed: () {
                                  // Add your close action here
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Body with rounded top corners
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(color: Colors.white),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                              horizontal:
                                  20, // Padding on X-axis (left and right)
                              vertical:
                                  35, // Padding on Y-axis (top and bottom)
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons
                                            .recent_actors, // Replace with any icon you want
                                        size: 24,
                                        color: Color.fromRGBO(34, 155, 182,
                                            0.75), // Change the color to fit your design
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left:
                                                16.0), // Add padding to the left
                                        child: Text(
                                          'DUI: ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight
                                                .bold, // Make text bold
                                          ),
                                        ),
                                      ),
                                      Text(
                                        user.dui,
                                        style: const TextStyle(
                                            fontSize: 16 // Make text bold
                                            ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 25),
                                  Wrap(
  spacing: 8.0, // Espacio horizontal entre los elementos
  runSpacing: 4.0, // Espacio vertical entre las líneas
  children: [
    const Icon(
      Icons.email, // Replace with any icon you want
      size: 24,
      color: Color.fromRGBO(34, 155, 182, 0.75), // Change the color to fit your design
    ),
    const Padding(
      padding: EdgeInsets.only(left: 16.0), // Add padding to the left
      child: Text(
        'Correo: ',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold, // Make text bold
        ),
      ),
    ),
    Flexible(
      child: Text(
        user.email,
        style: const TextStyle(
          fontSize: 16, // Make text bold
        ),
        overflow: TextOverflow.visible, // Permite que el texto se ajuste a la siguiente línea
        softWrap: true, // Permite que el texto se ajuste a la siguiente línea
      ),
    ),
  ],
),

                                  const SizedBox(height: 25),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons
                                            .phone, // Replace with any icon you want
                                        size: 24,
                                        color: Color.fromRGBO(34, 155, 182,
                                            0.75), // Change the color to fit your design
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left:
                                                16.0), // Add padding to the left
                                        child: Text(
                                          'Celular: ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight
                                                .bold, // Make text bold
                                          ),
                                        ),
                                      ),
                                      Text(
                                        user.telefono,
                                        style: const TextStyle(
                                            fontSize: 16 // Make text bold
                                            ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 25),
                                  Wrap(
                                    spacing:
                                        8.0, // Espacio horizontal entre los elementos
                                    runSpacing:
                                        4.0, // Espacio vertical entre las líneas
                                    children: [
                                      const Icon(
                                        Icons
                                            .event_available, // Replace with any icon you want
                                        size: 24,
                                        color: Color.fromRGBO(34, 155, 182,
                                            0.75), // Change the color to fit your design
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left:
                                                16.0), // Add padding to the left
                                        child: Text(
                                          'Fecha de nacimiento: ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight
                                                .bold, // Make text bold
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${user.fechaNacimiento.day} de $nombreMes del ${user.fechaNacimiento.year}',
                                        style: const TextStyle(
                                          fontSize: 16, // Make text bold
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 25),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons
                                            .male, // Replace with any icon you want
                                        size: 24,
                                        color: Color.fromRGBO(34, 155, 182,
                                            0.75), // Change the color to fit your design
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left:
                                                16.0), // Add padding to the left
                                        child: Text(
                                          'Sexo: ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight
                                                .bold, // Make text bold
                                          ),
                                        ),
                                      ),
                                      Text(
                                        user.sexo,
                                        style: const TextStyle(
                                            fontSize: 16 // Make text bold
                                            ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 25),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons
                                            .map, // Replace with any icon you want
                                        size: 24,
                                        color: Color.fromRGBO(34, 155, 182,
                                            0.75), // Change the color to fit your design
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left:
                                                16.0), // Add padding to the left
                                        child: Text(
                                          'Departamento: ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight
                                                .bold, // Make text bold
                                          ),
                                        ),
                                      ),
                                      Text(
                                        user.departamento,
                                        style: const TextStyle(
                                            fontSize: 16 // Make text bold
                                            ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 1),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons
                                            .place, // Replace with any icon you want
                                        size: 24,
                                        color: Color.fromRGBO(34, 155, 182,
                                            0.75), // Change the color to fit your design
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left:
                                                16.0), // Add padding to the left
                                        child: Text(
                                          'Dirección: ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight
                                                .bold, // Make text bold
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 25.0),
                                          child: Text(
                                            user.direccion,
                                            style:
                                                const TextStyle(fontSize: 16),
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                      ),
                                      const Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 25.0),
                                          child: Text(
                                            'Colonia San Francisco, Calle el por venir, Pasaje 2, Casa 4',
                                            style: TextStyle(fontSize: 16),
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }));
  }
}
