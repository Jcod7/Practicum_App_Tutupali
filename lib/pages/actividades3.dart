import 'package:flutter/material.dart';

class Actividades3 extends StatefulWidget {
  const Actividades3({super.key});

  @override
  State<Actividades3> createState() => _Actividades3State();
}

class _Actividades3State extends State<Actividades3> {
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
      // Puedes hacer lo que quieras con estos datos
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Colores utilizados en la pantalla
    Color customColor = const Color(0xFF5BDA57);
    Color customColor2 = const Color(0xFF2F2D2C);
    Color customColor3 = const Color(0xFFF2F5F0);
    Color customColor4 = const Color(0xFF9B9B9B);

    // Radios y tamaño de íconos utilizados
    double radius = 45.5;
    double radius2 = 15;
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
            bottom: screenHeight * 0.42,
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
              ],
            ),
          ),
          // Calificación de la actividad
          Positioned(
            left: screenWidth * 0.0,
            right: screenWidth * 0.57,
            bottom: screenHeight * 0.39,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: customColor,
                  size: screenHeight * 0.0255,
                ),
                const SizedBox(width: 5),
                Text(
                  'Calificación: 4.5',
                  style: TextStyle(
                    fontSize: screenHeight * 0.0175,
                    color: customColor4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Separador entre secciones
          Positioned(
            left: screenWidth * 0.0,
            right: screenWidth * 0.0,
            bottom: screenHeight * 0.36,
            child: Column(
              children: [
                const SizedBox(height: 5),
                Divider(
                  color: colorBoton1,
                  thickness: 1,
                  indent: 28,
                  endIndent: 28,
                ),
              ],
            ),
          ),
          // Sección de descripción
          Positioned(
            left: screenWidth * 0.022,
            right: screenWidth * 0.0,
            bottom: screenHeight * 0.3,
            child: Container(
              width: screenWidth * 0.1,
              height: screenHeight * 0.06,
              padding: EdgeInsets.all(screenWidth * 0.028),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Descripcion',
                style: TextStyle(
                  color: customColor2,
                  fontSize: screenHeight * 0.025,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Contenedor de la descripción
          Positioned(
            left: screenWidth * 0.025,
            right: screenWidth * 0.055,
            bottom: screenHeight * 0.15,
            child: Container(
              width: screenWidth * 0.095,
              height: screenHeight * 0.155,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                description,
                style: TextStyle(
                  color: customColor4,
                  fontSize: screenHeight * 0.015,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          // Sección de presentación
          Positioned(
            bottom: screenHeight * 0.055,
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
            bottom: screenHeight * 0.037,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Botón de voz
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/actividades2',
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
                  onPressed: () {},
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
}
