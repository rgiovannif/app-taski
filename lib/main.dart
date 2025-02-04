import 'package:app_taski/app.dart';
import 'package:app_taski/core/dependency_injection/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: getProviders(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: App(),
      ),
    ),
  );
}
