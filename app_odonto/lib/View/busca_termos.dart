import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Model/termos_tecnicos.dart';

class BuscaTermos extends StatefulWidget {
  const BuscaTermos({super.key});

  @override
  State<BuscaTermos> createState() => _BuscaTermosState();
}

class _BuscaTermosState extends State<BuscaTermos> {

  List<TermosTecnicos> lista = [];

  @override 
    void initState(){ 
      super.initState();
      lista.add(TermosTecnicos('Relação Cêntrica (RC)', 'relacionamento maxilomandibular independente do contato dentário, no qual os côndilos se articulam na posição anterossuperior contra as inclinações posteriores das eminências articulares. Nesta posição, a mandíbula realiza apenas um movimento de rotação. A partir desta posição fisiológica, de relação maxilomandibular, o paciente pode realizar movimentos laterais, verticais ou protrusivos. Clinicamente é uma posição de referência útil e repetível. Portanto, a RC é uma posição condilar que independe dos contatos dentários. '));
      lista.add(TermosTecnicos('Espaço Funcional Livre (EFL)', 'é a distância entre os dentes antagonistas quando a mandíbula está em posição de repouso postural. É a diferença entre a dimensão vertical de repouso e a de oclusão e apresenta valores médios de 3 mm. O Glossário de termos protéticos, em sua 9ª edição (GPT-9, 2017) conceitua esse espaço como Espaço de Repouso Interoclusal (IORS – interoclusal rest space).'));
      lista.add(TermosTecnicos('Máxima Intercuspidação Habitual (MIH)', 'posição de intercuspidação completa dos dentes opostos, independentemente da posição condilar. Às vezes referida como o melhor ajuste dos dentes, independentemente da posição condilar.'));
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        //List view
        child: Column(
          children: [
          TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Digite o Termo Técnico",
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: (){}, 
                          )
                      ),
          ),
          const SizedBox(
                      height: 10,
          ),
          Expanded(
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
                      Clipboard.setData(ClipboardData(text: lista[index].descricao));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Descrição copiada')),
                      );
                    },
                    hoverColor: const Color.fromARGB(50, 25, 195, 207),
                  ),
                );
              },
            ),
          ),
          ]
        ),
      ),
    );

  }
}