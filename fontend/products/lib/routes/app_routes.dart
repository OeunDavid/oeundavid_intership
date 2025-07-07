import 'package:flutter/material.dart';
import 'package:products/providers/addproduct_provider.dart';
import 'package:products/providers/edit_product_provider.dart';
import 'package:products/providers/product_providers.dart';
import 'package:products/routes/route_name.dart';
import 'package:products/views/screens/addproduct_screen.dart';
import 'package:products/views/screens/editproduct_screen.dart';
import 'package:products/views/screens/home_screen.dart';
import 'package:provider/provider.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> appRoutes = {
    RoutesName.home:
        (context) => ChangeNotifierProvider(
          create: (_) => ProductProviders(),
          child: const HomeScreen(),
        ),
    RoutesName.add:
        (context) => ChangeNotifierProvider(
          create: (_) => AddproductProvider(),
          child: const AddproductScreen(),
        ),
    RoutesName.edit:
        (context) => ChangeNotifierProvider(
          create: (_) => EditProductProvider(),
          child: const EditproductScreen(),
        ),
  };
}
