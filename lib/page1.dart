import 'package:flutter/material.dart';
import 'package:googlesheets/GooglesheetCode.dart';
import 'package:googlesheets/Form.dart';

import 'Database/Retrieve.dart';
import 'Database/sqflite.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  final dbHelper = DatabaseHelper.instance;
  late String name,email,age;

  void output()
  async
  {
    final feedback = {
      SheetsColumn.name: nameController.text.trim(),
      SheetsColumn.email: emailController.text.trim(),
      SheetsColumn.age: ageController.text.trim(),


    };
    nameController.clear();
    emailController.clear();
    ageController.clear();
    await SheetsFlutter.insert([feedback]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                onChanged: (val){
                  name=val;
                },
                decoration: InputDecoration(
                  border:OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  hintText: 'name',
                ),
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: emailController,
                onChanged: (val){
                  email=val;
                },
                decoration: InputDecoration(
                  border:OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  hintText: 'Email',
                ),
              ),
              const  SizedBox(height: 10),
              TextField(
                controller: ageController,
                onChanged: (val){
                  age=val;
                },
                decoration: InputDecoration(
                  border:OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  hintText: 'Age',
                ),
              ),
              const  SizedBox(height: 10,),
              GestureDetector(
                onTap: () async {
                  _insert();
                  setState(()
                  {
                    output();
                  });
                },
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      width: 400,
                      color: const Color(0x79414165),
                      child: const Center(child: Text("Save to Data")
                      ),

                    ),
                    FlatButton(onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RetrieveData(),
                        ),
                      );

                    }, child: Text('show data'),
                    ),
                    // FlatButton(onPressed: (){
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => RetrieveData(),
                    //     ),
                    //   );
                    //
                    // }, child: Text('show data'),
                    // )
                  ],

                ),

              )
            ],
          ),
        ),

        ),
      );


  }

  void   _insert() async{
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : name,
      DatabaseHelper.columnAge  : age,
      DatabaseHelper.columnEmail  : email,
    };

    final id = await dbHelper.insert(row);
    print("Id is:   $id" );
  }
}



class Data {
  String name, email, age;

  Data({required this.name, required this.email, required this.age,});
}