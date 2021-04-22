import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobxaula/controller/principal_controller.dart';
import 'package:mobxaula/model/item_model.dart';
import 'package:mobxaula/util/icone.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'cadastrar_tarefa.dart';

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  PrincipalController principalController;

  @override
  void didChangeDependencies() {
    principalController = Provider.of<PrincipalController>(context);
    super.didChangeDependencies();
  }

  //exibe as notas
  @override
  Widget build(BuildContext context) {
    var _categorias = Icones().getIcone();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tarefas",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Container(child: Observer(
          builder: (_) {
            return ListView.builder(
              itemCount: principalController.listaItens.length ?? 0,
              //  itemCount: principalController.repository.getTodos(),
              itemBuilder: (_, indice) {
                //item é do tipo ItemController
                var item = principalController.listaItens[indice];
                return Observer(builder: (_) {
                  return Card(
                    child: ListTile(
                      leading: Icon(_categorias[item.icone]),
                      title: Text(item.titulo),
                      subtitle: Text(item.descricao),
                      trailing: Text('${item.data}' + "\n${item.hora}"),
                      onTap: () {
                        _dialog(context, item);
                      },
                    ),
                  );
                });
              },
            );
          },
        )),

        //firebase Acesso
        /*
          children: [
            Expanded(
              child: FutureBuilder<List<ItemModel>>(
                future: principalController.getListaFirebase(),
                builder: (context, snapshot) {
                  List<ItemModel> tarefas = snapshot.data;

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                          "Erro ao carregar projetos. Tente novamente mais tarde"),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data.isEmpty) {
                    return Center(
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.green,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    //  itemCount: principalController.repository.getTodos(),
                    itemBuilder: (_, indice) {
                      // var item = principalController.listaItens[indice];

                      return Card(
                        child: ListTile(
                          leading: Icon(_categorias[tarefas[indice].icone]),
                          title: Text(tarefas[indice].titulo),
                          subtitle: Text(tarefas[indice].descricao),
                          trailing: Text('${tarefas[indice].data}' +
                              "\n${tarefas[indice].hora}"),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),*/
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CadastrarTarefa()));
        },
      ),
    );
  }

  _openPopup(context, ItemModel item) {
    var _categorias = Icones().getIcone();
    Alert(context: context, title: item.titulo, desc: item.descricao, buttons: [
      DialogButton(
        onPressed: () => Navigator.pop(context),
        child: Text(
          "Ok",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      )
    ]).show();
  }

  _dialog(context, ItemModel item) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(item.titulo, textAlign: TextAlign.center),
            content: Text(item.descricao, textAlign: TextAlign.center),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("ok",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15)))
            ],
          );
        });
  }
}
