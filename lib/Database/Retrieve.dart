import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:googlesheets/Database/sqflite.dart';
import 'package:shape_of_view_null_safe/shape/bubble.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';


class RetrieveData extends StatefulWidget {
  @override
  _RetrieveDataState createState() => _RetrieveDataState();
}

class _RetrieveDataState extends State<RetrieveData> {


  List<ModelClass1> list=[];
  final dbHelper = DatabaseHelper.instance;
  late ModelClass1 model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Student Record",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        child: gridHeader(),
        decoration: const BoxDecoration(
          color: Colors.white

        ),
      ),
    );
  }

  fetch() async {
    final allRows = await dbHelper.queryAllRows();
    allRows.forEach((row) => {
      model=ModelClass1(row["name"],row["email"],row["age"],row["_id"]),
      list.add(model)
    });
    setState(() {

    });
  }

  List<String> listHeader = ['Student Record'];
  Widget gridHeader(){
    return list.length==0? Center(
      child: Text("No Data Insert",
        style: TextStyle(color: Colors.white,
          fontSize: 20,
        ),
      ),
    ):
    ListView.builder(
        itemCount: listHeader.length,
        itemBuilder: (context, index) {
          return StickyHeader(
            header: new Container(
              height: 38.0,
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              alignment: Alignment.centerLeft,
              child: new Text(listHeader[index],
                style: const TextStyle(color: Color(0x3B2D2D2F), fontSize: 20,fontWeight: FontWeight.bold),
              ),
            ),
            content: Container(
              child: Card(
                color: Colors.transparent,
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1,),
                    itemBuilder: (contxt, indx){
                      return GestureDetector(
                        onTap: (){
                          openAlertBox(list[indx].key,list[indx].name,list[indx].email,list[index].age);
                        },
                        onLongPress: (){
                          DialogNew( context, list[indx].key);
                        },
                        child: Card(
                          color: Colors.transparent,
                          child: ShapeOfView(
                            shape: BubbleShape(
                                position: BubblePosition.Bottom,
                                arrowPositionPercent: 0.5,
                                borderRadius: 20,
                                arrowHeight: 10,
                                arrowWidth: 10
                            ),
                            child: Container(
                              child: Column(

                                children: [
                                  Card(child:
                                  Center(
                                    child: Text(list[indx].name.toString(),

                                      semanticsLabel:'${list[indx].email.toString()}\n${list[indx].age}\n${list[indx].key.toString()}',style: TextStyle(color: Colors.black,fontSize: 25),),
                                  )

                                  ),
                                  // Column(
                                  //   children: <Widget>[
                                  //     Center(
                                  //       child:
                                  //       Text(list[indx].name, style: TextStyle(
                                  //         fontSize: 25,
                                  //         fontWeight: FontWeight.bold,
                                  //         fontFamily: 'DancingScript',
                                  //       ),
                                  //       ),
                                  //     ),
                                  //     Text(list[indx].age.toString(), style: TextStyle(
                                  //         fontSize: 18,
                                  //         color: Colors.grey
                                  //     ),
                                  //     ),
                                  //     Text(list[indx].email, style: TextStyle(
                                  //         fontSize: 18,
                                  //         fontFamily: 'DancingScript',
                                  //         color: Colors.grey
                                  //     ),
                                  //     ),
                                  //     ShapeOfView(
                                  //         child: Center(
                                  //           child:  Text(list[indx].key.toString(),
                                  //             style: TextStyle(
                                  //               color: Colors.white,
                                  //             ),
                                  //           ),
                                  //         )
                                  //     )
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ),
            ),
          );
        }
    );
  }

  @override
  void initState() {
    fetch();
  }
  openAlertBox(int key,String name1,String email1, int age) {
    String name,email;
    name=name1;
    email=email1;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))
            ),
            content: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(32))
              ),
              width: 300.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Update Record",
                      style: TextStyle(fontSize: 30.0,
                        fontFamily: 'DancingScript',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.blue[100],
                    height: 5.0,
                  ),
                  TextField(
                    controller: TextEditingController()..text = name1,
                    onChanged: (text){
                      name=text;
                    },
                    cursorColor: Colors.blue[100],
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      hintText: "Update Name",
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                    ),
                    maxLines: 1,
                  ),
                  TextField(
                    controller: TextEditingController()..text = email1,
                    onChanged: (text){
                      email=text;
                    },
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: "Update Email",
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                    ),
                    maxLines: 1,
                  ),
                  GestureDetector(
                    onTap: (){
                      _update(key, name, email);
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    },

                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'DancingScript',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  DialogNew(BuildContext context,int key){
    AlertDialog alert;
    Widget noButton = FlatButton(
      child:  Container(
color: Colors.black,
          height: 30,
          width: 60,
          child: Center(
            child: Text("No",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                )
            ),
          )
      ),
      onPressed: () =>     Navigator.of(context, rootNavigator: true).pop('dialog'),
    );

    Widget okButton = FlatButton(
      child:  Container(
        color: Colors.black,
          height: 30,
          width: 60,
          child: Center(
            child: Text("Yes",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                )
            ),
          )
      ),
      onPressed: () {
        _delete(key);
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      title: Text("Delete Data",
        style: TextStyle(
          fontFamily: "DancingScript",
          color: Colors.black,
        ),
      ),
      content: Text("Do you want to delete data???",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      actions: [
        Row(
          children: <Widget>[
            okButton,
            SizedBox(
              width: 10,
            ),
            noButton,
          ],
        )
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _update(int key,String name,String email) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : key,
      DatabaseHelper.columnName : name,
      DatabaseHelper.columnEmail  : email
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  void _delete(int id) async {
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ModelClass1>('model', model));
  }

}

