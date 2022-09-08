import 'package:brilliantnotes/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  //Fazendo os caras pra armazenar as informações dos TextFields pra passar pro TextButton
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState(){
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState(); //roda a função init state original depois de fazer a palhaçada
  }

  @override
  void dispose(){
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register'),),
      body: FutureBuilder(
        future: Firebase.initializeApp(
                  options: DefaultFirebaseOptions.currentPlatform,
                ),
        builder: (context, snapshot){
          switch (snapshot.connectionState){
            case ConnectionState.done:
              return Column( //ctrl + . mostra opções de atalho foda
          children:[
            TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'E-mail'
              ),
            ),
            TextField(
              controller: _password,
              enableSuggestions: false,
              autocorrect: false,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password'
              ),
            ),
            TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try{
                  final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  //print(userCredential);
                } on FirebaseAuthException catch(e){
                  if (e.code ==  'weak-password'){
                    print('Weak password!');
                  }
                  else if (e.code == 'invalid-email'){
                    print('Please insert a valid email.');
                  }
                  else if (e.code == 'email-already-in-use'){
                    print('Email is already being used.');
                  }
                }

              },
              child: const Text('Register'),
            ),
          ],
        );
            default:
              return const Text('Loading');
          }
        },
      ),
    );
  }
}