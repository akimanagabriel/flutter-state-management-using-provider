import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_management/providers/counter_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterProvider>(context);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      floatingActionButton: _buildFloatings(counter),
    );
  }

  Widget _buildFloatings(CounterProvider counter) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton.small(
          onPressed: () => counter.decrement(),
          child: const Icon(Icons.remove),
          tooltip: "Decrement",
          heroTag: "tag1",
        ),
        FloatingActionButton.small(
          onPressed: () => counter.increment(),
          child: const Icon(Icons.add),
          tooltip: "Increment",
          heroTag: "tag2",
        )
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Home"),
      actions: [
        IconButton(
          tooltip: "Contacts",
          onPressed: () {
            Navigator.of(context).pushNamed("/users");
          },
          icon: const Icon(CupertinoIcons.folder_badge_person_crop),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    final counter = Provider.of<CounterProvider>(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${counter.value}",
            style: const TextStyle(fontSize: 40),
          ),
          const Text("COUNTER"),
          Container(
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(30),
            ),
            width: MediaQuery.of(context).size.width * .8,
            child: MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/info");
              },
              child: const Text(
                "Info Page",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
