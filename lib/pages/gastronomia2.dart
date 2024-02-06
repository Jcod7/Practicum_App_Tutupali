import 'package:flutter/material.dart';
import 'screens.dart';

class Gastronomia2 extends StatefulWidget {
  const Gastronomia2({super.key});

  @override
  State<Gastronomia2> createState() => _Gastronomia2State();
}

class _Gastronomia2State extends State<Gastronomia2> {
  // Declaración de variables para almacenar datos del plato y restaurante
  late String plato;
  late String img;
  late String precio;
  late String restaurantee;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Recuperar argumentos
    Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    // Verificar si hay argumentos y extraer la información necesaria
    if (arguments != null) {
      plato = arguments['plato'];
      img = arguments['img'];
      precio = arguments['precio'];
      restaurantee = arguments['restaurante'];
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Colores utilizados en la interfaz
    Color colorBoton1 = const Color(0xFF417123);
    Color customColor = const Color(0xFF5BDA57);
    Color colorRec = const Color(0xFFE1FFE0);

    double radius = 45.5;
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
          Positioned(
            // Sección de información sobre restaurantes disponibles
            left: screenWidth * 0.055,
            right: screenWidth * 0.055,
            bottom: screenHeight * 0.016,
            child: SizedBox(
              height: screenHeight * 0.4,
              child: FutureBuilder<List<RestaurantesModel>>(
                future: fetchRestaurantes(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<RestaurantesModel> restaurantesList = snapshot.data!;

                    // Filtra la lista de restaurantes por ID
                    restaurantesList = restaurantesList
                        .where((restaurante) => restaurante.id == restaurantee)
                        .toList();

                    if (restaurantesList.isEmpty) {
                      return const Text("No se encontró el restaurante");
                    }

                    return ListView.builder(
                      itemCount: restaurantesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        RestaurantesModel restaurante = restaurantesList[index];

                        return Column(
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.all(0.0),
                              title: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: NetworkImage(restaurante.img),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.all(screenWidth * 0.028),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            restaurante.restaurante,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: screenHeight * 0.023,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            restaurante.direccion,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: screenHeight * 0.02,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        width: screenWidth * 0.36,
                                        padding:
                                            EdgeInsets.all(screenWidth * 0.028),
                                        decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                          ),
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                              context,
                                              '/reserva',
                                              arguments: {
                                                'restaurante':
                                                    restaurante.restaurante,
                                                'id': restaurante.id
                                              },
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: colorRec,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                          child: Text(
                                            'Reservar',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: screenHeight * 0.018,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 0.0),
                          ],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Text("Error al cargar los datos");
                  }

                  // Mientras se cargan los datos, podrías mostrar un indicador de carga
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ),
          Positioned(
            // Sección de información sobre el plato seleccionado
            left: screenWidth * 0.055,
            right: screenWidth * 0.00,
            bottom: screenHeight * 0.43,
            child: Text(
              'Restaurantes Disponibles',
              style: TextStyle(
                color: colorBoton1,
                fontSize: screenHeight * 0.025,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.055,
            right: screenWidth * 0.055,
            top: screenHeight * 0.02,
            child: Container(
              width: screenWidth * 0.093,
              height: screenHeight * 0.26,
              decoration: BoxDecoration(
                color: colorRec,
                border: Border.all(color: colorRec),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: img.startsWith('http')
                        ? Image.network(
                            img,
                            width: screenWidth * 0.65,
                            height: screenHeight * 0.165,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            img,
                            width: screenWidth * 0.7,
                            height: screenHeight * 0.26,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.028),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          plato,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colorBoton1,
                            fontSize: screenHeight * 0.025,
                          ),
                        ),
                        Text(
                          '\$$precio',
                          style: TextStyle(
                            color: colorBoton1,
                            fontSize: screenHeight * 0.02,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        // Barra de navegación inferior
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
              // Iconos de la barra de navegación
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
