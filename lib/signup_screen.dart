import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notes/home_screen.dart';
import 'package:notes/login_screen.dart';
import 'package:notes/services/auth_services.dart';

class SignupScreen extends StatelessWidget {
  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(237, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(237, 0, 0, 0),
        foregroundColor: Color.fromARGB(236, 235, 223, 223),
        title: Text('Crear una cuenta/ Create Account'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 50),
              Text(
                "Welcome/Bienvenido",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Register Here",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),
              TextField(
                controller: _emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white60),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.white60)),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passController,
                style: TextStyle(color: Colors.white),
                obscureText: true,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white60),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.white60)),
              ),
              SizedBox(height: 50),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width / 1.5, 
                child: ElevatedButton(
                    onPressed: () async {
                      User? user = await _auth.registerWithEmailAndPassWord(
                        _emailController.text,
                        _passController.text,
                      );
                
                      if(user !=null){
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context)=> HomeScreen(),
                          ));
                      }
                
                    },
                
                    child: Text(
                      "Register", style: TextStyle(
                       color: Colors.indigo,
                       fontSize:  18,
                    ),
                   )
                  ),
              ),
              SizedBox( height: 20),
              Text("Or",style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              TextButton(onPressed:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                ));
              },
               child: Text(
                "Log In",
                 style: TextStyle(fontSize: 18),
                 ))
            ],
          ),
        ),
      ),
    );
  }
}
