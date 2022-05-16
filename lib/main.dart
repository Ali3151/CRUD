import 'package:crud/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//flutter firebase cloud firestore database CRUD(Hindi)

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  final Future<FirebaseApp> _initialization =Firebase.initializeApp();


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: _initialization,
    builder:(context,snapshot) {
      //check for error
      if(snapshot.hasError){
        print('something wrong');
      }
      //once complete show your application
      if(snapshot.connectionState == ConnectionState.done){
        return    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fluter firestoe CRUD',
     
      home: HomePage(),
    );
      }
      return CircularProgressIndicator();


    },
    );
        
  
  }
}
