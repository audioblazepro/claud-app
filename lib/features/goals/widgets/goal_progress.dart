import 'package:flutter/material.dart';
import '../../../shared/widgets/custom_card.dart';

class GoalsProgress extends StatelessWidget {
  const GoalsProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
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
          _buildGoalProgress('Meta de Ahorro', 0.7),
          const SizedBox(height: 8),
          _buildGoalProgress('Proyecto Personal', 0.4),
          const SizedBox(height: 8),
          _buildGoalProgress('Ejercicio Semanal', 0.9),
        ],
      ),
    );
  }

  Widget _buildGoalProgress(String title, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[800],
          valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlue[300]!),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}