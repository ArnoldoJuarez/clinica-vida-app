import 'package:clinica_vida_app/controllers/citas_controllers.dart';
import 'package:clinica_vida_app/models/citas_model.dart';
import 'package:clinica_vida_app/models/doctor_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ScheduleAppointmentScreen extends StatefulWidget {
  final Doctor doctor;
  final String pacienteId;
  final String pacienteNombre;

  const ScheduleAppointmentScreen({super.key, 
    required this.doctor,
    required this.pacienteId,
    required this.pacienteNombre,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ScheduleAppointmentScreenState createState() => _ScheduleAppointmentScreenState();
}

class _ScheduleAppointmentScreenState extends State<ScheduleAppointmentScreen> {
  final CitaController citaController = CitaController();
  final TextEditingController _notasController = TextEditingController();
  DateTime? _selectedDay;
  TimeOfDay? _selectedTime;

  void _crearCita(BuildContext context) async {
    if (_selectedDay != null && _selectedTime != null && _notasController.text.isNotEmpty) {
      DateTime fechaHora = DateTime(
        _selectedDay!.year,
        _selectedDay!.month,
        _selectedDay!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      Cita nuevaCita = Cita(
        citaId: FirebaseFirestore.instance.collection('citas').doc().id,
        doctorId: widget.doctor.id,
        nombreDoctor: widget.doctor.nombre,
        pacienteId: widget.pacienteId,
        nombrePaciente: widget.pacienteNombre,
        fechaHora: fechaHora,
        estado: 'confirmada',
        notas: _notasController.text,
        especialidadDoctor: widget.doctor.especialidad,
        ubicacionCita: widget.doctor.ubicacion,
        metodoPago: 'efectivo', // Puedes ajustar esto según tu lógica de pago
        duracionCita: widget.doctor.duracionCita,
        costoCita: widget.doctor.costoCita,
        estadoPago: 'pendiente', // Puedes ajustar esto según tu lógica de pago
        fechaCreacion: DateTime.now(),
      );

      await citaController.guardarCitaEnFirestore(nuevaCita);

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cita creada con éxito')),
      );

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa todos los campos.')),
      );
    }
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDay ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDay) {
      setState(() {
        _selectedDay = picked;
      });
    }
  }

  Future<void> _pickTime(BuildContext context) async {
  try {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  } catch (e) {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error al seleccionar la hora: $e')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Programar Cita'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Seleccionar Fecha y Hora:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _pickDate(context),
              child: Text(_selectedDay != null
                  ? 'Fecha: ${_selectedDay!.toLocal()}'.split(' ')[0]
                  : 'Seleccionar Fecha'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _pickTime(context),
              child: Text(_selectedTime != null
                  ? 'Hora: ${_selectedTime!.format(context)}'
                  : 'Seleccionar Hora'),
            ),
            const SizedBox(height: 8),
            const Text(
              'Notas:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: _notasController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ingrese notas adicionales',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _crearCita(context),
              child: const Text('Confirmar Cita'),
            ),
          ],
        ),
      ),
    );
  }
}