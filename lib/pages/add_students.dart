import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
class AddStudents extends StatefulWidget {
  const AddStudents({ Key? key }) : super(key: key);

  @override
  State<AddStudents> createState() => _AddStudentsState();
}

class _AddStudentsState extends State<AddStudents> {
  final _formKey = GlobalKey <FormState>();

  var name ="";
  var email ="";
  var password ="";
 
 final nameContoller = TextEditingController();
 final emailContoller = TextEditingController();
 final passwordContoller = TextEditingController();
  @override
  void dispose(){
    nameContoller.dispose();
    emailContoller.dispose();
    passwordContoller.dispose();
  }
  clearText(){
    nameContoller.clear();
    emailContoller.clear();
    passwordContoller.clear();
  }
  //adding students
  CollectionReference students = FirebaseFirestore.instance.collection('students');

 Future<void>  addUser(){
   return students.add({'name': name, 'email': email, 'password':password}).
   then((value) => print('Students are Added')).catchError((error)=>print('failed to students added $error'));
    //print('User Added');
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Row(
          children: [
            Text('Add',style: TextStyle(
              color: Colors.white,
              fontSize: 20),
            ),
            SizedBox(width: 5,),
             Text('New',style: TextStyle(
               fontSize: 20,
              color: Colors.amberAccent),
            ),
            SizedBox(width: 5,),
             Text('Student',style: TextStyle(
               fontSize: 20,
              color: Colors.deepOrange),
            ),
            
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 30),
        child: ListView(children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                labelText:'Name',
                labelStyle: TextStyle(fontSize: 20.0
                ),
                border: OutlineInputBorder(),
              errorStyle: TextStyle(
                color: Colors.redAccent,fontSize: 15
              ),
            
              ),
              controller: nameContoller,
              validator: (value) {
                if(value == null || value.isEmpty){
                  return 'please Enter Name';
                }else{
                  return null;
                }
              },
            ),
          ),
           Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                labelText:'Email',
                labelStyle: TextStyle(fontSize: 20.0
                ),
                border: OutlineInputBorder(),
              errorStyle: TextStyle(
                color: Colors.redAccent,fontSize: 15
              ),
            
              ),
              controller: emailContoller,
              validator: (value) {
                if(value == null || value.isEmpty){
                  return 'please Enter Email';
                }else if(!value.contains('@')){
                  return 'please Enter Valid Email';
                }
                else{
                  return null;
                }
              },
            ),
          ),
           Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                labelText:'Password',
                labelStyle: TextStyle(fontSize: 20.0,
            
                ),
                border: OutlineInputBorder(),
              errorStyle: TextStyle(
                color: Colors.redAccent,fontSize: 15
              ),
            
              ),
              obscureText: true,
              controller: passwordContoller,
              validator: (value) {
                if(value == null || value.isEmpty){
                  return 'please Enter Password';
                }else{
                  return null;
                }
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 60.0,top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){
                  if(_formKey.currentState!.validate()){
                    setState(() {
                      name = nameContoller.text;
                      email = emailContoller.text;
                      password = passwordContoller.text;
                      addUser();
                      clearText();
                    });
                  }

                },
                 child: Text('Register',
                 style: TextStyle(
                   fontSize: 18.0,
                   fontWeight: FontWeight.bold

                 ),
                 ),
                 style:ElevatedButton.styleFrom(primary: Colors.red) ,
                 ),
                 SizedBox(width: 80.0,),
                 ElevatedButton(onPressed: ()=>{
                  
                   clearText(),
                 }, 
                 child: Text('Reset',
                 style:TextStyle(
                   fontSize: 18.0,
                   fontWeight: FontWeight.bold
                 ) ,
                 ),
                 style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                 )

              ],
            ),
          )
        ],
        ),
        )
        )
    );
  }
}