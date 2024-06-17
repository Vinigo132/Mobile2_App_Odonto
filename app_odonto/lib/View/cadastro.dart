import 'package:app_odonto/view/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Controller/login_cadastro_controller.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() =>  _CadastroScreenState();
}

class  _CadastroScreenState extends State <CadastroScreen> {
  bool passwordVisible = false;
  bool passwordVisibleConfirm = false; 

  var txtEmail = TextEditingController();
  var txtNome = TextEditingController();
  var txtCodigo = TextEditingController();
  var txtSenha = TextEditingController();
  var txtConfirmSenha = TextEditingController();
      
   @override 
    void initState(){ 
      super.initState(); 
      passwordVisible = true;
      passwordVisibleConfirm = true; 
    }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 25, 195, 207),
          actions: const [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 5), // Defina a margem desejada aqui
              child: Image(
                image: AssetImage('assets/images/nossa-marca.png'),
              ),
            ),
          ],
          centerTitle: true,
          title: const Text(
            "Odonto Helper",
            style: TextStyle(
              color: Color.fromARGB(255, 10, 16, 83),
              fontWeight: FontWeight.bold,
              fontSize: 30
            )
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)
            )
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 50),
          child: Center(
             child: Form(
                key: formKey,
            child: SingleChildScrollView(
                child: Column(
                  children: [
                      const Text(
                        "Cadastro",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 10, 16, 83)
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: txtEmail,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value){
                          if(!value!.endsWith('@sou.unaerp.edu.br')){
                            return 'Não é permitido cadastrar esse formato de email.';
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: "Insira seu Email",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email)
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: txtNome,
                        keyboardType: TextInputType.name,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]+'))],
                        decoration: const InputDecoration(
                          labelText: "Insira seu Nome",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.tag)
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: txtCodigo,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Insira seu Código de Matrícula",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.pin)
                        ),
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira um código.';
                          }
                          else if(value.length < 6 || value.length > 6){
                            return 'O código deve conter 6 dígitos.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: txtSenha,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: passwordVisible,
                        validator: (value){
                          if(value!.length < 6){
                            return 'a senha deve conter pelo menos 6 caracteres.';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Insira sua Senha",
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                            onPressed: (){
                              setState(() {
                                passwordVisible = !passwordVisible;
                              }); 
                            },
                          )
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: txtConfirmSenha,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: passwordVisibleConfirm,
                        decoration: InputDecoration(
                          labelText: "Confirme a Senha",
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(passwordVisibleConfirm ? Icons.visibility : Icons.visibility_off),
                            onPressed: (){
                              setState(() {
                                passwordVisibleConfirm = !passwordVisibleConfirm;
                              }); 
                            },
                          )
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          gradient: const LinearGradient(colors: [Colors.blue, Colors.yellow])
                        ),
                        child: MaterialButton(
                          onPressed: (){
                            if ( formKey.currentState != null && formKey.currentState!.validate() && txtSenha.text == txtConfirmSenha.text ) {
                              
                                LoginController().criarConta(
                                  context,
                                  txtEmail.text,
                                  txtNome.text,
                                  int.parse(txtCodigo.text),
                                  txtSenha.text
                                );
                              
                              }else{
                                erro(context, 'As senhas não conferem, digite novamente!');
                              }
                          },
                          child: const Text(
                            "CADASTRAR",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                ),
              ),
            )
          )
        ),
      );  
  }
}