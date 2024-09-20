import 'package:crud/models/model_student.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DBUtils {
  //hold a single object only
  static DBUtils instance = DBUtils._privateConstructor();

  static DBUtils getSingleTonInstance() {
    initedb(); // will be run one time
    return instance;
  }

  // private constructor they will b block other file to create objects of the class
  DBUtils._privateConstructor();

  static late Database currentDB;
  //Database Create -will be called once if db does't exist
  static void initedb() async {
    currentDB = await openDatabase("mydb.db", version: 1,
        onCreate: (Database db, int version) {
      db.execute(
          'CREATE TABLE Students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, marks INTEGER, city TEXT)');
      db.execute(
          "INSERT INTO Students(id,name,marks,city) VALUES (1,'A',56,'mds'),(2,'B',82,'AMD'),(1,'C',12,'G-nger')");
    });
  }

  // select record
//deflut argument defult perameter
  Future<List<Students>> getRecords({bool low = true}) async {
    String query;
    if (low == true) {
      query = "SELECT * FROM Students ORDER BY marks ASC ";
    } else {
      query = "SELECT * FROM Students ORDER BY marks DESC ";
    }
    List<Map<String, dynamic>> studentMapList = await currentDB.rawQuery(query);

    List<Students> listStudent = List.generate(studentMapList.length, (i) {
      return Students.fromMap(studentMapList[i]);
    });
    return listStudent;
  }

  // add record
  void addRecord(
      BuildContext context, String name, int marks, String city) async {
    await currentDB.transaction((txn) async {
      await txn.rawInsert(
          "INSERT INTO Students(name,marks,city) VALUES (?,?,?)",
          [name, marks, city]);
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Save Student data"),
    ));
  }

  // Delet Record
  void DeleteRecord(int id) async {
    //id receieve 1
    await currentDB.delete("Students", where: 'id=?', whereArgs: [id]);
  }

  void UpdateRecorde(
      BuildContext context, int id, String name, int marks, String city) async {
    Map<String, dynamic> newValues = {
      'name': name,
      'marks': marks,
      'city': city,
    };
    await currentDB
        .update("Students", newValues, where: 'id=?', whereArgs: [id]);
    //snake bar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Update Student data"),
    ));
  }
}
