import 'package:flutter/material.dart';

import 'screens.dart';

class Gastronomia extends StatefulWidget {
  const Gastronomia({super.key});

  @override
  State<Gastronomia> createState() => _GastronomiaState();
}

class _GastronomiaState extends State<Gastronomia>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late Future<List<PlatosModel>> _platosFuture;

  Color selectedColor = const Color(0xFF417123);
  Color colorBoton = const Color(0xFFE1FFE0);
  Color defaultColor = Colors.white;

  int selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _platosFuture = fetchPlatos();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    Color customTextColor = const Color(0xFF417123);
    Color customColor = const Color(0xFF5BDA57);

    double radius = 45.5;

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
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              child: Text(
                'Los más vendidos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenHeight * 0.0225,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Restaurantes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenHeight * 0.0225,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
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
          TabBarView(
            controller: _tabController,
            children: <Widget>[
              // Primer Tab - Platos más vendidos
              FutureBuilder<List<PlatosModel>>(
                future: _platosFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<PlatosModel> platosList = snapshot.data!;

                    return ListView.builder(
                      itemCount: platosList.length,
                      itemBuilder: (BuildContext context, int index) {
                        PlatosModel plato = platosList[index];

                        return Column(
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.all(14.0),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  plato.img,
                                  height: 130.0,
                                  width: 130.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                plato.plato,
                                style: TextStyle(
                                  color: selectedColor,
                                  fontSize: screenHeight * 0.023,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                '\$${plato.precio}',
                                style: TextStyle(
                                  color: selectedColor,
                                  fontSize: screenHeight * 0.02,
                                ),
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/gastronomia2',
                                  arguments: {
                                    'plato': plato.plato,
                                    'img': plato.img,
                                    'precio': plato.precio,
                                    'restaurante': plato.restaurante,
                                  },
                                );
                              },
                            ),
                            Divider(
                              color: customTextColor,
                              thickness: 1,
                              indent: 13,
                              endIndent: 13,
                            ),
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
              // Segundo Tab - Restaurantes
              FutureBuilder<List<RestaurantesModel>>(
                future: fetchRestaurantes(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<RestaurantesModel> restaurantesList = snapshot.data!;

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
                                            backgroundColor: colorBoton,
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
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
            bottom: screenHeight * 0.015), // Ajusta según tu necesidad
        padding: EdgeInsets.only(
            left: screenWidth * 0.07, right: screenWidth * 0.07),
        child: Container(
          height: screenHeight * 0.09,
          decoration: BoxDecoration(
            color: customColor,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildIconButton(Icons.image, 0),
              buildIconButton(Icons.restaurant, 1),
              buildIconButton(Icons.location_on_outlined, 2),
              buildIconButton(Icons.qr_code, 3),
            ],
          ),
        ),
      ),
    );
  }

  IconButton buildIconButton(IconData icon, int index) {
    double screenHeight = MediaQuery.of(context).size.height;
    return IconButton(
      icon: Icon(
        icon,
        color: selectedIndex == index ? selectedColor : defaultColor,
        size: screenHeight * 0.032,
      ),
      onPressed: () {
        setState(() {
          selectedIndex = index;
        });

        // Navegación según el ícono seleccionado
        if (index == 0) {
          Navigator.pushNamed(context, '/actividades');
        }
        if (index == 2) {
          Navigator.pushNamed(context, '/mapa');
        }
        if (index == 3) {
          Navigator.pushNamed(context, '/qrscan');
        }
      },
    );
  }
}
