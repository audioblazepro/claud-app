import 'package:flutter/material.dart';
import 'widgets/transaction_list.dart';
import 'widgets/finance_chart.dart';
import 'widgets/add_transaction_form.dart';

class FinancesScreen extends StatefulWidget {
  const FinancesScreen({super.key});

  @override
  State<FinancesScreen> createState() => _FinancesScreenState();
}

class _FinancesScreenState extends State<FinancesScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Finanzas'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Resumen'),
              Tab(text: 'Transacciones'),
              Tab(text: 'Análisis'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildSummaryTab(),
            const TransactionList(),
            const FinanceChart(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddTransactionDialog(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildSummaryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildBalanceCard(),
          const SizedBox(height: 16),
          _buildCategoryBreakdown(),
        ],
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Balance Total'),
            const SizedBox(height: 8),
            Text(
              '\$2,500.00',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBalanceItem('Ingresos', '\$3,500.00', Colors.green),
                _buildBalanceItem('Gastos', '\$1,000.00', Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceItem(String title, String amount, Color color) {
    return Column(
      children: [
        Text(title),
        Text(
          amount,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryBreakdown() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Gastos por Categoría'),
            const SizedBox(height: 16),
            _buildCategoryItem('Comida', 300, 0.3),
            _buildCategoryItem('Transporte', 200, 0.2),
            _buildCategoryItem('Entretenimiento', 150, 0.15),
            _buildCategoryItem('Servicios', 350, 0.35),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String category, double amount, double percentage) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Text(category)),
            Text('\$${amount.toStringAsFixed(2)}'),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: percentage,
          backgroundColor: Colors.grey[700],
          valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlue[300]!),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  void _showAddTransactionDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const AddTransactionForm(),
    );
  }
}