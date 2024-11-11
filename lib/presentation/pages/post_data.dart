// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/utilis/utilis.dart';

class PostData extends StatefulWidget {
  const PostData({super.key});

  @override
  State<PostData> createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {
  final firestore = FirebaseFirestore.instance.collection("User");
  var usertittle = TextEditingController();
  var userdisc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[50],
        centerTitle: true,
        title:Text("Post Data",
        style: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w500)),
      ),
      body: Center(
        child:Padding(
          padding: const EdgeInsets.only(left: 30,right: 30,top: 90),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Text("Insert Data",
        style: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w500)),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: usertittle,
                decoration: InputDecoration(
                  hintText: "Enter Tittle Here",
                )
              ),
              SizedBox(height: 25),
               TextFormField(
                controller: userdisc,
                maxLength: 10000,
                maxLines: 5,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                decoration: InputDecoration(
                  hintText: "Enter The Description",  
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                    onTap:() {
                      setState(() {
                        
                      });
                      String id =DateTime.now().millisecondsSinceEpoch.toString();
                      firestore.doc(id).set({
                        "Tittle": usertittle.text.toString(),
                        "Description": userdisc.text.toString(),

                      }).then((value){
                        utilts().toastmessage("Post Added");
                        usertittle.clear();
                        userdisc.clear();

                      }).onError((error, stackTrace){

                        utilts().toastmessage(error.toString());
                      });            
                    },
                    child: Container(
                      width: 150,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: Center(
                        child: Text("ADD",
                        style: TextStyle(fontSize: 18,
                         color: Colors.white,
                         fontWeight: FontWeight.w400),))
                    ),
                  ),
            ],
          ),
        )),
    );
  }
}