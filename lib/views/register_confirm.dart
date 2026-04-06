import 'package:clinica_vida_app/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterConfirm extends StatelessWidget {
  const RegisterConfirm({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: Material(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Adjust size to only wrap content
            children: [
              const SizedBox(height: 200),
              SvgPicture.asset(
                'assets/icons/check_confirm.svg', // Path to your SVG
                semanticsLabel: 'My SVG Image',
                height: 80,
                width: 80,
              ),
              const SizedBox(
                  height: 10), // Adds space between the icon and the text
              const Text(
                'Registro exitoso', // Your desired text
                style: TextStyle(
                  fontSize: 18, // Font size of the text
                  color: Colors.black, // Color of the text
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 70.0),
                child: Text(
                  'El proceso de registro se realizó con exito. Te hemos', // Your desired text
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12, // Font size of the text
                    color: Colors.black, // Color of the text
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 105.0),
                child: Text(
                  'enviado un correo electrónico verificando tu nueva cuenta.', // Your desired text
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12, // Font size of the text
                    color: Colors.black, // Color of the text
                  ),
                ),
              ),
              const SizedBox(height: 120),
              Padding(
                // Wrap button in Padding for bottom margin
                padding: const EdgeInsets.only(top: 75),
                child: Center(
                  child: FilledButton(
                    onPressed: () {
                      
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(159, 34, 155, 182),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Rounded corners
                      ),
                      side: const BorderSide(
                        color: Color(0xFF229BB6), // Border color using hex
                        width: 3.0, // Border width
                      ),
                      minimumSize: const Size(360, 50), // Full-width button
                    ),
                    child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text('Comenzar',
                            style:
                                TextStyle(fontSize: 22, color: Colors.white))),
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
