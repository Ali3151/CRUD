import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/pages/update_student.dart';
import 'package:flutter/material.dart';
class listStudentsPage extends StatefulWidget {
  const listStudentsPage({ Key? key }) : super(key: key);

  @override
  State<listStudentsPage> createState() => _listStudentsPageState();
}

class _listStudentsPageState extends State<listStudentsPage> {

final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('students').snapshots();
      // for delete user
      CollectionReference students = FirebaseFirestore.instance.collection('students');
  Future<void> deleteuser(id){
   // print("user Delete $id");
   return students.doc(id).delete().then((value) => 
   print('user Deleted...')).catchError((error)=>print('failed to delete user: $error '));
  }
  @override
  Widget build(BuildContext context) {
   return StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
      if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
     
          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();
      return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  1: FixedColumnWidth(140),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          color: Colors.greenAccent,
                          child: Center(
                            child: Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.greenAccent,
                          child: Center(
                            child: Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.greenAccent,
                          child: Center(
                            child: Text(
                              'Action',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  for(var i=0; i< storedocs.length;i++ )...[
                  
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                              child: Text(storedocs[i]['name'],
                                  style: TextStyle(fontSize: 18.0))),
                        ),
                        TableCell(
                          child: Center(
                              child: Text(storedocs[i]['email'],
                                  style: TextStyle(fontSize: 18.0))),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () => {
                                  Navigator.push(context,MaterialPageRoute(
                                    builder: (context)=>updateStudent(id:storedocs[i]['id'])
                                    )
                                    )
                                  
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.orange,
                                ),
                              ),
                              IconButton(
                                onPressed: () =>{deleteuser(storedocs[i]['id'])}
                                   ,
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]
                  ],
                
              ),
            ),
          );
        });
    
  }
}