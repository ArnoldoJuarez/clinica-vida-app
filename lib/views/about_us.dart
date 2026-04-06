import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(34, 155, 182, 0.75),
        ),
        child: Column(
          children: [
            // Header
            Container(
              color: const Color.fromRGBO(34, 155, 182, 0.10),
              height: 230,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Stack(
                children: [
                  Positioned(
                    top: 8,
                    left: 4,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/close_white.svg', // Path to your SVG
                        semanticsLabel: 'My SVG Image',
                        height: 20,
                        width: 20,
                      ),
                      onPressed: () {
                        // Add your close action here
                      },
                    ),
                  ),
                  Center(
                    child: SvgPicture.asset(
                      'assets/icons/users_circle_white.svg', // Path to your SVG
                      semanticsLabel: 'My SVG Image',
                      height: 110,
                      width: 110,
                    ),
                  )
                ],
              ),
            ),
            // Body with rounded top corners
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(48),
                    topRight: Radius.circular(48),
                  ),
                ),
                child: Column(
                  children: [
                    // Row of buttons with icons
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/phone_circle.svg', // Path to your SVG
                          semanticsLabel: 'My SVG Image',
                          height: 80,
                          width: 80,
                        ),
                        const SizedBox(height: 45),
                        SvgPicture.asset(
                          'assets/icons/whatsapp_circle.svg', // Path to your SVG
                          semanticsLabel: 'My SVG Image',
                          height: 80,
                          width: 80,
                        ),
                        const SizedBox(height: 45),
                        SvgPicture.asset(
                          'assets/icons/location_circle.svg', // Path to your SVG
                          semanticsLabel: 'My SVG Image',
                          height: 80,
                          width: 80,
                        ),
                      ],
                    ),
                    // Space for text lines
                    const Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(16),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 16.0), // Add padding to the left
                                    child: Text(
                                      'Información de contacto',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight:
                                            FontWeight.bold, // Make text bold
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 25),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 16.0), // Add padding to the left
                                    child: Text(
                                      'Teléfono: ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight:
                                            FontWeight.bold, // Make text bold
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '2252-2222',
                                    style:
                                        TextStyle(fontSize: 16 // Make text bold
                                            ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 25),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 16.0), // Add padding to the left
                                    child: Text(
                                      'WhatsApp: ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight:
                                            FontWeight.bold, // Make text bold
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '7854-7984',
                                    style:
                                        TextStyle(fontSize: 16 // Make text bold
                                            ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 0),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 16.0), // Add padding to the left
                                    child: Text(
                                      'Dirección: ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight:
                                            FontWeight.bold, // Make text bold
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    // Constrains the text to available space
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 45),
                                      child: Text(
                                        'San Salvador, San Salvador, Colonia muy lejana, Calle por doquier, Edificio 2.',
                                        style: TextStyle(fontSize: 16),
                                        softWrap:
                                            true, // Ensures the text will wrap
                                        overflow: TextOverflow
                                            .visible, // Makes the text visible when wrapped
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
