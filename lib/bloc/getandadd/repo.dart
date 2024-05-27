import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pizza_hut_admin/bloc/getandadd/model/pizzamodel.dart';

class PizzaServiese{
   final FirebaseFirestore firestore=FirebaseFirestore.instance;
   Future<List<Pizza>> getPizza() async {
    List<Pizza> packageList = [];
    try {
      final datas = await FirebaseFirestore.instance
          .collection('pizza').get();
      datas.docs.forEach((element) { 
        print(element.data());
        packageList.add(Pizza.fromMap(element.data()));
      });
      print("${packageList.length} is lenght      ");
      return packageList;
    } catch (e) {
      print(e.toString());
      return packageList;
    }
  }
  Future<void> addPizza(Pizza pizza,BuildContext context) async {
     final db = FirebaseFirestore.instance;
     String uid = db.collection('pizza').doc().id;
     pizza.pid =uid;
     print(pizza.pid);
     print(pizza.toMap());
    await db.collection("pizza").doc(uid).set(pizza.toMap(), SetOptions(merge: true)).then((value){
      print("added succesfully");
    });
  }
}