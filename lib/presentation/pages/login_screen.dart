// ignore_for_file: prefer_const_constructors, non_constant_identifier_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/presentation/pages/homepage.dart';
import 'package:task/presentation/pages/signup_screen.dart';
import 'package:task/utilis/utilis.dart';
import 'package:task/widgets/button.dart';
import 'package:task/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final  FirebaseAuth _auth = FirebaseAuth.instance;
   final  _passwordcontroller = TextEditingController();
   final  _mailcontroller = TextEditingController();
   final   _formfiled= GlobalKey<FormState>();
    @override
  void dispose() {
    _passwordcontroller.dispose();
    _mailcontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
              width:double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_circle,size: 90,color: Colors.blue,),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formfiled,
                    child: Column(
                      children: [
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
                       iconData: (Icons.lock_outlined),
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
                      _login(); 
                      }  
                  }, text: "Sign In"),
                   const SizedBox(
                    height: 15,
                  ),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",
                    style: TextStyle(fontSize: 15,
                    fontWeight: FontWeight.bold),),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        if(_formfiled.currentState!.validate());
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen(),));
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),
                      ),
                    ), 
                ],
              ),
            ] )
                    ),
          ), 
      ),
    ));
  }



void _login() {
  _auth.signInWithEmailAndPassword(
   email: _mailcontroller.text.toString(),
  password: _passwordcontroller.text.toString()).then((value) async {
    utilts().toastmessage(value.user!.email.toString());
    if(value!=null && value.user!.email.toString().isNotEmpty){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('login_sucess', true);
      var login_sucess = await prefs.setBool('login_sucess', true);
      
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()));
    
  }).onError((error, stackTrace) {
  utilts().toastmessage(error.toString());
  },);

}
}