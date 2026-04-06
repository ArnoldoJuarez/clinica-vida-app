import 'package:clinica_vida_app/controllers/doctor_controller.dart';
import 'package:clinica_vida_app/models/doctor_model.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class DoctorCrudScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _DoctorCrudScreenState createState() => _DoctorCrudScreenState();
}

class _DoctorCrudScreenState extends State<DoctorCrudScreen> {
  final _formKey = GlobalKey<FormState>();
  final DoctorController doctorController = DoctorController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController especialidadController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController ubicacionController = TextEditingController();
  final TextEditingController fotoPerfilController = TextEditingController();
  final TextEditingController duracionCitaController = TextEditingController();
  final TextEditingController costoCitaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mantenimiento Doctores'),
      ),
      body: FutureBuilder<List<Doctor>>(
        future: doctorController.obtenerDoctoresDesdeFirestore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay doctores disponibles'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Doctor doctor = snapshot.data![index];
                return ListTile(
                  title: Text(doctor.nombre),
                  subtitle: Text(doctor.especialidad),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //editar
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Editar doctor
                          nombreController.text = doctor.nombre;
                          especialidadController.text =
                              doctor.especialidad;
                          emailController.text = doctor.email;
                          telefonoController.text = doctor.telefono;
                          ubicacionController.text = doctor.ubicacion ;
                          fotoPerfilController.text = doctor.fotoPerfil ;
                          duracionCitaController.text =
                              doctor.duracionCita.toString();
                          costoCitaController.text =
                              doctor.costoCita.toString();

                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Editar Doctor'),
                              content: SingleChildScrollView(
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        controller: nombreController,
                                        decoration: const InputDecoration(
                                            labelText: 'Nombre'),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Campo requerido';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: especialidadController,
                                        decoration: const InputDecoration(
                                            labelText: 'Especialidad'),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Campo requerido';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: emailController,
                                        decoration: const InputDecoration(
                                            labelText: 'Email'),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Campo requerido';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: telefonoController,
                                        decoration: const InputDecoration(
                                            labelText: 'Teléfono'),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Campo requerido';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: ubicacionController,
                                        decoration: const InputDecoration(
                                            labelText: 'Ubicación'),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Campo requerido';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: fotoPerfilController,
                                        decoration: const InputDecoration(
                                            labelText: 'Foto Perfil'),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Campo requerido';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: duracionCitaController,
                                        decoration: const InputDecoration(
                                            labelText: 'Duración Cita'),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Campo requerido';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: costoCitaController,
                                        decoration: const InputDecoration(
                                            labelText: 'Costo Cita'),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Campo requerido';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      try {
                                        Doctor updatedDoctor = Doctor(
                                          id: doctor.id,
                                          nombre: nombreController.text,
                                          especialidad:
                                              especialidadController.text,
                                          email: emailController.text,
                                          telefono: telefonoController.text,
                                          ubicacion: ubicacionController.text,
                                          fotoPerfil: fotoPerfilController.text,
                                          horarioAtencion:
                                              doctor.horarioAtencion,
                                          diasNoDisponibles:
                                              doctor.diasNoDisponibles,
                                          duracionCita: int.parse(
                                              duracionCitaController.text),
                                          costoCita: double.parse(
                                              costoCitaController.text),
                                        );
                                        await doctorController
                                            .actualizarDoctorEnFirestore(
                                                updatedDoctor);
                                        setState(() {});
                                        // ignore: use_build_context_synchronously
                                        Navigator.of(context).pop();
                                      } catch (e) {
                                        // ignore: avoid_print
                                        print('Error updating doctor: $e');
                                        // Show an error message to the user
                                        // ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'Error updating doctor: $e')),
                                        );
                                      }
                                    }
                                  },
                                  child: const Text('Guardar'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // Eliminar doctor
                          doctorController.eliminarDoctorDeFirestore(doctor.id);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),

      //editar
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Clear controllers
          nombreController.clear();
          especialidadController.clear();
          emailController.clear();
          telefonoController.clear();
          ubicacionController.clear();
          fotoPerfilController.clear();
          duracionCitaController.clear();
          costoCitaController.clear();

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Agregar Doctor'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nombreController,
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                        errorText: nombreController.text.isEmpty
                            ? 'Campo requerido'
                            : null,
                      ),
                    ),
                    TextField(
                      controller: especialidadController,
                      decoration: InputDecoration(
                        labelText: 'Especialidad',
                        errorText: especialidadController.text.isEmpty
                            ? 'Campo requerido'
                            : null,
                      ),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        errorText: emailController.text.isEmpty
                            ? 'Campo requerido'
                            : null,
                      ),
                    ),
                    TextField(
                      controller: telefonoController,
                      decoration: InputDecoration(
                        labelText: 'Teléfono',
                        errorText: telefonoController.text.isEmpty
                            ? 'Campo requerido'
                            : null,
                      ),
                    ),
                    TextField(
                      controller: ubicacionController,
                      decoration: InputDecoration(
                        labelText: 'Ubicación',
                        errorText: ubicacionController.text.isEmpty
                            ? 'Campo requerido'
                            : null,
                      ),
                    ),
                    TextField(
                      controller: fotoPerfilController,
                      decoration: InputDecoration(
                        labelText: 'Foto Perfil',
                        errorText: fotoPerfilController.text.isEmpty
                            ? 'Campo requerido'
                            : null,
                      ),
                    ),
                    TextField(
                      controller: duracionCitaController,
                      decoration: InputDecoration(
                        labelText: 'Duración Cita',
                        errorText: duracionCitaController.text.isEmpty
                            ? 'Campo requerido'
                            : null,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: costoCitaController,
                      decoration: InputDecoration(
                        labelText: 'Costo Cita',
                        errorText: costoCitaController.text.isEmpty
                            ? 'Campo requerido'
                            : null,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    if (nombreController.text.isEmpty ||
                        especialidadController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        telefonoController.text.isEmpty ||
                        ubicacionController.text.isEmpty ||
                        fotoPerfilController.text.isEmpty ||
                        duracionCitaController.text.isEmpty ||
                        costoCitaController.text.isEmpty) {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Por favor, complete todos los campos')),
                      );
                      return;
                    }

                    Doctor newDoctor = Doctor(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      nombre: nombreController.text,
                      especialidad: especialidadController.text,
                      email: emailController.text,
                      telefono: telefonoController.text,
                      ubicacion: ubicacionController.text,
                      fotoPerfil: fotoPerfilController.text,
                      horarioAtencion: {}, // Puedes agregar lógica para esto
                      diasNoDisponibles: [], // Puedes agregar lógica para esto
                      duracionCita: int.parse(duracionCitaController.text),
                      costoCita: double.parse(costoCitaController.text),
                    );
                    doctorController.guardarDoctorEnFirestore(newDoctor);
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: const Text('Guardar'),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
