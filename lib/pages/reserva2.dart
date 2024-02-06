import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'screens.dart';

// Definición del widget Reserva2 que extiende StatefulWidget
class Reserva2 extends StatefulWidget {
  const Reserva2({super.key});

  @override
  State<Reserva2> createState() =>
      _Reserva2State(); // Crear el estado del widget
}

// Estado del widget Reserva2
class _Reserva2State extends State<Reserva2> {
  // Declaración de variables necesarias para almacenar la información de la reserva
  late String nombreCompleto;
  late String numeroTelefono;
  late String correoElectronico;
  late String numeroPersonas;
  late bool zonaVIP;
  late DateTime fecha;
  late TimeOfDay hora;
  late String restaurante;
  late String idRestaurante;
  late String notas;

  // Método llamado cuando el estado del widget cambia
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Recuperar argumentos de la ruta (pantalla anterior)
    Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    // Verificar si hay argumentos y extraer la información necesaria
    if (arguments != null) {
      nombreCompleto = arguments['nombreCompleto'];
      numeroTelefono = arguments['numeroTelefono'];
      correoElectronico = arguments['correoElectronico'];
      numeroPersonas = arguments['numeroPersonas'];
      zonaVIP = arguments['zonaVIP'];
      fecha = arguments['fecha'];
      hora = arguments['hora'];
      restaurante = arguments['restaurante'];
      idRestaurante = arguments['idRestaurante'];
      notas = arguments['notas'];
    }
  }

  // Método para formatear la hora en un formato deseado
  String formatHora(TimeOfDay time) {
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }

  // Método de construcción del widget
  @override
  Widget build(BuildContext context) {
    // Obtener dimensiones de la pantalla
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Definir colores y estilos personalizados
    Color customColor = const Color(0xFF5BDA57);
    Color colorBoton1 = const Color(0xFF417123);
    Color customColor3 = const Color(0xFFF2F5F0);
    double radius = 45.5;
    double iconsize = screenHeight * 0.032;

    // Estructura del widget: Scaffold con AppBar, cuerpo, y barra de navegación inferior
    return Scaffold(
      appBar: AppBar(
        // AppBar personalizada con título y acciones
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
          'GASTRONOMIA',
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
          // Posicionamiento de elementos en la pantalla usando el widget Stack
          Positioned(
            left: screenWidth * 0.055,
            right: screenWidth * 0.055,
            top: screenHeight * 0.02,
            child: Center(
              child: Text(
                'CONFIRMA LA RESERVACION',
                style: TextStyle(
                  color: colorBoton1,
                  fontSize: screenHeight * 0.029,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.055,
            right: screenWidth * 0.055,
            top: screenHeight * 0.08,
            child: Center(
              child: Container(
                // Contenedor central de la pantalla con detalles de la reserva
                width: screenWidth * 15,
                height: screenHeight * 0.56,
                decoration: BoxDecoration(
                  color: customColor3,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Center(
                      child: Text(
                        'Fecha: ${DateFormat('dd-MM-yyyy').format(fecha)}',
                        style: TextStyle(
                          color: colorBoton1,
                          fontSize: screenHeight * 0.029,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.location_on,
                                color: colorBoton1,
                                size: screenHeight * 0.03,
                              ),
                            ),
                            TextSpan(
                              text: 'Restaurante: $restaurante',
                              style: TextStyle(
                                color: colorBoton1,
                                fontSize: screenHeight * 0.029,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Botones para mostrar detalles como fecha, hora y número de personas
                        ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            minimumSize: const Size(40, 65),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.access_time,
                                color: colorBoton1,
                                size: screenHeight * 0.03,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Hora: ${formatHora(hora)}',
                                style: TextStyle(
                                  color: colorBoton1,
                                  fontSize: screenHeight * 0.018,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: customColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            minimumSize: const Size(40, 65),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                color: colorBoton1,
                                size: screenHeight * 0.03,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '# Personas: $numeroPersonas',
                                style: TextStyle(
                                  color: colorBoton1,
                                  fontSize: screenHeight * 0.018,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 41),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: screenWidth * 0.85,
                            height: screenHeight * 0.21,
                            decoration: BoxDecoration(
                              color: customColor3,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: colorBoton1,
                                width: 2,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 6,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Text(
                                'Información:',
                                style: TextStyle(
                                  color: colorBoton1,
                                  fontSize: screenHeight * 0.026,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.85,
                            height: screenHeight * 0.21,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 25),
                                Text(
                                  'Nombre: $nombreCompleto',
                                  style: TextStyle(
                                    color: colorBoton1,
                                    fontSize: screenHeight * 0.021,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '# Telefono: $numeroTelefono',
                                  style: TextStyle(
                                    color: colorBoton1,
                                    fontSize: screenHeight * 0.021,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Correo: $correoElectronico',
                                  style: TextStyle(
                                    color: colorBoton1,
                                    fontSize: screenHeight * 0.021,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            // Botones inferiores para cancelar y confirmar la reserva
            left: screenWidth * 0.055,
            right: screenWidth * 0.055,
            top: screenHeight * 0.67,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: colorBoton1,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: colorBoton1),
                      ),
                      minimumSize: const Size(40, 45),
                    ),
                    child: Text(
                      'CANCELAR',
                      style: TextStyle(
                        color: colorBoton1,
                        fontSize: screenHeight * 0.021,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Instancia de la clase ApiReservas
                      ApiReservas apiReservas = ApiReservas();

                      // Enviar la reserva al API
                      try {
                        bool exito = await apiReservas.enviarReserva(
                          // Parámetros de la reserva
                          nombreCompleto: nombreCompleto,
                          numeroTelefono: numeroTelefono,
                          correoElectronico: correoElectronico,
                          numeroPersonas: numeroPersonas,
                          zonaVIP: zonaVIP,
                          fecha: fecha,
                          hora: hora,
                          restaurante: idRestaurante,
                          notas: notas,
                        );

                        // Verificar si la reserva se envió con éxito
                        if (exito) {
                          // Si la reserva se envió con éxito, navegar a la siguiente pantalla
                          Navigator.pushNamed(context, '/reserva3');
                        } else {
                          // Si hubo un error al enviar la reserva, mostrar un mensaje de error
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Error'),
                                content: const Text(
                                    'Hubo un error al confirmar la reserva. Inténtalo de nuevo.'),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      } catch (e) {
                        print('Error al enviar la reserva: $e');
                        // Manejar el error según sea necesario
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: customColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: const Size(40, 45),
                    ),
                    child: Text(
                      'CONFIRMAR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenHeight * 0.021,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Barra de navegación inferior con íconos y rutas
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
            bottom: screenHeight * 0.015), // Ajustar según necesidad
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
              // Íconos de la barra inferior con rutas correspondientes
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
