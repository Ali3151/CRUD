import 'package:crud/pages/add_students.dart';
import 'package:crud/pages/list_student_page.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Row(
        children: [
          Text('Students Record'),
          SizedBox(width: 140.0,),
          ElevatedButton(
            onPressed: ()=>{
            Navigator.push(
              context, 
            MaterialPageRoute(
              builder: (context)=>AddStudents(),
              )
            )
          }, 
          child: Text('Add',style: TextStyle(fontSize: 20.0),),
          style: ElevatedButton.styleFrom(primary: Colors.redAccent),
          )
        ],
      ),
      backgroundColor: Colors.teal,
      ),
      body: Container(
        // margin: EdgeInsets.only(top: 20),
        child: listStudentsPage()),
      
    );
  }
}