import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/menu_list.dart';

class MenuFormScreen extends StatefulWidget {
  const MenuFormScreen({Key? key}) : super(key: key);

  @override
  State<MenuFormScreen> createState() => _MenuFormScreenState();
}

class _MenuFormScreenState extends State<MenuFormScreen> {

  ///Variáveis
  final _priceFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};
  final _imageUrlController = TextEditingController();

  ///Métodos
  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _imageUrlFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl (String url) {
    bool isValidImageUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;

    return isValidImageUrl;
  }

  void _submitForm () {
    final isValid = _formKey.currentState?.validate() ?? false;

    if(!isValid){
      return;
    }

    _formKey.currentState?.save();

    Provider.of<MenuList>(context, listen: false).saveProductFromData(_formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Adicionar Nova Opção ao Cardápio',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 580,
              width: 375,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 3),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      onSaved: (name) => _formData['name'] = name ?? '',
                      validator: (_name) {
                        final name = _name ?? '';
                        if(name.trim().isEmpty) {
                          return 'Nome da Opção é obrigatório.';
                        }
                        if(name.trim().length < 2) {
                          return 'Nome precisa no mínimo de 3 letras.';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocus);
                      },
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nova Opção',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      onSaved: (price) => _formData['price'] = double.parse(price ?? '0'),
                      validator: (_price){
                        final priceString = _price ?? '';
                        final price = double.tryParse(priceString) ?? -1;
                        if(price <= 0){
                          return 'Informe um preço válido.';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_imageUrlFocus);
                      },
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocus,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Preço',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (text) {
                        setState(() {});
                      },
                      textInputAction: TextInputAction.done,
                      onSaved: (imageUrl) => _formData['imageUrl'] = imageUrl ?? '',
                      validator: (_imageUrl){
                        final imageUrl = _imageUrl ?? '';
                        if(!isValidImageUrl(imageUrl)){
                          return 'Informe uma URL válida!';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) => _submitForm(),
                      keyboardType: TextInputType.url,
                      focusNode: _imageUrlFocus,
                      textAlign: TextAlign.center,
                      controller: _imageUrlController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Imagem',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Container(
                    width: 110,
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 2, color: Colors.blue),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: _imageUrlController.text.isEmpty
                          ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('Informe a URL', textAlign: TextAlign
                              .center,),
                            ],
                          )
                          : FittedBox(
                              fit: BoxFit.cover,
                              child: Image.network(
                                _imageUrlController.text,
                              ),
                            ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _submitForm();
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Opção adicionada com sucesso!'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    },
                    child: const Text('Adicionar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

