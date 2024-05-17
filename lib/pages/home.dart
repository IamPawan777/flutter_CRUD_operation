// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_operation/pages/employee.dart';
import 'package:crud_operation/service/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController namecontroller = new TextEditingController();
  TextEditingController agecontroller = new TextEditingController();
  TextEditingController locationcontroller = new TextEditingController();

  Stream? EmployeeStream;
  getontheload() async {
    EmployeeStream = await DatabaseMethods().getEmployeeDetails();
  setState(() {

  });
  }

  @override
  void initState() {
  getontheload();
  super.initState();
  }

  Widget allEmployeeDetails() {
    return StreamBuilder(
      stream: EmployeeStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Name : "+ds["Name"],
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),

                                
//UPDATE..
                                GestureDetector(                                   // update
                                  onTap: () {                            
                                    namecontroller.text = ds["Name"];             //already field
                                    agecontroller.text = ds["Age"];
                                    locationcontroller.text = ds["Location"];
                                    EditEmployeeDetail(ds["Id"]);
                                  },
                                  child: Icon(Icons.edit, color: Colors.green,)
                                ),
                                SizedBox(width: 10,),
                                

//DELETE..
                                GestureDetector(                          // delete
                                  onTap: () async {
                                    await DatabaseMethods().deleteEmployeeDetails(ds['Id']).then((value){
                                      Fluttertoast.showToast(
                                        msg: "Delete successfully",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    });
                                  },
                                  child: Icon(Icons.delete, color: Colors.red,)
                                ),

                              ],
                            ),
                            Text(
                              "Age : "+ds["Age"],
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Location : "+ds["Location"],
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Container();
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // navigate to employee page
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Employee()));
        },
        child: Icon(Icons.add),
      ),

      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 229, 221, 195),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Create  Read",
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "  Update  Delete",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: [
            Expanded(child: allEmployeeDetails()),        

          ],
        ),
      ),
    );
  }

  Future EditEmployeeDetail(String id) => showDialog(context: context, builder: (context) => AlertDialog(
    content: Container(
      height: MediaQuery.of(context).size.width*1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.cancel),
              ),
              SizedBox(width: 30,),
              Text(
              "Edit",
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              " Details",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            )
            ],
          ),
          SizedBox(height: 10,),

          Text(
              "Name",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: namecontroller,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),

            SizedBox(
              height: 10.0,
            ),
            Text(
              "Age",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: agecontroller,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),

            SizedBox(
              height: 10.0,
            ),
            Text(
              "Location",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: locationcontroller,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),


//  update...........
            SizedBox(height: 10,),
            Center(
              child: ElevatedButton(onPressed: ()async{
                Map<String, dynamic>updateInfo={
                  "Name": namecontroller.text,
                  "Age": agecontroller.text,
                  "Id": id,
                  "Location": locationcontroller.text,
                };

                await DatabaseMethods().updateEmployeeDetails(id, updateInfo).then((value) {
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                    msg: "Updated Successfully",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);

                }).onError((error, stackTrace) {

                });
              }, child: Text('Update')),
            ),

        ],
      ),
    ),
  ));

}
