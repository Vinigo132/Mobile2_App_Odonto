import 'package:app_odonto/Controller/login_cadastro_controller.dart';
import 'package:app_odonto/Controller/termos_tecnicos_controller.dart';
import 'package:app_odonto/View/util.dart';
import 'package:app_odonto/model/termos_tecnicos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BuscaTermos extends StatefulWidget {
  const BuscaTermos({super.key});

  @override
  State<BuscaTermos> createState() => _BuscaTermosState();
}

class _BuscaTermosState extends State<BuscaTermos> {
  bool filtroStatus = true;
  bool status = true;
  String nome = "";

  var txtNome = TextEditingController();
  var txtDescricao = TextEditingController();

  bool perfilProfessor = LoginController().verificarProfessor();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        //List view
        child: Column(children: [
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                labelText: "Digite o Termo Técnico",
                border: OutlineInputBorder(),
                suffixIcon: Icon( Icons.search),
                ),
            onChanged: (val) {
              setState(() {
                nome = val;
              });
            },
          ),
          const SizedBox(
            height: 5,
          ),
          perfilProfessor
              ? Row(
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
                      value: filtroStatus,
                      activeColor: Colors.green,
                      onChanged: (bool value) {
                        // This is called when the user toggles the switch.
                        setState(() {
                          filtroStatus = value;
                        });
                      },
                    ),
                  ],
                )
              : Container(),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              //fluxo de dados em tempo real
              stream: TermosTecnicosController()
                  .listar(perfilProfessor, filtroStatus)
                  .snapshots(),

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

                            if (nome.isEmpty) {
                              return buildCard(doc, id);
                            } else if (doc['nome']
                                .toString()
                                .toLowerCase()
                                .contains(nome.toLowerCase())) {
                              return buildCard(doc, id);
                            }
                            return Container();
                          });
                    } else {
                      return const Center(
                        child: Text('Nenhum Termo Técnico encontrado.'),
                      );
                    }
                }
              },
            ),
          ),
        ]),
      ),
      floatingActionButton: perfilProfessor
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      salvarTermoTecnico(context);
                    },
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
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
          final formKey = GlobalKey<FormState>();
          // retorna um objeto do tipo Dialog
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text(
                  docId == null
                      ? "Adicionar Termo Técnico"
                      : "Editar Termo Técnico",
                  style: const TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 10, 16, 83),
                  ),
                ),
                content: SizedBox(
                  height: 450,
                  width: 350,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: txtNome,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'Nome',
                            prefixIcon: Icon(Icons.manage_search),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: txtDescricao,
                          maxLines: 10,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            } else {
                              return null;
                            }
                          },
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
                      if (formKey.currentState != null &&
                          formKey.currentState!.validate()) {
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
                          TermosTecnicosController()
                              .atualizar(context, docId, t);
                        }
                      }
                    },
                  ),
                ],
              );
            },
          );
        });
  }

  Widget buildCard(doc, id) {
    return Card(
        color: doc['status'] == true
            ? null
            : Colors.grey, // Cor azul com 50% de opacidade,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          hoverColor: const Color.fromARGB(50, 25, 195, 207),
          onTap: () {
            Clipboard.setData(
                ClipboardData(text: '${doc['nome']}:\n${doc['descricao']}'));
            sucesso(context, 'Termo Técnico copiado com sucesso!');
          },
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        doc['nome'],
                        style: const TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 10, 16, 83),
                        ),
                      ),
                      Container(height: 10),
                      Text(
                        doc['descricao'],
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                        ),
                      ),
                      Container(height: 5),
                      Row(
                        children: <Widget>[
                          const Spacer(),
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
              ]),
        ));
  }
}
