import 'package:cloud_firestore/cloud_firestore.dart';

// CREAT....
class DatabaseMethods {
  Future addEmployeeDetails(
      Map<String, dynamic> employeeInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Employee1")
        .doc(id)
        .set(employeeInfoMap);
  }


// READ (FETCH)....
Future<Stream<QuerySnapshot>> getEmployeeDetails()async{
  return await FirebaseFirestore.instance.collection("Employee1").snapshots();
}


// UPDATE....
Future updateEmployeeDetails(String id, Map<String, dynamic> updateInfo)async{
  return await FirebaseFirestore.instance.collection('Employee1').doc(id).update(updateInfo);
}


// DELETE....
Future deleteEmployeeDetails(String id)async{
  return await FirebaseFirestore.instance.collection('Employee1').doc(id).delete();
}


}


