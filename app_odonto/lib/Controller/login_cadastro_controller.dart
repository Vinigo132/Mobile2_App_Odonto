import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../view/util.dart';

class LoginController {
  //
  // CRIAR CONTA de um usuário no serviço Firebase Authentication
  //
  criarConta(context, email, nome, codigo, senha) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: senha,
    )
        .then(
      (resultado) {
        //Usuário criado com sucesso!

        //Armazenar o NOME e UID do usuário no Firestore
        FirebaseFirestore.instance.collection("usuarios").add(
          {
            "uid": resultado.user!.uid,
            "nome": nome,
            "codigo": codigo
          },
        );
        sucesso(context, 'Usuário criado com sucesso!');
        Navigator.pop(context);
      },
    ).catchError((e) {
      //Erro durante a criação do usuário
      switch (e.code) {
        case 'email-already-in-use':
          erro(context, 'O email já foi cadastrado.');
          break;
        case 'invalid-email':
          erro(context, 'O formato do e-mail é inválido.');
          break;
        default:
          erro(context, 'ERRO: ${e.toString()}');
      }
    });
  }

  //
  // LOGIN de usuário a partir do provedor Email/Senha
  //
  login(context, email, senha) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((resultado) {
      sucesso(context, 'Usuário autenticado com sucesso!');
      Navigator.pushNamedAndRemoveUntil(context, 'Menu', (route) => false);
    }).catchError((e) {
      switch (e.code) {
        case 'invalid-email':
          erro(context, 'O formato do e-mail é inválido.');
        case 'invalid-credential':
          erro(context, 'Usuário e/ou senha inválida.');
        default:
          erro(context, 'ERRO: ${e.code.toString()}');
      }
    });
  }

  esqueceuSenha(context, email) {
    if (email.isNotEmpty) {
      FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      sucesso(context, 'Se este email estiver cadastrado, você receberá um email com as instruções necessárias.');
      Navigator.pop(context);
    } else {
      erro(context, 'Informe o email para recuperar a conta.');
    }
  }

  //
  // Efetuar logout do usuário
  //
  logout(context) {
    FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(context, 'Login', (route) => false);
  }

  //
  // Verificar se é conta professor ou não
  //
  verificarProfessor() {
    if (FirebaseAuth.instance.currentUser!.email!.endsWith('@unaerp.br')){
      return true;
    }else{
      return false;
    }
  }
}
