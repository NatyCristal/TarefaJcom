
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';


class ItemModel 
//a utilização do mixin Store é para geração dos códigos automáticos
{
  
  ItemModel({this.titulo, this.descricao, this.data, this.hora,
      this.status, this.icone, this.id});

  //final String titulo;

  
  String titulo = '';
  
  String descricao = '';
 
  String data = '';

  String hora = '';
 
  bool status = false;
 
  int icone;

  int id;

  DocumentReference doccumento;


   factory ItemModel.fromDocument(DocumentSnapshot doc){
    return ItemModel(titulo: doc['titulo'], descricao: doc['descricao'], data: doc['data'], 
      status: doc['status'], icone: doc['icone'], id: doc['id']);
  }

  ItemModel.fromMap(Map<String, dynamic> document) {
    titulo = document["titulo"];
    descricao = document["descricao"];
    data = document["data"];
    hora = document["hora"];
    icone = document["icone"];
    status = document["status"];
    id = document["id"];
  }

  Map toMap() {
    Map<String, dynamic> map = {};
    map['titulo'] = titulo;
    map['descricao'] = descricao;
    map['data'] = data;
    map['hora'] = hora;
    map['icone'] = icone;
    map['status'] = status;
    map['id'] = id;

    return map;
  }


 
 
}
