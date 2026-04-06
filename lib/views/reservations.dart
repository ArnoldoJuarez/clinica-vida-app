import 'dart:io';

import 'package:clinica_vida_app/controllers/citas_controllers.dart';
import 'package:clinica_vida_app/models/citas_model.dart';
import 'package:clinica_vida_app/views/perfil_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class Reservations extends StatefulWidget {
final String uid;

  const Reservations({super.key, required this.uid});

  @override
  State<Reservations> createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  final CitaController citaController = CitaController();
  

  @override
  void initState() {
    super.initState();
   citaController.obtenerCitasPorPacienteId(widget.uid);
  }

  // Mapa de especialidades a iconos
  final Map especialidadIconos = {
    'Consulta Medica': 'assets/icons/bag.svg',
    'Rayos X': 'assets/icons/x_ray.svg',
    'Laboratorio': 'assets/icons/lab.svg',
    'Pediatría': 'assets/icons/kids.svg',
    'Odontología': 'assets/icons/teeth.svg',
    'Ginecología': 'assets/icons/cervical_cancer.svg',
    'Mamografía': 'assets/icons/breast_mammoplasty.svg',
    'Gastroenterología': 'assets/icons/stomatch.svg',
  };

  // Generar el PDF
  Future<void> _generatePdf(Cita cita) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('CLINICA VIDA',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text('Comprobante de cita Médica',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text('Detalles de la Cita',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text('Especialidad: ${cita.especialidadDoctor}',
                  style: const pw.TextStyle(fontSize: 18)),
              pw.Text('Hora: ${cita.fechaHora.hour}:${cita.fechaHora.minute}',
                  style: const pw.TextStyle(fontSize: 18)),
              pw.Text(
                  'Fecha: ${cita.fechaHora.day}/${cita.fechaHora.month}/${cita.fechaHora.year}',
                  style: const pw.TextStyle(fontSize: 18)),
              pw.Text(
                  'Precio a cancelar: \$${cita.costoCita.toStringAsFixed(2)}',
                  style: const pw.TextStyle(fontSize: 18)),
              pw.Text('Nombre del Doctor: ${cita.nombreDoctor}',
                  style: const pw.TextStyle(fontSize: 18)),
              pw.Text('Nombre del Paciente: ${cita.nombrePaciente}',
                  style: const pw.TextStyle(fontSize: 18)),
              pw.Text('Ubicación de la Cita: ${cita.ubicacionCita}',
                  style: const pw.TextStyle(fontSize: 18)),
              pw.Text('Método de Pago: ${cita.metodoPago}',
                  style: const pw.TextStyle(fontSize: 18)),
            ],
          );
        },
      ),
    );

    // Guardar el PDF en el dispositivo
    final output = await getExternalStorageDirectory();
    final file = File("${output!.path}/cita_detalles.pdf");
    await file.writeAsBytes(await pdf.save());
    // ignore: avoid_print
    print("PDF guardado en: ${file.path}");

    // Abrir el PDF
    await OpenFile.open(file.path);
  }

  //eliminar cita
  Future<void> _confirmDelete(BuildContext context, Cita cita) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content:
              const Text('¿Estás seguro de que deseas eliminar esta cita?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await citaController.eliminarCitaDeFirestore(cita.citaId);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cita eliminada')),
      );
      setState(() {
      citaController.obtenerCitasPorPacienteId(widget.uid);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(34, 155, 182, 0.72),
        title: const Text(
          'Inicio',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                'Clinica Vida',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder(
        // future: citaController.obtenerCitasDesdeFirestore(),
        future: citaController.obtenerCitasPorPacienteId(widget.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay citas disponibles'));
          } else {
            final citas = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: citas.length,
                itemBuilder: (context, index) {
                  final cita = citas[index];
                  final iconPath =
                      especialidadIconos[cita.especialidadDoctor] ??
                          'assets/icons/default.svg';
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          iconPath,
                          width: 30.0,
                          height: 30.0,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cita.especialidadDoctor,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                  'Hora: ${cita.fechaHora.hour}:${cita.fechaHora.minute}'),
                              Text(
                                  'Fecha: ${cita.fechaHora.day}/${cita.fechaHora.month}/${cita.fechaHora.year}'),
                              const SizedBox(height: 4),
                              Text(
                                  'Nombre del Paciente: ${cita.nombrePaciente}'),
                              const SizedBox(height: 4),
                              Center(
                                child: Text(
                                    'Precio a cancelar: \$${cita.costoCita.toStringAsFixed(2)}'),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.print),
                          onPressed: () {
                            _generatePdf(cita);
                          },
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/icons/black_trash.svg',
                            width: 24.0,
                            height: 24.0,
                          ),
                          onPressed: () {
                            _confirmDelete(context, cita);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color:
            const Color.fromRGBO(34, 155, 182, 0.75), // Footer background color
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /* IconButton(
                icon: SvgPicture.asset('assets/icons/hospital.svg'),
                onPressed: () {},
              ),*/
              IconButton(
                icon: SvgPicture.asset('assets/icons/clipboard-list.svg'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Reservations(uid: widget.uid)),
                  );
                },
              ),
              IconButton(
                icon: SvgPicture.asset('assets/icons/user-cog.svg'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PerfilUser(uid: widget.uid)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
