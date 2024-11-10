import 'package:flutter/material.dart';
import 'package:flutter_state_management/app.dart';
import 'package:flutter_state_management/providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'providers/counter_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: App(),
    ),
  );
}
