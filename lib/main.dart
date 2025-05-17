import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config/theme.dart';
import 'core/database/database_helper.dart';
import 'features/dashboard/dashboard_screen.dart';
import 'features/finances/finances_screen.dart';
import 'features/goals/goals_screen.dart';
import 'features/projects/projects_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final dbHelper = DatabaseHelper();
  await dbHelper.database;
  await dbHelper.insertInitialUser();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Claud Assistant',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme(context),
      home: const HomePage(),
    );
  }
}

// ... (Resto del código del HomePage)