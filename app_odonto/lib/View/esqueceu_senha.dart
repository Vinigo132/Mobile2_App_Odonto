import 'package:flutter/material.dart';

class EsqueceuSenhaScreen extends StatelessWidget {
  const EsqueceuSenhaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 25, 195, 207),
          actions: const [
            Image(image: AssetImage('assets/images/nossa-marca.png')),
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
                        onPressed: (){},
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