import 'dart:math';
import '../data/dummy_data.dart';
import '../models/menu_option.dart';
import 'package:flutter/material.dart';

class MenuList with ChangeNotifier {

  final List<MenuOption> _items = dummyOptions;

  List<MenuOption> get items => [..._items];
  //Método para exibir o clone de todos os itens

  int get itemsCount {
    return _items.length;
  }
  //Método que retorna qtde de itens

  void saveProductFromData(Map<String, Object> data) {
    bool hasId = data['id'] != null;
    //Verificação se o id está nulo

    final newMenuOption = MenuOption(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      //Se tiver id, irá considerá-lo. Caso não, um id será gerado
      name: data['name'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );
    addOption(newMenuOption);
  }

  void addOption(MenuOption menuoption) {
    _items.add(menuoption);
    notifyListeners();
  }

  void deleteOption(MenuOption menuoption) {
    int index = _items.indexWhere((m) => m.id == menuoption.id);
    if (index >= 0) {
      _items.removeWhere((m) => m.id == menuoption.id);
      notifyListeners();
    }
  }
}


