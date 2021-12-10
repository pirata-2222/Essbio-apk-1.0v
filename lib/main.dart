import 'package:essbio_apk/api/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EssbioProvider(),
      child: MaterialApp(
          title: 'Essbio APK',
          theme: ThemeData(
            scaffoldBackgroundColor: Color(0xFFE5E5E5),
            appBarTheme: AppBarTheme(color: Color(0xFF3C3C3C)),
          ),
          home: Home()),
    );
  }
}