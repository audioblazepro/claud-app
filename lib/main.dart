import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final database = openDatabase(
    join(await getDatabasesPath(), 'claud_assistant.db'),
    onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE user_data(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT,
          last_login TEXT,
          settings TEXT
        )
      ''');

      await db.execute('''
        CREATE TABLE finances(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          type TEXT,
          amount REAL,
          category TEXT,
          description TEXT,
          date TEXT,
          username TEXT
        )
      ''');

      await db.execute('''
        CREATE TABLE goals(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          description TEXT,
          deadline TEXT,
          progress REAL,
          status TEXT,
          username TEXT
        )
      ''');

      await db.execute('''
        CREATE TABLE projects(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          description TEXT,
          deadline TEXT,
          status TEXT,
          priority TEXT,
          username TEXT
        )
      ''');

      // Insertar usuario inicial
      await db.insert('user_data', {
        'username': 'audioblazepro',
        'last_login': DateTime.now().toUtc().toString(),
        'settings': '{"theme":"dark","notifications":true}'
      });
    },
    version: 1,
  );

  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final Future<Database> database;

  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Claud Assistant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.lightBlue[300],
        scaffoldBackgroundColor: Colors.black,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlue[300],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        cardTheme: CardTheme(
          color: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
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

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) => _updateTime());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTime() {
    setState(() {
      currentTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now().toUtc());
    });
  }

  final List<Widget> _pages = [
    const DashboardPage(),
    const FinancesPage(),
    const GoalsPage(),
    const ProjectsPage(),
  ];

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
              'Hola, $username',
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
            onPressed: () {
              // Implementar notificaciones
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            color: Colors.lightBlue[300],
            onPressed: () {
              // Implementar configuraciones
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
        onPressed: () {
          _showAddItemDialog(context);
        },
        backgroundColor: Colors.lightBlue[300],
        child: const Icon(Icons.add),
      ),
    );
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
                  // Implementar agregar transacción
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 10),
              _buildAddButton(
                context,
                'Nueva Meta',
                Icons.flag,
                () {
                  // Implementar agregar meta
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 10),
              _buildAddButton(
                context,
                'Nuevo Proyecto',
                Icons.work,
                () {
                  // Implementar agregar proyecto
                  Navigator.pop(context);
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
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFinancialSummary(),
          const SizedBox(height: 20),
          _buildGoalsProgress(),
          const SizedBox(height: 20),
          _buildRecentActivities(),
        ],
      ),
    );
  }

  Widget _buildFinancialSummary() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumen Financiero',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 3),
                        const FlSpot(2.6, 2),
                        const FlSpot(4.9, 5),
                        const FlSpot(6.8, 3.1),
                        const FlSpot(8, 4),
                        const FlSpot(9.5, 3),
                        const FlSpot(11, 4),
                      ],
                      isCurved: true,
                      color: Colors.lightBlue[300],
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.lightBlue[300]?.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalsProgress() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Progreso de Metas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildGoalProgressBar('Meta de Ahorro', 0.7),
            const SizedBox(height: 8),
            _buildGoalProgressBar('Proyecto Personal', 0.4),
            const SizedBox(height: 8),
            _buildGoalProgressBar('Ejercicio Semanal', 0.9),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalProgressBar(String title, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[800],
          valueColor: AlwaysStoppedAnimation<Color>(
            Colors.lightBlue[300]!,
          ),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  Widget _buildRecentActivities() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Actividades Recientes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildActivityItem(
              'Nuevo gasto registrado',
              'Compras supermercado',
              Icons.shopping_cart,
              DateTime.now(),
            ),
            _buildActivityItem(
              'Meta actualizada',
              'Meta de ahorro mensual',
              Icons.update,
              DateTime.now().subtract(const Duration(hours: 2)),
            ),
            _buildActivityItem(
              'Proyecto completado',
              'Desarrollo de app',
              Icons.check_circle,
              DateTime.now().subtract(const Duration(days: 1)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(
    String title,
    String subtitle,
    IconData icon,
    DateTime time,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.lightBlue[300]?.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.lightBlue[300],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            DateFormat('HH:mm').format(time),
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class FinancesPage extends StatelessWidget {
  const FinancesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Finanzas en desarrollo'));
  }
}

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Metas en desarrollo'));
  }
}

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Proyectos en desarrollo'));
  }
}