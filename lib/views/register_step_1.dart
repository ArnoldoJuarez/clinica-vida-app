import 'package:clinica_vida_app/views/register_step_2.dart';
import 'package:flutter/material.dart';

class RegisterStep1 extends StatefulWidget {
  const RegisterStep1({super.key});

  @override
  State<RegisterStep1> createState() => _RegisterStep1State();
}

class _RegisterStep1State extends State<RegisterStep1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //controlador

  final GlobalKey<DatePickerRowState> _datePickerKey =
      GlobalKey<DatePickerRowState>();
  final GlobalKey<GenderDropdownState> _genderDropdownKey =
      GlobalKey<GenderDropdownState>();

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final String tipoUsuario = "Paciente";

  @override
  void initState() {
    super.initState();
    limpiarCajasp1();
  }

  //limpiar cjas
  void limpiarCajasp1() {
    nombreController.clear();
    apellidoController.clear();
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(34, 155, 182, 0.72),
        title: const Text(
          'Formulario',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white, // Back button icon
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(
                  context); // Cierra la vista actual y regresa a la pantalla anterior
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 35.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 35.0),
              // Subtitle
              const Text(
                'Ingresa tus datos',
                style:
                    TextStyle(fontSize: 16, color: Colors.black), // Use theme
              ),
              const SizedBox(height: 35.0),

              // Label and Input 1 - Username
              const Text('Nombre'),
              TextFormField(
                controller: nombreController,
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
                  hintText: 'Juan Manuel',
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Label and Input 2 - Email
              const Text('Apellido'),
              TextFormField(
                controller: apellidoController,
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
                  hintText: 'Perez Peña',
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su apellido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Label and Input 3 - Password
              const Text('Correo'),
              TextFormField(
                controller: emailController,
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
                  hintText: 'hey@.tuemail.com',
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su correo';
                  }
                  // Expresión regular para validar el formato del correo electrónico
                  final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Introduce un correo electrónico válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Label and Input 4 - Confirm Password
              const Text('Confirm Password'),
              TextFormField(
                controller: passwordController,
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Label and Input 5 - Phone Number
              const Text('Fecha de nacimiento'),

              const SizedBox(height: 24.0),
              //const DatePickerRow(),
              DatePickerRow(key: _datePickerKey),
              const SizedBox(height: 24.0),
              const Text('Sexo'),
              const SizedBox(height: 16.0),
              // const GenderDropdown(),
              GenderDropdown(key: _genderDropdownKey),

              const SizedBox(height: 24.0),
              // Register Button
              Center(
                child: FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Verificar que los estados no sean null
                      if (_datePickerKey.currentState == null ||
                          _genderDropdownKey.currentState == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Error al obtener el estado de los widgets')),
                        );
                        return;
                      }
                      DatePickerRowState datePickerState =
                          _datePickerKey.currentState!;
                      GenderDropdownState genderDropdownState =
                          _genderDropdownKey.currentState!;

                      try {
                        // Obtener el género seleccionado
                        String selectedGender =
                            genderDropdownState.getSelectedGender();

                        // Validar y combinar la fecha
                        DateTime? fechaNacimiento =
                            datePickerState.validateAndCombineDate();
                        if (fechaNacimiento != null) {
                          // Navegar a la siguiente pantalla pasando la fecha como DateTime
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegistrationScreen(
                                email: emailController.text,
                                nombre: nombreController.text,
                                apellido: apellidoController.text,
                                password: passwordController.text,
                                fechaNacimiento: fechaNacimiento,
                                sexo: selectedGender,
                              ),
                            ),
                          );
                       
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Fecha no válida')));
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
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
                    child: Text('Siguiente',
                        style: TextStyle(fontSize: 22, color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DatePickerRow extends StatefulWidget {
  const DatePickerRow({super.key});

  @override
  DatePickerRowState createState() => DatePickerRowState();
}

class DatePickerRowState extends State<DatePickerRow> {
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  String _selectedMonth = 'Enero';

  final List<String> _months = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];

  DateTime? validateAndCombineDate() {
    int? day = int.tryParse(_dayController.text);
    int? year = int.tryParse(_yearController.text);
    int month = _months.indexOf(_selectedMonth) + 1;

    if (day == null ||
        year == null ||
        day < 1 ||
        day > 31 ||
        year < 1900 ||
        year > DateTime.now().year) {
      return null;
    }

    try {
      DateTime date = DateTime(year, month, day);
      return date;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Day TextField
        SizedBox(
          width: 65, // Set the desired width
          child: TextField(
            controller: _dayController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(
                  color: Color(0xFF229BB6), // Color del borde
                  width: 1.0, // Grosor del borde reducido
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(
                  color:
                      Color(0xFF229BB6), // Color del borde cuando está enfocado
                  width: 1.5, // Grosor del borde reducido
                ),
              ),
              labelText: 'Día',
              labelStyle: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0), // Label color
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: 0.50,
                  horizontal: 6.0), // Altura del padding reducida
              border: OutlineInputBorder(),
            ),
          ),
        ),

        const SizedBox(width: 5), // Spacer between elements

        Expanded(
          child: DropdownButtonFormField<String>(
            value: _selectedMonth,
            items: _months.map((String month) {
              return DropdownMenuItem<String>(
                value: month,
                child: Text(month),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedMonth = newValue!;
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
                  color:
                      Color(0xFF229BB6), // Color del borde cuando está enfocado
                  width: 1.5,
                ),
              ),
              labelText: 'Mes',
              labelStyle: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0), // Label color
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 8.0), // Altura del padding reducida
              border: OutlineInputBorder(),
            ),
          ),
        ),

        const SizedBox(width: 5), // Spacer between elements

        // Year TextField
        SizedBox(
          width: 75, // Set the desired width
          child: Expanded(
            child: TextField(
              controller: _yearController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(
                    color: Color(0xFF229BB6), // Color del borde
                    width: 1.0, // Grosor del borde reducido
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(
                    color: Color(
                        0xFF229BB6), // Color del borde cuando está enfocado
                    width: 1.5, // Grosor del borde reducido
                  ),
                ),
                labelText: 'Año',
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0), // Label color
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 2.0,
                    horizontal: 6.0), // Altura del padding reducida
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class GenderDropdown extends StatefulWidget {
  const GenderDropdown({super.key});

  @override
  GenderDropdownState createState() => GenderDropdownState();
}

class GenderDropdownState extends State<GenderDropdown> {
  String? _selectedGender; // Default value

  String getSelectedGender() {
    if (_selectedGender == null || _selectedGender!.isEmpty) {
      throw Exception('Por favor seleccione su sexo');
    }
    return _selectedGender!;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      items: const [
        DropdownMenuItem(
          value: 'Femenino',
          child: Text('Femenino'),
        ),
        DropdownMenuItem(
          value: 'Masculino',
          child: Text('Masculino'),
        ),
      ],
      onChanged: (String? newValue) {
        setState(() {
          _selectedGender = newValue!;
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
            vertical: 2.0,
            horizontal: 4.0), // Altura del padding reducida al mínimo
        border: OutlineInputBorder(),
      ),
    );
  }
}

//clase departamento
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
