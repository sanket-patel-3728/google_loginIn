import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireBase extends StatefulWidget {
  @override
  _FireBaseState createState() => _FireBaseState();
}

class _FireBaseState extends State<FireBase> {
  String studentName, studentId, studentProgramId;
  double studentGPA;

  getStudentName(name) {
    this.studentName = name;
  }
  getStudentProgramId(programId) {
    this.studentProgramId = programId;
  }
  getStudentId(id) {
    this.studentId = id;
  }
  getStudentGPA(gpa) {
    this.studentGPA = double.parse(gpa);
  }

  createData() {
    DocumentReference documentReference =
        Firestore.instance.collection("MyStudents").document(studentName);

    Map<String, dynamic> students = {
      "studentName": studentName,
      "studentId": studentId,
      "programId": studentProgramId,
      "studentGPA": studentGPA,
    };

    documentReference.setData(students).whenComplete(() {});
  }

  readData() {
    DocumentReference documentReference =
        Firestore.instance.collection("MyStudents").document(studentName);

    documentReference.get().then((datasnapshot) {
      print(datasnapshot.data["studentName"]);
      print(datasnapshot.data["studentId"]);
      print(datasnapshot.data["programId"]);
      print(datasnapshot.data["studentGPA"]);
    });
  }

  updateData() {
    DocumentReference documentReference =
        Firestore.instance.collection("MyStudents").document(studentName);

    Map<String, dynamic> students = {
      "studentName": studentName,
      "studentId": studentId,
      "programId": studentProgramId,
      "studentGPA": studentGPA,
    };

    documentReference.setData(students);
  }

  deleteData() {
    DocumentReference documentReference =
        Firestore.instance.collection("MyStudents").document(studentName);

    documentReference.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD operations'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: (String name) {
                getStudentName(name);
              },
              decoration: InputDecoration(
                  labelText: 'Name',
                  fillColor: Colors.teal,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    width: 3.0,
                    color: Colors.teal,
                  ))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: (String id) {
                getStudentId(id);
              },
              decoration: InputDecoration(
                  labelText: 'Student Id',
                  fillColor: Colors.teal,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.teal,
                  ))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: (String programId) {
                getStudentProgramId(programId);
              },
              decoration: InputDecoration(
                  labelText: 'Study Program Id',
                  fillColor: Colors.teal,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    width: 3.0,
                    color: Colors.teal,
                  ))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (String gpa) {
                getStudentGPA(gpa);
              },
              decoration: InputDecoration(
                  labelText: 'GPA',
                  fillColor: Colors.teal,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    width: 3.0,
                    color: Colors.teal,
                  ))),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton(
                color: Colors.lightGreen,
                onPressed: () {
                  createData();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text('CREATE'),
                textColor: Colors.white,
              ),
              RaisedButton(
                color: Colors.orange,
                onPressed: () {
                  updateData();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text('UPDATE'),
                textColor: Colors.white,
              ),
              RaisedButton(
                color: Colors.blue,
                onPressed: () {
                  readData();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text('READ'),
                textColor: Colors.white,
              ),
              RaisedButton(
                color: Colors.red,
                onPressed: () {
                  deleteData();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text('DELETE'),
                textColor: Colors.white,
              ),
            ],
          ),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Name' , style: TextStyle(fontSize: 20.0),),
              Text('StudedntID' , style: TextStyle(fontSize: 20.0),),
              Text('ProgramId' , style: TextStyle(fontSize: 20.0),),
              Text('GPA' , style: TextStyle(fontSize: 20.0),),
            ],
          ),
          StreamBuilder(
            stream: Firestore.instance.collection("MyStudents").snapshots(),
            // ignore: missing_return
            builder:(context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshot.data.documents[index];
                    return Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            documentSnapshot["studentName"],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            documentSnapshot["studentId"],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            documentSnapshot["programId"],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            documentSnapshot["studentGPA"].toString(),
                          ),
                        )
                      ],
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
