import 'package:flutter/material.dart';
import 'package:loginapp/screens/login_screen.dart';
import 'package:loginapp/screens/profile.dart';
import 'package:loginapp/screens/signup_screen.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Montserrat',
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 244, 244, 244),
            textStyle: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(194, 245, 246, 247), // Set app bar background color to teal
          titleTextStyle: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat', // Set app bar title font family
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
        '/profile': (context) => ProfileScreen(),
        '/signup': (context) => SignupPage(),
        '/login': (context) => LoginPage(),
      },
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String? successMessage = ModalRoute.of(context)?.settings.arguments as String?;

    // Show snackbar if success message is not null
    if (successMessage != null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(successMessage),
            duration: Duration(seconds: 3), // Adjust duration as needed
          ),
        );
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        backgroundColor: Color.fromARGB(255, 245, 245, 246),
        automaticallyImplyLeading: false,
    
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 94, 123, 186),
              Color.fromARGB(255, 24, 48, 104),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 60, 8, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Welcome back',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Pacifico', // Using Pacifico font for the welcome message
                    ),
                  ),
                ),
               
                   LoginForm(),
                  
                
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}


