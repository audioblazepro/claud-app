import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Importaciones de configuración
import 'config/theme.dart';
import 'config/routes.dart';
import 'config/app_config.dart';

// Importaciones del core
import 'core/database/database_helper.dart';
import 'core/services/auth_service.dart';
import 'core/services/notification_service.dart';

// Importaciones de características
import 'features/dashboard/dashboard_screen.dart';
import 'features/finances/finances_screen.dart';
import 'features/goals/goals_screen.dart';
import 'features/projects/projects_screen.dart';
import 'features/settings/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configurar orientación
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Inicializar servicios
  final dbHelper = DatabaseHelper();
  await dbHelper.database;
  
  final notificationService = NotificationService();
  await notificationService.init();

  // Verificar si es primera ejecución
  final prefs = await SharedPreferences.getInstance();
  final isFirstRun = prefs.getBool('first_run') ?? true;

  if (isFirstRun) {
    await dbHelper.insertInitialUser();
    await prefs.setBool('first_run', false);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme(context),
      initialRoute: AppRoutes.initial,
      onGenerateRoute: AppRoutes.generateRoute,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String username = 'audioblazepro';
  late String currentTime;
  late Timer _timer;
  int _currentIndex = 0;
  final AuthService _authService = AuthService();
  final NotificationService _notificationService = NotificationService();

  final List<Widget> _pages = [
    const DashboardScreen(),
    const FinancesScreen(),
    const GoalsScreen(),
    const ProjectsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _updateTime();
    _startTimer();
    _checkAuthentication();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    setState(() {
      currentTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now().toUtc());
    });
  }

  Future<void> _checkAuthentication() async {
    final isAuthenticated = await _authService.isAuthenticated();
    if (!isAuthenticated && mounted) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.login);
    }
  }

  void _showAddItemDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Agregar Nuevo',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue[300],
                ),
              ),
              const SizedBox(height: 20),
              _buildAddButton(
                context,
                'Nueva Transacción',
                Icons.attach_money,
                () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AppRoutes.finances);
                },
              ),
              const SizedBox(height: 10),
              _buildAddButton(
                context,
                'Nueva Meta',
                Icons.flag,
                () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AppRoutes.goals);
                },
              ),
              const SizedBox(height: 10),
              _buildAddButton(
                context,
                'Nuevo Proyecto',
                Icons.work,
                () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AppRoutes.projects);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAddButton(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(title),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          backgroundColor: Colors.lightBlue[300],
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenido, $username',
              style: TextStyle(
                color: Colors.lightBlue[300],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              currentTime,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            color: Colors.lightBlue[300],
            onPressed: () async {
              await _notificationService.showNotification(
                title: 'Bienvenido',
                body: '¡Hola! Es hora de revisar tus metas del día.',
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            color: Colors.lightBlue[300],
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.settings);
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.lightBlue[300]!.withOpacity(0.2),
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          selectedItemColor: Colors.lightBlue[300],
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              label: 'Finanzas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.flag),
              label: 'Metas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work),
              label: 'Proyectos',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddItemDialog(context),
        backgroundColor: Colors.lightBlue[300],
        child: const Icon(Icons.add),
      ),
    );
  }
}