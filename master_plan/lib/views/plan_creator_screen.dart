import 'package:flutter/material.dart';
import 'package:master_plan/models/data_layer.dart';
import 'package:master_plan/provider/plan_provider.dart';
import 'plan_screen.dart';

class PlanCreatorScreen extends StatefulWidget {
  const PlanCreatorScreen({super.key});

  @override
  _PlanCreatorScreenState createState() => _PlanCreatorScreenState();
}

class _PlanCreatorScreenState extends State<PlanCreatorScreen> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Master Plans Natan')),
      body: Column(children: [
        _buildListCreator(),
        Expanded(child: _buildMasterPlans()),
      ]),
    );
  }

  Widget _buildListCreator() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Material(
        color: Theme.of(context).cardColor,
        elevation: 10,
        child: TextField(
          controller: textController,
          decoration: const InputDecoration(
            labelText: 'Add a plan',
            contentPadding: EdgeInsets.all(20),
          ),
          onEditingComplete: addPlan,
        ),
      ),
    );
  }

  void addPlan() {
    final text = textController.text.trim();
    if (text.isEmpty) {
      return; // Jika tidak ada teks, tidak perlu melanjutkan
    }
    final plan = Plan(name: text, tasks: []);
    final planNotifier = PlanProvider.of(context);
    
    // Memperbarui daftar rencana
    planNotifier.value = [...planNotifier.value, plan];

    // Kosongkan text field setelah menambahkan rencana
    textController.clear();
    FocusScope.of(context).unfocus();
    setState(() {}); // Memastikan UI diperbarui
  }

  Widget _buildMasterPlans() {
    final planNotifier = PlanProvider.of(context);
    final plans = planNotifier.value;

    if (plans.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.note, size: 100, color: Colors.grey),
          Text('Anda belum memiliki rencana apapun.',
              style: Theme.of(context).textTheme.headlineSmall),
        ],
      );
    }
    return ListView.builder(
      itemCount: plans.length,
      itemBuilder: (context, index) {
        final plan = plans[index];
        return ListTile(
          title: Text(plan.name),
          subtitle: Text(plan.completenessMessage),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PlanScreen(plan: plan),
              ),
            );
          },
        );
      },
    );
  }
}
