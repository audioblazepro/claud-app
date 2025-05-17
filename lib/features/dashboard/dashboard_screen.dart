import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'widgets/financial_summary.dart';
import 'widgets/goals_progress.dart';
import 'widgets/recent_activities.dart';
import 'widgets/quick_stats.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final String username = 'audioblazepro';
  late String currentTime;

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  void _updateTime() {
    setState(() {
      currentTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now().toUtc());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          // Actualizar datos del dashboard
          _updateTime();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bienvenido, $username',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.lightBlue[300],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  currentTime,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                const QuickStats(),
                const SizedBox(height: 24),
                const FinancialSummary(),
                const SizedBox(height: 24),
                const GoalsProgress(),
                const SizedBox(height: 24),
                const RecentActivities(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}