import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Actividades2 extends StatefulWidget {
  const Actividades2({Key? key}) : super(key: key);

  @override
  State<Actividades2> createState() => _Actividades2State();
}

class _Actividades2State extends State<Actividades2> {
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    initTts();
  }

  // Inicializa el Text-To-Speech (TTS)
  Future<void> initTts() async {
    await flutterTts.setLanguage('es-ES');
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(2.0);
    await flutterTts.setPitch(1.0);
  }

  // Colores utilizados en la pantalla
  Color colorBoton1 = const Color(0xFF417123);
  Color colorBoton2 = const Color(0xFF417123);

  // Variables para almacenar datos de la actividad
  late String title;
  late String imageAsset;
  late String description;
  late String mailC;
  late String id;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Obtén los argumentos cuando el widget se inicializa
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Verifica si hay argumentos y extráelos
    if (arguments != null) {
      title = arguments['title'] ?? '';
      imageAsset = arguments['imageAsset'] ?? '';
      description = arguments['description'] ?? '';
      mailC = arguments['mailC'] ?? '';
      id = arguments['id'] ?? '';
      // Puedes extraer otros datos aquí
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Colores y radios utilizados en la pantalla
    Color customColor = const Color(0xFF5BDA57);
    Color customColor2 = const Color(0xFF2F2D2C);
    Color customColor3 = const Color(0xFFF2F5F0);
    double radius = 45.5;
    double radius2 = 15;

    // Tamaño del ícono
    double iconsize = screenHeight * 0.032;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor,
        elevation: 0,
        leading: GestureDetector(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.028),
            child: Image.asset(
              'assets/logo.png',
              width: screenWidth * 0.093,
              height: screenHeight * 0.093,
            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: screenHeight * 0.025,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
              size: screenHeight * 0.04,
            ),
            onPressed: () {
              // Detiene la reproducción de TTS antes de navegar
              flutterTts.stop();
              Navigator.pushNamed(context, '/configuracion');
            },
          ),
        ],
        toolbarHeight: screenHeight * 0.1,
      ),
      body: Stack(
        children: [
          // Sección superior con la imagen y detalles de la actividad
          Positioned(
            left: screenWidth * 0.055,
            right: screenWidth * 0.055,
            bottom: screenHeight * 0.39,
            child: Column(
              children: [
                // Imagen de la actividad
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: imageAsset.startsWith('http')
                      ? Image.network(
                          imageAsset,
                          width: screenWidth * 0.9,
                          height: screenHeight * 0.26,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          imageAsset,
                          width: screenWidth * 0.9,
                          height: screenHeight * 0.26,
                          fit: BoxFit.cover,
                        ),
                ),
                const SizedBox(height: 13),
                // Título y botón de favoritos
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: screenHeight * 0.025,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    IconButton(
                      onPressed: () {
                        // Detiene la reproducción de TTS antes de navegar
                        flutterTts.stop();
                        Navigator.pushNamed(
                          context,
                          '/actividadesComentario',
                          arguments: {
                            'title': title,
                            'imageAsset': imageAsset,
                            'description': description,
                            'mailC': mailC,
                            'id': id
                          },
                        );
                      },
                      icon: Icon(
                        Icons.favorite,
                        size: screenHeight * 0.035,
                        color: customColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Divider(
                  color: colorBoton1,
                  thickness: 1,
                  indent: 5,
                  endIndent: 5,
                ),
              ],
            ),
          ),
          // Botón de reproducción de voz
          Positioned(
            left: screenWidth * 0.0,
            right: screenWidth * 0.66,
            bottom: screenHeight * 0.33,
            child: IconButton(
              icon: Icon(
                Icons.volume_up,
                color: customColor,
                size: screenHeight * 0.039,
              ),
              onPressed: () {
                // Detiene la reproducción anterior antes de iniciar la nueva
                flutterTts.stop();
                speakDescription();
              },
            ),
          ),
          // Botón de ubicación
          Positioned(
            left: screenWidth * 0.66,
            right: screenWidth * 0.00,
            bottom: screenHeight * 0.329,
            child: IconButton(
              icon: Icon(
                Icons.location_on,
                color: customColor,
                size: screenHeight * 0.039,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/mapa');
              },
            ),
          ),
          // Sección de avatar y presentación
          Positioned(
              left: screenWidth * 0.0,
              right: screenWidth * 0.0,
              bottom: screenHeight * 0.228,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Avatar del usuario
                      Container(
                        width: screenWidth * 0.275,
                        height: screenHeight * 0.13,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            image: NetworkImage(
                                'https://icones.pro/wp-content/uploads/2021/05/symbole-de-l-homme-vert.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ],
              )),
          // Sección de descripción
          Positioned(
            bottom: screenHeight * 0.08,
            left: screenWidth * 0.013,
            right: screenWidth * 0.0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: Colors.white,
              height: 85,
              child: Text(
                'Presentacion',
                style: TextStyle(
                  color: customColor2,
                  fontSize: screenHeight * 0.025,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Botones de selección de voz/texto
          Positioned(
            left: screenWidth * 0.11,
            right: screenWidth * 0.11,
            bottom: screenHeight * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Botón de voz
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customColor3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(radius2),
                    ),
                  ),
                  child: Text(
                    'Voz',
                    style: TextStyle(
                      fontSize: screenHeight * 0.028,
                      color: colorBoton1,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Botón de texto
                ElevatedButton(
                  onPressed: () {
                    // Detiene la reproducción de TTS antes de navegar
                    flutterTts.stop();
                    Navigator.pushNamed(
                      context,
                      '/actividades3',
                      arguments: {
                        'title': title,
                        'imageAsset': imageAsset,
                        'description': description,
                        'mailC': mailC,
                        'id': id
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customColor3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(radius2),
                    ),
                  ),
                  child: Text(
                    'Texto',
                    style: TextStyle(
                      fontSize: screenHeight * 0.028,
                      color: colorBoton2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // Barra de navegación inferior
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
            bottom: screenHeight * 0.015), // Ajusta según tu necesidad
        padding: EdgeInsets.only(
            left: screenWidth * 0.07, right: screenWidth * 0.07),
        child: Container(
          height: screenHeight * 0.09,
          decoration: BoxDecoration(
            color: customColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              topRight: Radius.circular(radius),
              bottomLeft: Radius.circular(radius),
              bottomRight: Radius.circular(radius),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Botón de actividades
              IconButton(
                icon: Icon(
                  Icons.image,
                  color: Colors.white,
                  size: iconsize,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/actividades');
                },
              ),
              // Botón de gastronomía
              IconButton(
                icon: Icon(
                  Icons.restaurant,
                  color: Colors.white,
                  size: iconsize,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/gastronomia');
                },
              ),
              // Botón de mapa
              IconButton(
                icon: Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                  size: iconsize,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/mapa');
                },
              ),
              // Botón de escaneo QR
              IconButton(
                icon: Icon(
                  Icons.qr_code,
                  color: Colors.white,
                  size: iconsize,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/qrscan');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Función para iniciar la reproducción de la descripción en voz
  Future<void> speakDescription() async {
    await flutterTts.speak(description);
  }
}
