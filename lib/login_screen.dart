import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notes/home_screen.dart';
import 'package:notes/services/auth_services.dart';
import 'package:notes/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(236, 10, 44, 71),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(236, 10, 44, 71),
        foregroundColor: Color.fromARGB(236, 235, 223, 223),
        title: Text('Sing In/ Iniciar Sesion'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 50),
              Text(
                "Welcome Back/Bienvenido nuevamente",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Log In Here",
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
                      User? user = await _auth.singInWithEmailAndPassWord(
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
                   )),
              ),

              SizedBox( height: 20),
              Text("Or",style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              TextButton(onPressed:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignupScreen(),
                ));
              },
               child: Text(
                "Created Account",
                 style: TextStyle(fontSize: 18),
                 ))

            ],
          ),
        ),
      ),
    );
  }
}
