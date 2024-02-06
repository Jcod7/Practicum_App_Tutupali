import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'screens.dart';

// Definición del widget Reservaciones que extiende StatefulWidget
class Reservaciones extends StatefulWidget {
  const Reservaciones({Key? key}) : super(key: key);

  @override
  State<Reservaciones> createState() => _ReservacionesState();
}

// Estado asociado al widget Reservaciones
class _ReservacionesState extends State<Reservaciones> {
  @override
  Widget build(BuildContext context) {
    // Definición de colores y dimensiones
    Color customColor = const Color(0xFF5BDA57);
    Color customColor2 = const Color(0xFF483332);
    Color customColor3 = const Color(0xFFF2F5F0);

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double radius = screenHeight * 0.057;
    double iconsize = screenHeight * 0.032;

    // Estructura del widget: Scaffold con AppBar, cuerpo, y barra de navegación inferior
    return Scaffold(
      appBar: AppBar(
        // AppBar personalizada con título, color y acciones
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
          'CONFIGURACION',
          style: TextStyle(
            color: Colors.white,
            fontSize: screenHeight * 0.025,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
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
          // Posicionamiento de elementos en la pantalla usando el widget Stack
          Positioned(
            top: screenHeight * 0.045,
            left: 13,
            right: 0,
            child: Container(
              // Contenedor con título 'Tus Reservaciones'
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
              color: Colors.white,
              height: screenHeight * 0.12,
              child: Text(
                'Tus Reservaciones',
                style: TextStyle(
                  color: customColor2,
                  fontSize: screenHeight * 0.027,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.11,
            left: screenWidth * 0.02,
            right: screenWidth * 0.02,
            bottom: screenHeight * 0.05,
            child: FutureBuilder<List<ReservasModel>>(
              // Uso de FutureBuilder para cargar las reservas
              future: fetchReservas(),
              builder: (context, reservasSnapshot) {
                if (reservasSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (reservasSnapshot.hasError) {
                  return Text('Error: ${reservasSnapshot.error}');
                } else if (!reservasSnapshot.hasData ||
                    reservasSnapshot.data!.isEmpty) {
                  return const Text('No hay reservas disponibles.');
                } else {
                  List<ReservasModel> reservas = reservasSnapshot.data!;

                  return FutureBuilder<List<RestaurantesModel>>(
                    // Uso de FutureBuilder para cargar los restaurantes
                    future: fetchRestaurantes(),
                    builder: (context, restaurantesSnapshot) {
                      if (restaurantesSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (restaurantesSnapshot.hasError) {
                        return Text('Error: ${restaurantesSnapshot.error}');
                      } else if (!restaurantesSnapshot.hasData ||
                          restaurantesSnapshot.data!.isEmpty) {
                        return const Text('No hay restaurantes disponibles.');
                      } else {
                        List<RestaurantesModel> restaurantes =
                            restaurantesSnapshot.data!;

                        return ListView.builder(
                          // Uso de ListView.builder para mostrar las reservas
                          itemCount: reservas.length,
                          itemBuilder: (BuildContext context, int index) {
                            ReservasModel reserva = reservas[index];
                            // Buscar el restaurante correspondiente
                            RestaurantesModel restaurante = restaurantes
                                .firstWhere((r) => r.id == reserva.restaurante);

                            String estadoReserva = reserva.estado;
                            Color colorEstado = estadoReserva == 'Pendiente'
                                ? Colors.yellow
                                : (estadoReserva == 'Finalizada'
                                    ? Colors.green
                                    : Colors.red);

                            return Container(
                              // Contenedor de cada reserva
                              margin: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.01,
                                horizontal: screenWidth * 0.04,
                              ),
                              decoration: BoxDecoration(
                                color: customColor3,
                                borderRadius:
                                    BorderRadius.circular(screenHeight * 0.018),
                              ),
                              child: Stack(
                                children: [
                                  ListTile(
                                    // Detalles de la reserva
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.04,
                                    ),
                                    leading: Container(
                                      width: screenWidth * 0.24,
                                      height: screenHeight * 0.18,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            screenHeight * 0.018),
                                        image: DecorationImage(
                                          image: NetworkImage(restaurante
                                              .img), // Usar la imagen del restaurante
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      restaurante
                                          .restaurante, // Usar el título del restaurante
                                      style: TextStyle(
                                        fontSize: screenHeight * 0.02,
                                        fontWeight: FontWeight.bold,
                                        color: customColor2,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Fecha: ${DateFormat('dd-MM-yyyy').format(reserva.fecha)}',
                                          style: TextStyle(
                                            fontSize: screenHeight * 0.015,
                                            color: customColor2,
                                          ),
                                        ),
                                        Text(
                                          'Hora: ${reserva.hora}',
                                          style: TextStyle(
                                            fontSize: screenHeight * 0.015,
                                            color: customColor2,
                                          ),
                                        ),
                                        Text(
                                          '# personas: ${reserva.personas}',
                                          style: TextStyle(
                                            fontSize: screenHeight * 0.015,
                                            color: customColor2,
                                          ),
                                        ),
                                        Text(
                                          'VIP: ${reserva.vip == "1" ? 'Sí' : 'No'}',
                                          style: TextStyle(
                                            fontSize: screenHeight * 0.015,
                                            color: customColor2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      color: customColor2,
                                    ),
                                    onTap: () {
                                      // Aquí podría ir la lógica para cancelar
                                    },
                                  ),
                                  Positioned(
                                    top: screenHeight * 0.01,
                                    right: screenWidth * 0.01,
                                    child: Text(
                                      '#: ${reserva.id}',
                                      style: TextStyle(
                                        fontSize: screenHeight * 0.013,
                                        fontWeight: FontWeight.bold,
                                        color: customColor2,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: screenHeight * 0.01,
                                    right: screenWidth * 0.01,
                                    child: Container(
                                      // Estado de la reserva
                                      padding:
                                          EdgeInsets.all(screenHeight * 0.004),
                                      decoration: BoxDecoration(
                                        color: colorEstado,
                                        borderRadius: BorderRadius.circular(
                                            screenHeight * 0.006),
                                      ),
                                      child: Text(
                                        estadoReserva,
                                        style: TextStyle(
                                          fontSize: screenHeight * 0.012,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        // Barra de navegación inferior
        margin: EdgeInsets.only(bottom: screenHeight * 0.015),
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
