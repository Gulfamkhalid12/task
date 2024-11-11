// ignore_for_file: unused_local_variable, prefer_const_constructors, avoid_types_as_parameter_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task/presentation/pages/login_screen.dart';
import 'package:task/utilis/utilis.dart';
import 'package:task/widgets/button.dart';
import 'package:task/widgets/text_field.dart';
 

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final   _formfiled= GlobalKey<FormState>();
   final  FirebaseAuth _auth = FirebaseAuth.instance;
    var usernamecontroller = TextEditingController();
    var _mailcontroller = TextEditingController();
    var _passwordcontroller = TextEditingController();
    
  @override
  void dispose() {
    usernamecontroller.dispose();
    _mailcontroller.dispose();
    _passwordcontroller.dispose();   
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                width:double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const  Icon(Icons.account_circle,size: 90,color: Colors.blue,),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                    key: _formfiled,
                    child: Column(
                      children: [
                     CustomTextField(
                      controller: usernamecontroller,
                       hintText: "Username", 
                       iconData: (Icons.supervised_user_circle_outlined),
                       validator: (value){
                      if(value!.isEmpty){
                        return "Enter User Name";
                      }
                      return null;
                    },
                       ),
                  SizedBox(
                    height: 20,
                  ),
                   CustomTextField(
                      controller: _mailcontroller,
                       hintText: "Email", 
                       iconData: (Icons.mail),
                       validator: (value){
                      if(value!.isEmpty){
                        return "Enter E-mail";
                      }
                      return null;
                    },
                       ),
                const  SizedBox(
                    height: 15,
                  ),
                   CustomTextField(
                      controller: _passwordcontroller,
                       hintText: "Password", 
                       iconData: (Icons.lock_clock_outlined),
                       validator: (value){
                      if(value!.isEmpty){
                        return "Enter Password";
                      }
                      return null;
                    },
                       ),
                      ],
                    )
                  ),
                    const  SizedBox(
                      height: 30,
                    ),
                    CustomButton(onPressed: (){  
                        if( _formfiled.currentState!.validate()){
                        _signup();  
                      } 
                    }, text: "Sign Up"),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   const Text ("Already have an Account?",
                   style: TextStyle(fontSize: 15,
                   fontWeight: FontWeight.bold),),
                   const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  const LoginScreen()),);
                    },
                    child:  const Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ), 
              ],
            ),
                  ],
                ),
              ),
            ),
          )
        ),
    );
  }

 void _signup(){
   _auth.createUserWithEmailAndPassword(
    email: _mailcontroller.text.toString(),
     password: _passwordcontroller.text.toString()).then((value) { 
       utilts().toastmessage(value.toString());
       Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
   }).onError((error, stackTrace){
    utilts().toastmessage(error.toString());

    });


 }
}