// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/presentation/pages/login_screen.dart';
import 'package:task/presentation/pages/post_data.dart';
 

class Homepage extends StatefulWidget {
 
 const  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
  final firestore = FirebaseFirestore.instance.collection("User").snapshots();
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton:FloatingActionButton(
          backgroundColor: Colors.blue[50],
          onPressed: (){
           Navigator.push(context,
            MaterialPageRoute(
            builder: (context)=> PostData()));
        },
        child: Icon(Icons.add),),
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.blue[50],
          title: Text("HomePage",
          style: GoogleFonts.poppins(fontSize: 20,
          fontWeight: FontWeight.w500)),
          actions: [
           IconButton(onPressed: () async {
            FirebaseAuth.instance.signOut();
                 SharedPreferences prefs = await SharedPreferences.getInstance();
                 setState(() async {
                    if(await prefs.setBool('login_sucess', true)==true){
                      await prefs.setBool('login_sucess', false);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    }
                var login_sucess = await prefs.getBool('login_sucess');
      

                 });
               
            
           },
            icon:Icon(Icons.logout_rounded,size: 25,))
          ],
        ),
        body:Column(
          children: [
            SizedBox(
              height: 20,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: firestore,
               builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return CircularProgressIndicator();
                }
                else if (snapshot.hasError)
                {
                return Text("Some Error Occurs");
                }
                return  Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(snapshot.data!.docs[index]["Tittle"],style: GoogleFonts.poppins(fontSize: 22,color: Colors.blue,fontWeight: FontWeight.w600),),
                            SizedBox(height: 06,),
                            Text(snapshot.data!.docs[index]["Description"],style: GoogleFonts.poppins(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500),),
                            SizedBox(height: 10,),
                        
                          ],
                        ),
                      );

                    }));
               }

         ) ],
        )
      ),
     
    );
  }
}