import 'package:flutter/material.dart';
import 'package:lector_qr/provedores/ui_provider.dart';
import 'package:provider/provider.dart';

import 'pages/inicio_page.dart';
import 'pages/mapa_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => new UiProvider())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'QR READER',
          initialRoute: 'home',
          routes: {
            'home': (_) => HomePage(),
            'mapa': (_) => MapaPage(),
          },
          // theme: ThemeData.dark(), //cambia a toda la pantalla a oscuro
          theme: ThemeData(
              primaryColor: Colors.red, //pone el encabezado de color
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor:
                      Colors.deepPurple //pone el boton de color morado
                  ))),
    );
  }
}
