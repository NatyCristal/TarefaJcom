import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:mobxaula/model/item_model.dart';
import 'package:mobxaula/repository/firebase_repository.dart';
part 'principal_controller.g.dart';

class PrincipalController = PrincipalControllerBase with _$PrincipalController;

//a utilização do mixin Store é para geração dos códigos automáticos
abstract class PrincipalControllerBase with Store {

  FirebaseRepository repository = FirebaseRepository();

  @observable
  String titulo='';
  @observable
  String descricao='';
  @observable
  String data='';
  @observable
  String hora='';
  @observable
  bool status = false;
  @observable
  int icone;

  

  @action
  void setTitulo(String value) => titulo = value;

  @action
  void setDescricao(String value) => descricao = value;

  @action
  void setData(String value) => data = value;

  @action
  void setHora(String value) => hora = value;

  @action
  void setStatus(bool value) => status = value;

  @action
  void setIcone(int value) => icone = value;

  ObservableList<ItemModel> listaItens = ObservableList<ItemModel>();

  void adicionarItem() {
    listaItens
        .add(ItemModel(titulo: titulo, descricao: descricao, data: data, hora: hora, status:status, icone: icone));
    //print(listaItens);
  }

  Future<List<ItemModel>> getListaFirebase() async{
     return await repository.getTodos();

  }

}
