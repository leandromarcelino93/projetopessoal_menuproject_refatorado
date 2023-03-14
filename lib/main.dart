import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/menu_form.dart';
import '../screens/initial_screen.dart';
import 'models/menu_list.dart';
import 'utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MenuList(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '',
        theme: ThemeData(
          colorScheme: (const ColorScheme.light(
            primary: Colors.red,
            secondary: Colors.red,
            )),
        ),
        //home: ProductsOverviewPage(),
        routes: {
          AppRoutes.HOME: (ctx) => const InitialScreen(),
          AppRoutes.MENU_FORM: (ctx) => const MenuFormScreen(),
        },
      ),
    );
  }
}


