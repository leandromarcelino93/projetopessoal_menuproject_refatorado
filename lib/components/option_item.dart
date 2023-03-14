import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/menu_list.dart';
import '../models/menu_option.dart';

class OptionItem extends StatelessWidget {

  final MenuOption option;

  const OptionItem({Key? key, required this.option}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<MenuList>(context, listen: false).deleteOption(option);
                    },
                    child: const Icon(Icons.remove),
                  ),
                  SizedBox(
                    width: 160,
                    height: 120,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              width: 100,
                              height: 50,
                              color: Colors.white,
                              child: Text(option.name,
                                  style: const TextStyle(
                                    fontSize: 21,
                                  ))),
                          Container(
                              width: 100,
                              height: 50,
                              color: Colors.white,
                              child: Text(option.price.toStringAsFixed(2),
                                  style: const TextStyle(
                                    fontSize: 21,
                                  ))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blue),
                width: 80,
                height: 90,
                child: Image.network(
                  option.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
