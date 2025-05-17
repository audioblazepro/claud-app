import 'package:flutter/material.dart';
import '../../core/services/auth_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkMode = true;
  String _currency = 'USD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: ListView(
        children: [
          _buildSection(
            'Cuenta',
            [
              ListTile(
                title: const Text('Usuario'),
                subtitle: const Text('audioblazepro'),
                leading: const Icon(Icons.person),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Cambiar contraseña'),
                leading: const Icon(Icons.lock),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ],
          ),
          _buildSection(
            'Preferencias',
            [
              SwitchListTile(
                title: const Text('Notificaciones'),
                subtitle: const Text('Activar/Desactivar notificaciones'),
                value: _notificationsEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Modo oscuro'),
                subtitle: const Text('Cambiar tema de la aplicación'),
                value: _darkMode,
                onChanged: (bool value) {
                  setState(() {
                    _darkMode = value;
                  });
                },
              ),
              ListTile(
                title: const Text('Moneda'),
                subtitle: Text(_currency),
                leading: const Icon(Icons.attach_money),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showCurrencyPicker(context),
              ),
            ],
          ),
          _buildSection(
            'Información',
            [
              ListTile(
                title: const Text('Versión'),
                subtitle: const Text('1.0.0'),
                leading: const Icon(Icons.info),
              ),
              ListTile(
                title: const Text('Términos y condiciones'),
                leading: const Icon(Icons.description),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Política de privacidad'),
                leading: const Icon(Icons.privacy_tip),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ],
          ),
          _buildSection(
            'Sesión',
            [
              ListTile(
                title: const Text('Cerrar sesión'),
                leading: const Icon(Icons.exit_to_app),
                textColor: Colors.red,
                iconColor: Colors.red,
                onTap: () => _confirmLogout(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        ...children,
        const Divider(),
      ],
    );
  }

  void _showCurrencyPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildCurrencyOption('USD', 'Dólar estadounidense'),
              _buildCurrencyOption('EUR', 'Euro'),
              _buildCurrencyOption('GBP', 'Libra esterlina'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCurrencyOption(String code, String name) {
    return ListTile(
      title: Text(name),
      subtitle: Text(code),
      trailing: _currency == code ? const Icon(Icons.check) : null,
      onTap: () {
        setState(() {
          _currency = code;
        });
        Navigator.pop(context);
      },
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cerrar sesión'),
          content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                await AuthService().clearSession();
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
              child: const Text('Cerrar sesión'),
            ),
          ],
        );
      },
    );
  }
}