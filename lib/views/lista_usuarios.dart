import 'package:clinica_vida_app/controllers/paciente_controller.dart';
import 'package:clinica_vida_app/models/user_model.dart';
import 'package:flutter/material.dart';

class UserListPage extends StatelessWidget {
  final UserController _userController = UserController();

  UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuarios'),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: _userController.getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay usuarios disponibles'));
          } else {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text('${user.nombre} ${user.apellido}'),
                  subtitle: Text(user.email),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Navegar a la pantalla de edición de usuario
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditUserPage(user: user),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          bool success = await _userController.deleteUser(user.uid);
                          if (success) {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Usuario eliminado exitosamente')),
                            );
                            // Actualizar la lista de usuarios
                            // ignore: invalid_use_of_protected_member
                            (context as Element).reassemble();
                          } else {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Error al eliminar usuario')),
                            );
                          }
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
    );
  }
}

class EditUserPage extends StatelessWidget {
  final UserModel user;

  EditUserPage({super.key, required this.user});

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fechaNacimientoController = TextEditingController();
  final TextEditingController sexoController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController duiController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController departamentoController = TextEditingController();
  final TextEditingController tipoUsuarioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nombreController.text = user.nombre;
    apellidoController.text = user.apellido;
    emailController.text = user.email;
    passwordController.text = user.password;
    fechaNacimientoController.text = user.fechaNacimiento.toIso8601String();
    sexoController.text = user.sexo;
    telefonoController.text = user.telefono;
    duiController.text = user.dui;
    direccionController.text = user.direccion;
    departamentoController.text = user.departamento;
    tipoUsuarioController.text = user.tipoUsuario;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: apellidoController,
                decoration: const InputDecoration(labelText: 'Apellido'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Correo'),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
              ),
              TextField(
                controller: fechaNacimientoController,
                decoration: const InputDecoration(labelText: 'Fecha de Nacimiento'),
              ),
              TextField(
                controller: sexoController,
                decoration: const InputDecoration(labelText: 'Sexo'),
              ),
              TextField(
                controller: telefonoController,
                decoration: const InputDecoration(labelText: 'Teléfono'),
              ),
              TextField(
                controller: duiController,
                decoration: const InputDecoration(labelText: 'DUI'),
              ),
              TextField(
                controller: direccionController,
                decoration: const InputDecoration(labelText: 'Dirección'),
              ),
              TextField(
                controller: departamentoController,
                decoration: const InputDecoration(labelText: 'Departamento'),
              ),
              TextField(
                controller: tipoUsuarioController,
                decoration: const InputDecoration(labelText: 'Tipo de Usuario'),
              ),
              ElevatedButton(
                onPressed: () async {
                  bool success = await UserController().updateUser(
                    uid: user.uid,
                    updatedData: {
                      'nombre': nombreController.text,
                      'apellido': apellidoController.text,
                      'email': emailController.text,
                      'password': passwordController.text,
                      'fechaNacimiento': fechaNacimientoController.text,
                      'sexo': sexoController.text,
                      'telefono': telefonoController.text,
                      'dui': duiController.text,
                      'direccion': direccionController.text,
                      'departamento': departamentoController.text,
                      'tipoUsuario': tipoUsuarioController.text,
                    },
                  );
                  if (success) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Usuario actualizado exitosamente')),
                    );
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Error al actualizar usuario')),
                    );
                  }
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}