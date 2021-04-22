import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobxaula/controller/principal_controller.dart';
import 'package:provider/provider.dart';

class CadastrarTarefa extends StatefulWidget {
  @override
  _CadastrarTarefaState createState() => _CadastrarTarefaState();
}

class _CadastrarTarefaState extends State<CadastrarTarefa> {
  PrincipalController principalController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController tTitulo = TextEditingController();
  final TextEditingController tDescricao = TextEditingController();

  @override
  void didChangeDependencies() {
    principalController = Provider.of<PrincipalController>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<bool> _isSelected = [false, false, false, false, false];

    return SafeArea(
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Adicionar Tarefas"),
          ),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Ícones'),
                      ],
                    ),
                    Container(
                      width: 300,
                      height: 100,
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(20),
                      child: ToggleButtons(
                        children: <Widget>[
                          Icon(Icons.shopping_bag),
                          Icon(Icons.local_bar),
                          Icon(Icons.sports_soccer),
                          Icon(Icons.fitness_center),
                          Icon(Icons.scatter_plot),
                        ],
                        isSelected: _isSelected,
                        onPressed: (int index) {
                          setState(() {
                            for (int buttonIndex = 0;
                                buttonIndex < _isSelected.length;
                                buttonIndex++) {
                              if (buttonIndex == index) {
                                _isSelected[buttonIndex] = true;
                              } else {
                                _isSelected[buttonIndex] = false;
                              }
                              principalController.icone = index;
                            }
                          });
                        },
                      ),
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: tTitulo,
                            keyboardType: TextInputType.text,
                            onChanged: principalController.setTitulo,
                            decoration: InputDecoration(labelText: "Título"),
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            },
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 40)),
                          TextFormField(
                            controller: tDescricao,
                            keyboardType: TextInputType.multiline,
                            onChanged: principalController.setDescricao,
                            decoration: InputDecoration(labelText: "Descrição"),
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 40)),
                    DateTimePicker(
                      type: DateTimePickerType.dateTimeSeparate,
                      dateMask: 'dd/MM/yyyy',
                      initialValue: DateTime.now().toString(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      icon: Icon(Icons.event),
                      dateLabelText: 'Data',
                      timeLabelText: "Hora",
                      selectableDayPredicate: (date) {
                        return true;
                      },
                      onChanged: (val) {
                        // separa a data e hora, e envia pra controller.
                        var _dataHora = val.split(" ");
                        principalController.data = _dataHora[0];
                        principalController.hora = _dataHora[1];
                        print(_dataHora);
                        
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(15),
                        child: Text("Salvar", style: TextStyle(fontSize: 20)),
                        onPressed: () => {
                          if (formKey.currentState.validate())
                            {
                              print(principalController.icone),
                              if (principalController.icone == null ||
                                  principalController.icone.isNaN)
                                {
                                  principalController.icone = 0,
                                },
                              principalController.adicionarItem(),
                              Navigator.pop(context)
                            }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
