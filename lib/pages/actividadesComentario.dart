import 'package:flutter/material.dart';
import 'screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ActividadesComentario extends StatefulWidget {
  const ActividadesComentario({super.key});

  @override
  State<ActividadesComentario> createState() => _ActividadesComentarioState();
}

class _ActividadesComentarioState extends State<ActividadesComentario> {
  // Instancia de la clase ApiComentarios para manejar los comentarios
  ApiComentarios apiComentarios = ApiComentarios();
  
  // Controlador para el campo de texto del comentario
  TextEditingController comentarioController = TextEditingController();

  // Variable para almacenar la calificación del usuario
  int _rating = 0;

  // Método para actualizar la calificación
  void _setRating(int rating) {
    setState(() {
      _rating = rating;
    });
  }

  // Variables para almacenar información de la actividad
  late String title;
  late String imageAsset;
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
      mailC = arguments['mailC'] ?? '';
      id = arguments['id'] ?? '';
      // Puedes hacer lo que quieras con estos datos
    }
  }

  // Método para enviar el comentario a la base de datos
  Future<void> enviarComentario() async {
    // Obtén el valor del comentario del TextField
    String comentario = comentarioController.text;

    // Obtén el valor del correo electrónico y la actividad
    String email = mailC;
    String actividad = id;

    // Envía el comentario a la base de datos utilizando la instancia de ApiComentarios
    bool comentarioEnviado = await apiComentarios.enviarComentario(
      comentario: comentario,
      email: email,
      actividad: actividad,
    );

    if (comentarioEnviado) {
      // Éxito
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Éxito',
              style: TextStyle(color: Colors.white),
            ),
            content: const Text(
              'Comentario enviado correctamente',
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            backgroundColor: Colors.green, // Color verde para éxito
          );
        },
      );
    } else {
      // Error
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Error',
              style: TextStyle(color: Colors.white),
            ),
            content: const Text(
              'Hubo un error al enviar el comentario',
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            backgroundColor: Colors.red, // Color rojo para error
          );
        },
      );
    }
  }

  @override
  void dispose() {
    // Libera el controlador cuando el widget se descarte
    comentarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Colores y tamaños utilizados en la pantalla
    Color customTextColor = const Color(0xFF417123);
    Color customColor = const Color(0xFF5BDA57);
    double radius = 45.5;
    double iconsize = screenHeight * 0.032;
    double iconSize = screenHeight * 0.028;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: customColor,
        elevation: 0,
        // Logo en la barra de navegación
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
          // Botón de retroceso en la barra de navegación
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            iconSize: screenHeight * 0.046,
          ),
        ],
        toolbarHeight: screenHeight * 0.1,
      ),
      body: Stack(
        children: [
          // Sección superior con imagen y detalles de la actividad
          Positioned(
            left: screenWidth * 0.055,
            right: screenWidth * 0.055,
            top: screenHeight * 0.023,
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
                const SizedBox(height: 15),
                // Título de la actividad
                Text(
                  title,
                  style: TextStyle(
                    fontSize: screenHeight * 0.025,
                    color: customTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
          // Sección de calificación y comentario
          Positioned(
              left: screenWidth * 0.055,
              right: screenWidth * 0.055,
              top: screenHeight * 0.353,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Barra de calificación (estrellas)
                      Row(
                        children: List.generate(6, (index) {
                          return GestureDetector(
                            onTap: () {
                              _setRating(index + 1);
                            },
                            child: Icon(
                              index < _rating
                                  ? Icons.star
                                  : Icons.star_border,
                              color: customColor,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  // Etiqueta "Tu Comentario"
                  Text(
                    'Tu Comentario',
                    style: TextStyle(
                      fontSize: screenHeight * 0.022,
                      color: customTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )),
          // Sección de entrada de comentario y opciones de compartir
          Positioned(
            left: screenWidth * 0.065,
            right: screenWidth * 0.065,
            top: screenHeight * 0.46,
            child: Column(
              children: [
                // Entrada de comentario (TextField)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: comentarioController,
                        minLines: 6,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Comentario',
                          border: const OutlineInputBorder(),
                          labelStyle: const TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: customColor),
                          ),
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 3),
                    // Iconos para compartir en redes sociales
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.google,
                            color: customColor,
                            size: iconSize,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.facebook,
                            color: customColor,
                            size: iconSize,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.twitter,
                            color: customColor,
                            size: iconSize,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.share,
                            color: customColor,
                            size: iconSize,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 1),
                // Botones para adjuntar imagen y enviar comentario
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.image,
                        color: customColor,
                        size: iconSize,
                      ),
                    ),
                    const SizedBox(width: 6),
                    TextButton(
                      onPressed: () {
                        enviarComentario();
                      },
                      child: Text(
                        'Enviar',
                        style: TextStyle(
                          color: customColor,
                          fontSize: screenHeight * 0.02,
                        ),
                      ),
                    ),
                  ],
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
              // Botones de la barra de navegación inferior
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
