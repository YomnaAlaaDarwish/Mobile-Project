import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final String _loginUrl = 'http://127.0.0.1:8000/api/login';

  bool _loading = false;
  String? _errorMessage; // Store error message

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
        _errorMessage = null; // Reset error message
      });

      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      try {
        var response = await http.post(Uri.parse(_loginUrl), body: {
          'email': email,
          'password': password,
        });

        setState(() {
          _loading = false;
        });

        if (response.statusCode == 200) {
          Navigator.pushReplacementNamed(context, '/profile');
        } else {
          setState(() {
            _errorMessage = 'Invalid email or password. Please try again.';
          });
        }
      } catch (error) {
        print('Error: $error');
        setState(() {
          _errorMessage =
              'There was a problem logging in. Check your email and password.';
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_errorMessage != null) // Show error message if exists
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 10),
                color: Colors.red,
                child: Text(
                  _errorMessage!,
                  style: TextStyle(
                    color: Colors.white, // Text color for error message
                    fontSize: 16, // Adjust font size if needed
                  ),
                ),
              ),
            const Padding(
              padding: EdgeInsets.all(1.0),
              child: SizedBox(height: 1.0),
            ),
           
            SizedBox(height: 20.0),
            Container(
               // Adjust the width as needed
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 249, 251, 253),
                  borderRadius: BorderRadius.circular(15.0), // Circular ends
                   boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),]
                ),
              
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _emailController,
                      style: TextStyle(color: Colors.black), // Text color for input fields
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.black), // Text color for label
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: _passwordController,
                      style: TextStyle(color: Color.fromARGB(255, 8, 8, 8)), // Text color for input fields
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.black), // Text color for label
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: _loading ? null : _login,
              child: _loading ? CircularProgressIndicator() : Text('Login'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor:Color.fromARGB(255, 24, 48, 104), // Button text color
              ),
            ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 20.0),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?', style: TextStyle(color: Colors.black)), // Text color for label
                  TextButton(
                    onPressed: _loading
                        ? null
                        : () {
                            Navigator.pushNamed(context, '/signup');
                          },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}