import 'package:flutter/material.dart';
import 'package:products/providers/addproduct_provider.dart';
import 'package:products/providers/product_providers.dart';
import 'package:products/routes/app_routes.dart';
import 'package:products/routes/route_name.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProviders()),
        ChangeNotifierProvider(create: (_) => AddproductProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.home,
      routes: AppRoutes.appRoutes,
    );
  }
}
