import 'package:flutter/material.dart';
import 'package:app_odonto/Model/termos_tecnicos.dart';


class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  var currentPageIndex = 0;
  List<TermosTecnicos> lista = [];

  @override 
    void initState(){ 
      super.initState(); 
      currentPageIndex = 0;
      lista.add(TermosTecnicos('Relação Cêntrica (RC)', 'relacionamento maxilomandibular independente do contato dentário, no qual os côndilos se articulam na posição anterossuperior contra as inclinações posteriores das eminências articulares. Nesta posição, a mandíbula realiza apenas um movimento de rotação. A partir desta posição fisiológica, de relação maxilomandibular, o paciente pode realizar movimentos laterais, verticais ou protrusivos. Clinicamente é uma posição de referência útil e repetível. Portanto, a RC é uma posição condilar que independe dos contatos dentários. '));
      lista.add(TermosTecnicos('Espaço Funcional Livre (EFL)', 'é a distância entre os dentes antagonistas quando a mandíbula está em posição de repouso postural. É a diferença entre a dimensão vertical de repouso e a de oclusão e apresenta valores médios de 3 mm. O Glossário de termos protéticos, em sua 9ª edição (GPT-9, 2017) conceitua esse espaço como Espaço de Repouso Interoclusal (IORS – interoclusal rest space).'));
      lista.add(TermosTecnicos('Máxima Intercuspidação Habitual (MIH)', 'posição de intercuspidação completa dos dentes opostos, independentemente da posição condilar. Às vezes referida como o melhor ajuste dos dentes, independentemente da posição condilar.'));
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home), 
            label: 'Menu'
          ),
          NavigationDestination(
            icon: Icon(Icons.info), 
            label: 'Sobre',
          ),
        ],
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
            Navigator.pushNamed(context,'Sobre');
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
              fontSize: 30
            )
          ),
        ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        //List view
        child: ListView.builder(
          //Quant de itens
          itemCount: lista.length,
          //aparencia de cada item
          itemBuilder:(context, index){
            return Card(
              child: ListTile(
                // leading: const Icon(Icons.person_2_rounded),
                title: Text(
                  lista[index].nome,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 10, 16, 83),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )
                  ),
                subtitle: Text(lista[index].descricao),
                onTap: () {
                },
                hoverColor: const Color.fromARGB(50, 25, 195, 207),
              ),
            );
          },
        ),
      ),
    );
  }
}