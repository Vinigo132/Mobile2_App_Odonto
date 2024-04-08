import 'package:flutter/material.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() =>  _CadastroScreenState();
}

class  _CadastroScreenState extends State <CadastroScreen> {
  bool passwordVisible = false;
  bool passwordVisibleConfirm = false; 
      
   @override 
    void initState(){ 
      super.initState(); 
      passwordVisible = true;
      passwordVisibleConfirm = true; 
    }

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
                      height: 25,
                    ),
                    TextFormField(
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
                        onPressed: (){},
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
            )
          )
        ),
      );  
  }
}