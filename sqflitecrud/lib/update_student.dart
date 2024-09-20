import 'package:flutter/material.dart';
import 'package:sqflitecrud/dbutils.dart';
import 'package:sqflitecrud/models/model_student.dart';

class UpdateStudentForm extends StatefulWidget {
  final Students updateStudent;

  UpdateStudentForm({required this.updateStudent});

  @override
  State<UpdateStudentForm> createState() =>
      _UpdateStudentFormState(updateStudent: this.updateStudent);
}

class _UpdateStudentFormState extends State<UpdateStudentForm> {
  final Students updateStudent;
  late TextEditingController _nameController;
  late TextEditingController _marksController;
  late TextEditingController _cityController;

  _UpdateStudentFormState({required this.updateStudent});

  @override
  void initState() {
    super.initState();

    // Initialize controllers with current student data
    _nameController = TextEditingController(text: updateStudent.name);
    _marksController =
        TextEditingController(text: updateStudent.marks.toString());
    _cityController = TextEditingController(text: updateStudent.city);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Update Student - ${updateStudent.id}"),
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              // Name Field
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter Your Name',
                ),
              ),
              SizedBox(height: 15),
              // Marks Field
              TextField(
                controller: _marksController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Marks',
                  hintText: 'Enter Your Marks',
                ),
              ),
              SizedBox(height: 15),
              // City Field
              TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'City',
                  hintText: 'Enter Your City',
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      DBUtils.getSingleTonInstance().UpdateRecorde(
                          context,
                          this.updateStudent.id,
                          this.updateStudent.name,
                          this.updateStudent.marks,
                          this.updateStudent.city);
                    },
                    child: Text("Update"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Go back without changes
                    },
                    child: Text("Back"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
