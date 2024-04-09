import 'package:flutter/material.dart';


class LoginScreen  extends StatefulWidget {
  const LoginScreen ({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
    bool passwordVisible = false; 
      
   @override 
    void initState(){ 
      super.initState(); 
      passwordVisible = true; 
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 25, 195, 207),
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
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                    const Text(
                      "Login",
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
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: passwordVisible,
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
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: (){
                            Navigator.pushNamed(context, 'EsqueceuSenha');
                          }, 
                          child: const Text(
                            "Esqueceu sua senha?"
                          )
                        )
                      ],
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
                          Navigator.pushNamed(context, 'Menu');
                        },
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Divider(
                      height: 30,
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Não tem uma conta?",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                            TextButton(
                              onPressed: (){
                                Navigator.pushNamed(context, 'Cadastro');
                              }, 
                              child: const Text(
                              "Cadastrar Conta"
                            ))
                          ]
                        )
                      ],
                    )
                  ],
              ),
            )
          )
        ),
      );  
  }
}

