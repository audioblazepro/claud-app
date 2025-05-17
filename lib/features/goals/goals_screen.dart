import 'package:flutter/material.dart';
import 'widgets/goal_card.dart';
import 'widgets/add_goal_form.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Metas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          GoalCard(
            title: 'Ahorrar para vacaciones',
            description: 'Meta de ahorro para viaje',
            deadline: '2024-12-31',
            progress: 0.6,
            status: 'En progreso',
          ),
          SizedBox(height: 16),
          GoalCard(
            title: 'Comprar laptop nueva',
            description: 'Ahorrar para equipo de trabajo',
            deadline: '2024-06-30',
            progress: 0.8,
            status: 'En progreso',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddGoalDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtrar Metas'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile(
              title: const Text('En progreso'),
              value: true,
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: const Text('Completadas'),
              value: false,
              onChanged: (bool? value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Aplicar'),
          ),
        ],
      ),
    );
  }

  void _showAddGoalDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const AddGoalForm(),
    );
  }
}