
import 'package:app_odonto/Controller/login_cadastro_controller.dart';
import 'package:flutter/material.dart';

class SobreScreen extends StatefulWidget {
  const SobreScreen({super.key});

  @override
  State<SobreScreen> createState() => _SobreScreenState();
}

class _SobreScreenState extends State<SobreScreen> {
  var currentPageIndex = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/images/nossa-marca.png'),
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 70),
              // Utilizando RichText para exibir textos com cores diferentes na mesma linha
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Entre em',
                      style: TextStyle(color: Color.fromARGB(255, 1, 2, 10), fontWeight:FontWeight.w300),
                    ),
                    TextSpan(
                      text: ' contato',
                      style: TextStyle(color: Color.fromARGB(255, 52, 64, 199)),
                    ),
                    TextSpan(
                      text: ', estamos aqui:',
                      style: TextStyle(color: Color.fromARGB(255, 1, 2, 10), fontWeight:FontWeight.w300),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Linhas de e-mail e telefone
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.email, color: Colors.grey),
                  SizedBox(width: 5),
                  Text(
                    "yuri@gmail.com",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.email, color: Colors.grey),
                  SizedBox(width: 5),
                  Text(
                    "vini@gmail.com",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone, color: Colors.grey),
                  SizedBox(width: 5),
                  Text(
                    "+55 16 99876-5432",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Expanded(
                     child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          gradient: const LinearGradient(colors: [Color.fromARGB(255, 102, 13, 2), Color.fromARGB(255, 196, 3, 3)])
                        ),
                        child: MaterialButton(
                          onPressed: (){
                            LoginController().logout(context);
                          },
                          child: const Text(
                            "Sair",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                   ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
