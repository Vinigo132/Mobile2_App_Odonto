import 'package:flutter/material.dart';

class SobreScreen extends StatefulWidget {
  const SobreScreen({super.key});

  @override
  State<SobreScreen> createState() => _SobreScreenState();
}

class _SobreScreenState extends State<SobreScreen> {
  var currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Menu'),
          NavigationDestination(icon: Icon(Icons.info), label: 'Sobre'),
        ],
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
            if (index == 0) {
              Navigator.pushNamed(context, 'Menu');
            }
          });
        },
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        backgroundColor: Color.fromARGB(255, 171, 229, 233),
        animationDuration: const Duration(milliseconds: 500),
      ),
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
            fontSize: 30,
          ),
        ),
      ),
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
            ],
          ),
        ),
      ),
    );
  }
}
