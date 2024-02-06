import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';

class QrScan extends StatefulWidget {
  const QrScan({Key? key}) : super(key: key);

  @override
  State<QrScan> createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  // Colores para la interfaz
  Color selectedColor = const Color(0xFF417123);
  Color customColor = const Color(0xFF5BDA57);
  Color defaultColor = Colors.white;
  double iconSize = 32;

  // Índice seleccionado para los iconos de la barra inferior
  int selectedIndex = 3;

  // Radio del botón y clave para el widget QR
  double buttonBorderRadius = 10.0;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // Resultado del escaneo y controlador del escáner QR
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double radius = 45.5;

    return Scaffold(
      // Barra de aplicación
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
          'QR',
          style: TextStyle(
            color: Colors.white,
            fontSize: screenHeight * 0.025,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu,
                color: Colors.white, size: screenHeight * 0.04),
            onPressed: () {
              Navigator.pushNamed(context, '/configuracion');
            },
          ),
        ],
        toolbarHeight: screenHeight * 0.1,
      ),
      // Cuerpo de la pantalla
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(flex: 4, child: _buildQrView(context)),
              Expanded(
                flex: 1,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      if (result != null)
                        Text(
                          'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}',
                          style: const TextStyle(color: Colors.black),
                        )
                      else
                        const Text('Escanea un Codigo',
                            style: TextStyle(color: Colors.black)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          buildButton('Flash', Icons.flash_on,
                              () async => await controller?.toggleFlash()),
                          buildButton(
                              'Cambiar Cámara',
                              Icons.flip_camera_android,
                              () async => await controller?.flipCamera()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          buildButton('Pausar', Icons.pause,
                              () async => await controller?.pauseCamera()),
                          buildButton('Reanudar', Icons.play_arrow,
                              () async => await controller?.resumeCamera()),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
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
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildIconButton(Icons.image, 0, 'Actividades'),
              buildIconButton(Icons.restaurant, 1, 'Gastronomía'),
              buildIconButton(
                  Icons.location_on_outlined, 2, 'Ubicación en Mapa'),
              buildIconButton(Icons.qr_code, 3, 'Escanear QR'),
            ],
          ),
        ),
      ),
    );
  }

  // Método para construir un botón elevado personalizado
  ElevatedButton buildButton(
      String label, IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: customColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonBorderRadius),
        ),
        shadowColor: Colors.black,
        elevation: 5,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 5),
          Text(label),
        ],
      ),
    );
  }

  // Método para construir un ícono de la barra inferior
  IconButton buildIconButton(IconData icon, int index, String routeName) {
    double screenHeight = MediaQuery.of(context).size.height;
    double iconSize = screenHeight * 0.032;
    return IconButton(
      icon: Icon(
        icon,
        color: selectedIndex == index ? selectedColor : defaultColor,
        size: iconSize,
      ),
      onPressed: () {
        setState(() {
          selectedIndex = index;
        });

        // Navegación a las diferentes pantallas según el ícono seleccionado
        if (index == 1) {
          Navigator.pushNamed(context, '/gastronomia');
        }
        if (index == 2) {
          Navigator.pushNamed(context, '/mapa');
        }
        if (index == 0) {
          Navigator.pushNamed(context, '/actividades');
        }
        if (index == 3) {
          // Acciones al presionar el ícono de escanear QR
        }
      },
    );
  }

  // Método para construir la vista del escáner QR
  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: customColor,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  // Método invocado cuando el controlador del escáner QR es creado
  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  // Método invocado cuando se establece el permiso para el escáner QR
  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  // Liberar recursos al salir de la pantalla
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
