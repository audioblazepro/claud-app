import 'package:flutter/material.dart';
import 'widgets/project_card.dart';
import 'widgets/add_project_form.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  String _currentFilter = 'todos';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proyectos'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('Todos', 'todos'),
                  _buildFilterChip('En progreso', 'progreso'),
                  _buildFilterChip('Pendientes', 'pendiente'),
                  _buildFilterChip('Completados', 'completado'),
                ],
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ProjectCard(
            title: 'Desarrollo App Mobile',
            description: 'Aplicación de gestión personal',
            deadline: '2024-06-30',
            progress: 0.7,
            priority: 'Alta',
          ),
          SizedBox(height: 16),
          ProjectCard(
            title: 'Diseño de UI/UX',
            description: 'Interfaz de usuario moderna',
            deadline: '2024-05-15',
            progress: 0.4,
            priority: 'Media',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddProjectDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: _currentFilter == value,
        onSelected: (bool selected) {
          setState(() {
            _currentFilter = value;
          });
        },
      ),
    );
  }

  void _showAddProjectDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const AddProjectForm(),
    );
  }
}