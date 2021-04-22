import 'package:mobxaula/model/item_model.dart';



abstract class ITarefaRepository{

  Future <List<ItemModel>> getTodos();

  save(ItemModel model);

}