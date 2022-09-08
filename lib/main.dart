import 'package:brilliantnotes/firebase_options.dart';
import 'package:brilliantnotes/views/login_view.dart';
import 'package:brilliantnotes/views/register_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page'),),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ), 
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.done:
              print(FirebaseAuth.instance.currentUser);
              final user = FirebaseAuth.instance.currentUser; //user? <<< optional user, talvez o user não exista no momento
              final emailVerified = user?.emailVerified ?? false; //se o usuário existe, pega isso, se não, pega falso
              if(emailVerified){
                print('You are verified.');
              }
              else{
                print('You are not verified.');
              }
              return const Text('Done');
            default:
              return const Text('Loading');
          }
        },
      ),
    );
  }
}