import 'package:flutter/material.dart';
import 'package:flutter_state_management/providers/counter_provider.dart';
import 'package:provider/provider.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Info"),
        actions: [
          IconButton(
            onPressed: () => counter.decrement(),
            icon: const Icon(Icons.remove),
          ),
          IconButton(
            onPressed: () => counter.increment(),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              counter.value.toString(),
              style: const TextStyle(fontSize: 40),
            ),
            const Text("Counter value"),
          ],
        ),
      ),
    );
  }
}
