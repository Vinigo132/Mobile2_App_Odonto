import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/termos_tecnicos.dart';
import '../view/util.dart';

class TermosTecnicosController {

  adicionar(context, TermosTecnicos t) {
    FirebaseFirestore.instance
        .collection('termos_tecnicos')
        .add(t.toJson())
        .then((resultado) {
      sucesso(context, 'Termo Técnico adicionado com sucesso!');
    }).catchError((e) {
      erro(context, 'Não foi possível adicionar o termo técnico.');
    }).whenComplete(() => Navigator.pop(context));
  }


  listar(professor, status) {
    if(professor){
      return FirebaseFirestore.instance.collection('termos_tecnicos').where('status', isEqualTo: status).orderBy('nome');
    }else{
      return FirebaseFirestore.instance.collection('termos_tecnicos').where('status', isEqualTo: true).orderBy('nome');
    }
  }


  excluir(context, id) {
    FirebaseFirestore.instance
        .collection('termos_tecnicos')
        .doc(id)
        .delete()
        .then((value) => sucesso(context, 'Termo técnico excluído com sucesso!'))
        .catchError((e) => erro(context, 'Não foi possível excluir o termo técnico.'));
  }


  atualizar(context, id, TermosTecnicos t){

    FirebaseFirestore.instance.collection('termos_tecnicos')
      .doc(id)
      .update(t.toJson())
      .then((value) => sucesso(context, 'Termo técnico atualizado com sucesso!'))
      .catchError((e) => erro(context, 'Não foi possível atualizar o termo técnico.'))
      .whenComplete(() => Navigator.pop(context));

  }

}
