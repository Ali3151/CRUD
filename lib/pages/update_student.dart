import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class updateStudent extends StatefulWidget {
  final String id ;
  updateStudent({ Key? key, required this.id }) : super(key: key);

  @override
  State<updateStudent> createState() => _updateStudentState();
}

class _updateStudentState extends State<updateStudent> {
  final _formKey = GlobalKey<FormState>();

  //students update
  CollectionReference studnets = FirebaseFirestore.instance.collection('students');
 Future<void> updateuser(id, name, email, password) {
    return studnets
        .doc(id)
        .update({'name': name, 'email': email, 'password': password})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor: Colors.blueGrey,
        title: Row(
          children: [
            Text('Update',style: TextStyle(
              color: Colors.white,
              fontSize: 20),
            ),
            SizedBox(width: 5,),
             Text('Students',style: TextStyle(
               fontSize: 20,
              color: Colors.yellow),
            )
          ]
        )
      ),
      body:Form(
        key: _formKey,
        child: FutureBuilder<DocumentSnapshot<Map <String,dynamic>>>(
          future:FirebaseFirestore.instance
          .collection('students')
          .doc(widget.id).get(),
          builder: (_, snapshot){
            if(snapshot.hasError){
              print('something went wront');
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),
              );
            }
            var data = snapshot.data!.data();
            var name  = data!['name'];
            var email  = data ['email'];
            var password = data ['password'];
            return Padding(padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: TextFormField(
                autocorrect: false,
                initialValue: name,
                onChanged: (value)=>name=value,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(fontSize: 20.0),
                border: OutlineInputBorder(),
                errorStyle: TextStyle(
                  color: Colors.redAccent,fontSize: 15
                )

              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'please Enter Name';
                }
                return null;
              },
              
              ),
            ),
             Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: TextFormField(
              autofocus: false,
              initialValue: email,
              onChanged: (value)=>email=value,
              decoration: InputDecoration(
                labelText:'email',
                labelStyle: TextStyle(fontSize: 20.0
                ),
                border: OutlineInputBorder(),
              errorStyle: TextStyle(
                color: Colors.redAccent,fontSize: 15
              ),
            
              ),
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
              initialValue: password,
              onChanged: (value)=>password=value,
              obscureText: true,
              decoration: InputDecoration(
                labelText:'Password',
                labelStyle: TextStyle(fontSize: 20.0,
            
                ),
                border: OutlineInputBorder(),
              errorStyle: TextStyle(
                color: Colors.redAccent,fontSize: 15
              ),
            
              ),
             
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
            // margin: EdgeInsets.only(right: 60.0,top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: (){
                  if(_formKey.currentState!.validate()){
                  updateuser(widget.id, name, email, password);
                   Navigator.pop(context);
                  }

                },
                 child: Text('Update',
                 style: TextStyle(
                   fontSize: 18.0,
                   fontWeight: FontWeight.bold

                 ),
                 ),
                 style:ElevatedButton.styleFrom(primary: Colors.green) ,
                 ),
                 SizedBox(width: 80.0,),
                 ElevatedButton(onPressed: ()=>{
                   
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
        );
          },
          
          ),
        
      ) ,
    );
  }
}