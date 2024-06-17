import 'package:app_odonto/Controller/login_cadastro_controller.dart';
import 'package:flutter/material.dart';

class EsqueceuSenhaScreen  extends StatefulWidget {
  const EsqueceuSenhaScreen ({super.key});

  @override
  State<EsqueceuSenhaScreen> createState() => _EsqueceuSenhaScreenState();
}

class _EsqueceuSenhaScreenState extends State<EsqueceuSenhaScreen>{

    var txtEmailEsqueceu = TextEditingController();
      
   @override 
    void initState(){ 
      super.initState();  
    }

  @override
  Widget build(BuildContext context) {
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                    const Text(
                      "Recuperar Senha",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(255, 10, 16, 83)
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: txtEmailEsqueceu,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Insira seu Email",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email)
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
                          LoginController().esqueceuSenha(context, txtEmailEsqueceu.text);
                        },
                        child: const Text(
                          "ENVIAR",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
              ),
            )
          )
        ),
      );
  }
}