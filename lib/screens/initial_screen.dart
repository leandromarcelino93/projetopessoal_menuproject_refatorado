import 'package:flutter/material.dart';
import 'package:projetopessoal_menuproject_refatorado/utils/app_routes.dart';
import 'package:provider/provider.dart';
import '../components/option_item.dart';
import '../models/menu_list.dart';
import '../models/menu_option.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<MenuList>(context);
    final List<MenuOption> loadedProducts = provider.items;

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Cardápio'),
      ),
      body: ListView.builder(
            itemCount: loadedProducts.length,
            itemBuilder: (ctx, index) => OptionItem(option: loadedProducts[index]),
           ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.MENU_FORM);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


