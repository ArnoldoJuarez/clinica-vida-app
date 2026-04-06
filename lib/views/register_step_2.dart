import 'package:clinica_vida_app/controllers/paciente_controller.dart';
import 'package:clinica_vida_app/views/register_confirm.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  final String nombre;
  final String apellido;
  final String email;
  final String password;
  final DateTime fechaNacimiento;
  final String sexo;

  const RegistrationScreen({
    super.key,
    required this.email,
    required this.nombre,
    required this.apellido,
    required this.password,
    required this.sexo,
    required this.fechaNacimiento,
  });

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //objetos de las clases
  final UserController _userController = UserController();

  final GlobalKey<DepartamentoDropdownState> _departamentoPickerKey =
      GlobalKey<DepartamentoDropdownState>();

  final String tipoUsuario = "Paciente";

  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController duiController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 35.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Llamamos valores de la otra pantalla
             // Text('Nombre: ${widget.nombre}'),
              //Text('Apellido: ${widget.apellido}'),
              //Text('Correo: ${widget.email}'),
              //Text('Contraseña: ${widget.password}'),
             //Text('Sexo: ${widget.sexo}'),
              //Text('Fecha de Nacimiento: ${widget.fechaNacimiento}'),

              const Text(
                'Ingresa tus datos',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(height: 35.0),

              // Número de celular
              const Text('Número de celular'),
              TextFormField(
                controller: telefonoController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: Color(0xFF229BB6),
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: Color(0xFF229BB6),
                      width: 3.0,
                    ),
                  ),
                  hintText: '6040-7841',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                    fontStyle: FontStyle.normal,
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su número de celular';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Número de DUI
              const Text('Número de DUI'),
              TextFormField(
                controller: duiController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: Color(0xFF229BB6),
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: Color(0xFF229BB6),
                      width: 3.0,
                    ),
                  ),
                  hintText: '02310208-5',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                    fontStyle: FontStyle.normal,
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su DUI';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Dirección
              const Text('Dirección'),
              TextFormField(
                controller: direccionController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: Color(0xFF229BB6),
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: Color(0xFF229BB6),
                      width: 3.0,
                    ),
                  ),
                  hintText: 'Colonia, calle, pasaje #, casa #',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                    fontStyle: FontStyle.normal,
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su dirección de domicilio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Departamento
              const Text('Departamento'),
              DepartamentoDropdown(key: _departamentoPickerKey),
              const SizedBox(height: 16.0),

              Center(
                child: FilledButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Verificar que los estados no sean null
                      if (_departamentoPickerKey.currentState == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Error al obtener el estado de los widgets')),
                        );
                        return;
                      }
                      // Instanciar la clase y llamar al método
                      DepartamentoDropdownState departPickerState =
                          _departamentoPickerKey.currentState!;
                      String selectedDepartamento =
                          departPickerState.getSelectedDepartamento();

                      // Navegar a la siguiente pantalla pasando la fecha como DateTime
                      bool isRegistered = await _userController.registerUser(
                        email: widget.email,
                        nombre: widget.nombre,
                        apellido: widget.apellido,
                        password: widget.password,
                        fechaNacimiento: widget.fechaNacimiento,
                        sexo: widget.sexo,
                        telefono: telefonoController.text,
                        dui: duiController.text,
                        direccion: direccionController.text,
                        departamento: selectedDepartamento,
                        tipoUsuario: tipoUsuario,
                      );

                      if (isRegistered) {
                        //registerStep1.limpiarCajasp1();
                        telefonoController.clear();
                        duiController.clear();
                        direccionController.clear();
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(' Usuario Registrado ')));
                        // Limpiar los campos de texto
                       
                        Navigator.push(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterConfirm(),
                          ),
                        );
                      } else {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Error al registrar Usuario ')));
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(159, 34, 155, 182),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    side: const BorderSide(
                      color: Color(0xFF229BB6),
                      width: 3.0,
                    ),
                    minimumSize: const Size(double.infinity, 62),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text('Crear cuenta',
                        style: TextStyle(fontSize: 22, color: Colors.white)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//departamentos
class DepartamentoDropdown extends StatefulWidget {
  const DepartamentoDropdown({super.key});

  @override
  DepartamentoDropdownState createState() => DepartamentoDropdownState();
}

class DepartamentoDropdownState extends State<DepartamentoDropdown> {
  String _selectedDepartamento = 'San Salvador'; // Default value

  String getSelectedDepartamento() {
    return _selectedDepartamento;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedDepartamento,
      items: const [
        DropdownMenuItem(
          value: 'Ahuachapán',
          child: Text('Ahuachapán'),
        ),
        DropdownMenuItem(
          value: 'Sonsonate',
          child: Text('Sonsonate'),
        ),
        DropdownMenuItem(
          value: 'Santa Ana',
          child: Text('Santa Ana'),
        ),
        DropdownMenuItem(
          value: 'La Libertad',
          child: Text('La Libertad'),
        ),
        DropdownMenuItem(
          value: 'Chalatenango',
          child: Text('Chalatenango'),
        ),
        DropdownMenuItem(
          value: 'San Salvador',
          child: Text('San Salvador'),
        ),
        DropdownMenuItem(
          value: 'Cuscatlán',
          child: Text('Cuscatlán'),
        ),
        DropdownMenuItem(
          value: 'La Paz',
          child: Text('La Paz'),
        ),
        DropdownMenuItem(
          value: 'San Vicente',
          child: Text('San Vicente'),
        ),
        DropdownMenuItem(
          value: 'Cabañas',
          child: Text('Cabañas'),
        ),
        DropdownMenuItem(
          value: 'Usulután',
          child: Text('Usulután'),
        ),
        DropdownMenuItem(
          value: 'San Miguel',
          child: Text('San Miguel'),
        ),
        DropdownMenuItem(
          value: 'Morazan',
          child: Text('Morazan'),
        ),
        DropdownMenuItem(
          value: 'La Unión',
          child: Text('La Unión'),
        ),
      ],
      onChanged: (String? newValue) {
        setState(() {
          _selectedDepartamento = newValue!;
        });
      },
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(
            color: Color(0xFF229BB6), // Color del borde
            width: 1.0, // Grosor del borde
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(
            color: Color(0xFF229BB6), // Color del borde cuando está enfocado
            width: 1.0,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0, // Altura del padding reducida al mínimo
          horizontal: 2.0, // Ajuste horizontal mínimo
        ),
        border: OutlineInputBorder(),
      ),
    );
  }
}
