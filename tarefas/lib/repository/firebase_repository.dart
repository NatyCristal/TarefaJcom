import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobxaula/model/item_model.dart';
import 'Irepository_interface.dart';


class FirebaseRepository implements ITarefaRepository {
  final FirebaseFirestore firebase = FirebaseFirestore.instance;
  DocumentReference reference;

  FirebaseRepository();

  @override
  Future<List<ItemModel>> getTodos() async {
    List<ItemModel> list = [];

    QuerySnapshot snapshots = await reference.collection('tarefa').get();
    for (var document in snapshots.docs) {
      var project = ItemModel.fromMap(document.data());
      list.add(project);
    }
    return list;
  }

  @override
  Future save(ItemModel model) async {
    if (reference == null) {
      int total = (await firebase.collection('tarefa').get()).size;
      reference = await FirebaseFirestore.instance.collection('tarefa').add({
        'titulo': model.titulo,
        'descricao': model.descricao,
        'data': model.data,
        'hora': model.hora,
        'status': model.status,
        'icone': model.icone,
        'id': total
      });
    } else {
      reference.update({
        'titulo': model.titulo,
        'descricao': model.descricao,
        'data': model.data,
        'hora': model.hora,
        'status': model.status,
        'icone': model.icone
      });
    }
  }
}
