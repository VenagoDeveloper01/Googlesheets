import 'package:flutter/material.dart';
import 'package:googlesheets/GooglesheetCode.dart';
import 'package:googlesheets/Form.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();

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
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border:OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  hintText: 'name',
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border:OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  hintText: 'Email',
                ),
              ),
              const  SizedBox(height: 10),
              TextFormField(
                controller: ageController,
                decoration: InputDecoration(
                  border:OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  hintText: 'Age',
                ),
              ),
              const  SizedBox(height: 10,),
              GestureDetector(
                onTap: () async {
                  output();
                  setState(()
                  {

                    output();
                  });
                },
                child: Container(
                  height: 70,
                  width: 400,
                  color: const Color(0x79414165),
                  child: const Center(child: Text("Save to Data")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}