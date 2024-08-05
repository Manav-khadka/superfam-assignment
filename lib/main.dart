import 'package:flutter/material.dart';
import 'package:superfam_assignment/constants/dimensions.dart';
import 'package:superfam_assignment/providers/superfam_dashboard_provider.dart';
import 'package:superfam_assignment/screens/superfam_dashboard.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => SuperfamDashboardProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Dimensions().init(context);
    return MaterialApp(
      title: 'Superfam Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SuperfamDashboard(title: "Superfam Dashboard"),
    );
  }
}
