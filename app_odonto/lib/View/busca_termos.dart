import 'package:app_odonto/Controller/login_cadastro_controller.dart';
import 'package:app_odonto/Controller/termos_tecnicos_controller.dart';
import 'package:app_odonto/View/util.dart';
import 'package:app_odonto/model/termos_tecnicos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
//import 'package:app_odonto/Model/termos_tecnicos.dart';


class BuscaTermos extends StatefulWidget {
  const BuscaTermos({super.key});

  @override
  State<BuscaTermos> createState() => _BuscaTermosState();
}

class _BuscaTermosState extends State<BuscaTermos> {
  bool status = true;

  var txtNome = TextEditingController();
  var txtDescricao = TextEditingController();

  bool perfilProfessor = LoginController().verificarProfessor(); 

  @override 
    void initState(){ 
      super.initState();
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        //List view
        child: Column(
          children: [
          TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Digite o Termo Técnico",
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: (){}, 
                          )
                      ),
          ),
          const SizedBox(
                      height: 10,
          ),
          Expanded(
             child: StreamBuilder<QuerySnapshot>(
              //fluxo de dados em tempo real
              stream: TermosTecnicosController().listar(perfilProfessor).snapshots(),

              //exibição dos dados
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  //sem conexão
                  case ConnectionState.none:
                    return const Center(
                      child: Text('Não foi possível conectar.'),
                    );

                  //aguardando a execução da consulta
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );

                  //Sucesso: 
                  default:
                    final dados = snapshot.requireData;
                    if (dados.size > 0) {
                      return ListView.builder(
                        itemCount: dados.size,
                        itemBuilder: (context, index) {
                          String id = dados.docs[index].id;
                          dynamic doc = dados.docs[index].data();
                          return Card(
                            color: doc['status'] == true ? null : Colors.grey, // Cor azul com 50% de opacidade,
                            // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            // Set the clip behavior of the card
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            // Define the child widgets of the card
                            child: InkWell(
                              hoverColor: const Color.fromARGB(50, 25, 195, 207),
                              onTap: () {
                                Clipboard.setData(ClipboardData(text: '${doc['nome']}\n${doc['descricao']}'));
                                sucesso(context, 'Termo Técnico copiado com sucesso!');
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // Add a container with padding that contains the card's title, text, and buttons
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // Display the card's title using a font size of 24 and a dark grey color
                                        Text(
                                          doc['nome'],
                                          style: const TextStyle(
                                            fontSize: 24,
                                            color: Color.fromARGB(255, 10, 16, 83),
                                          ),
                                        ),
                                        // Add a space between the title and the text
                                        Container(height: 10),
                                        // Display the card's text using a font size of 15 and a light grey color
                                        Text(
                                          doc['descricao'],
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                              
                                        Container(height: 5),
                                        // Add a row with two buttons spaced apart and aligned to the right side of the card
                                        Row(
                                          children: <Widget>[
                                            // Add a spacer to push the buttons to the right side of the card
                                            const Spacer(),
                                            // Add a text button labeled "SHARE" with transparent foreground color and an accent color for the text
                                            Visibility(
                                              visible: perfilProfessor,
                                              child: IconButton(
                                                onPressed: () {
                                                  txtNome.text = doc['nome'];
                                                  txtDescricao.text = doc['descricao'];
                                                  status = doc['status'];
                                                  salvarTermoTecnico(context, docId: id);
                                                  },
                                                  icon: const Icon(Icons.edit_outlined),
                                              ),
                                            ),
                                            // Add a text button labeled "EXPLORE" with transparent foreground color and an accent color for the text
                                            Visibility(
                                              visible: perfilProfessor,
                                              child: IconButton(
                                                onPressed: () {
                                                  TermosTecnicosController().excluir(context, id);
                                                },
                                                icon: const Icon(Icons.delete_outlined),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(height: 5),
                                      ],
                                    ),
                                  )
                                  ]
                              ),
                            )
                          );
                        }
                      );
                    } else {
                      return const Center(
                        child: Text('Nenhum Termo Técnico encontrado.'),
                      );
                    }
                }
              },
            ),
           ),
          ]
        ),
      ),
      floatingActionButton: perfilProfessor ? 
        FloatingActionButton(
          onPressed: () {
            salvarTermoTecnico(context);
          },
          child: const Icon(Icons.add),
        ) 
        : null,
    );

  }

  //cadastro de termo tecnico
  void salvarTermoTecnico(context, {docId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool localStatus = status;
        // retorna um objeto do tipo Dialog
        return StatefulBuilder(
          builder: (context, setState) {
          return AlertDialog(
            title: Text(
                      docId == null ? "Adicionar Termo Técnico" : "Editar Termo Técnico",
                      style: const TextStyle(
                        fontSize: 24,
                        color: Color.fromARGB(255, 10, 16, 83),
                      ),
                    ), 
            content: SizedBox(
              height: 400,
              width: 350,
              child: Column(
                children: [
                  TextField(
                    controller: txtNome,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      prefixIcon: Icon(Icons.manage_search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: txtDescricao,
                    maxLines: 10,
                    decoration: const InputDecoration(
                      labelText: 'Descrição',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Text(
                        'Status:',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ), 
                      const SizedBox(width: 10),
                      Switch(
                        // This bool value toggles the switch.
                        value: localStatus,
                        activeColor: Colors.green,
                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            localStatus = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            actions: [
              IconButton(
                icon: const Icon(Icons.cancel_outlined),
                onPressed: () {
                  txtNome.clear();
                  txtDescricao.clear();
                  status = true;
                  Navigator.of(context).pop();
                },
              ),
              IconButton(
                icon: const Icon(Icons.check),
                onPressed: () {
                  //criar objeto Tarefa
                  var t = TermosTecnicos(
                    txtNome.text,
                    txtDescricao.text,
                    localStatus,
                  );

                  txtNome.clear();
                  txtDescricao.clear();
                  status = true;

                  if (docId == null) {
                    TermosTecnicosController().adicionar(context, t);
                  } else {
                    TermosTecnicosController().atualizar(context, docId, t);
                  }
                },
              ),
            ],
          );
        },
    );
  }
  );
  }
}