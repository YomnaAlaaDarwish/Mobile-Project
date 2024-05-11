import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  int? _selectedLevel;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final String _signupUrl = 'http://127.0.0.1:8000/api/signup';
  bool _loading = false;
  String _nameError = '';
  String _emailError = '';
  String _passwordError = '';
  String _confirmPasswordError = '';
  String? _selectedGender;

  bool _isValidFCIEmail(String email) {
    RegExp regex = RegExp(r'^[a-zA-Z0-9]+@(?:stud\.)?fci-cu\.edu\.eg$');
    return regex.hasMatch(email);
  }

  Future<void> _signup() async {
    setState(() {
      _loading = true;
    });

    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    setState(() {
      _nameError = '';
      _emailError = '';
      _passwordError = '';
      _confirmPasswordError = '';
    });

    if (name.isEmpty) {
      setState(() {
        _nameError = 'Name is required';
      });
    }
    if (email.isEmpty) {
      setState(() {
        _emailError = 'Email is required';
      });
    } else if (!_isValidFCIEmail(email)) {
      setState(() {
        _emailError = 'Invalid FCI Email';
      });
    }
    if (password.isEmpty) {
      setState(() {
        _passwordError = 'Password is required';
      });
    } else if (password.length < 8) {
      setState(() {
        _passwordError = 'Password must be at least 8 characters';
      });
    }
    if (confirmPassword.isEmpty) {
      setState(() {
        _confirmPasswordError = 'Confirm Password is required';
      });
    } else if (confirmPassword != password) {
      setState(() {
        _confirmPasswordError = 'Passwords do not match';
      });
    }
    if (_isValidFCIEmail(email)) {
      var emailExistsResponse =
          await http.post(Uri.parse('$_signupUrl/check-email'), body: {
        'email': email,
      });
      if (emailExistsResponse.statusCode == 409) {
        setState(() {
          _emailError = 'Email is already in use';
          _loading = false;
        });
        return;
      }
    }

    if (_nameError.isNotEmpty ||
        _emailError.isNotEmpty ||
        _passwordError.isNotEmpty ||
        _confirmPasswordError.isNotEmpty) {
      setState(() {
        _loading = false;
      });
      return;
    }

    var response = await http.post(Uri.parse(_signupUrl), body: {
      'name': name,
      'email': email,
      'level': _selectedLevel.toString(),
      'password': password,
      'password_confirmation': confirmPassword,
      'gender': _selectedGender,
    });

    setState(() {
      _loading = false;
    });

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      print(responseData);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Signup successful'),
        duration: Duration(seconds: 3),
      ));
      Navigator.pushReplacementNamed(context, '/', arguments: 'Signup successful');
    }
  }

  void _navigateToLoginPage() {
    Navigator.pushReplacementNamed(context, '/');
  }

  void _handleGenderChange(String? value) {
    setState(() {
      _selectedGender = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 246, 246, 246), Color.fromARGB(255, 24, 48, 104)],
          ),
        ),
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      errorText: _nameError.isEmpty ? null : _nameError,
                      errorStyle: TextStyle(color: Colors.red),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text('Gender:'),
                      SizedBox(width: 10),
                      Radio(
                        value: 'male',
                        groupValue: _selectedGender,
                        onChanged: _handleGenderChange,
                      ),
                      Text('Male'),
                      Radio(
                        value: 'female',
                        groupValue: _selectedGender,
                        onChanged: _handleGenderChange,
                      ),
                      Text('Female'),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: _emailError.isEmpty ? null : _emailError,
                      errorStyle: TextStyle(color: Colors.red),
                    ),
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<int>(
                    value: _selectedLevel,
                    onChanged: (int? newValue) {
                      setState(() {
                        _selectedLevel = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Level',
                    ),
                    items: <int>[1, 2, 3, 4].map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text('$value'),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: _passwordError.isEmpty ? null : _passwordError,
                      errorStyle: TextStyle(color: Colors.red),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      errorText: _confirmPasswordError.isEmpty ? null : _confirmPasswordError,
                      errorStyle: TextStyle(color: Colors.red),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _loading ? null : _signup,
                  
                    child: _loading ? CircularProgressIndicator() : Text('Sign Up',style: TextStyle(color: Color.fromARGB(255, 24, 48, 104)),),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?'),
                      TextButton(
                        onPressed: _navigateToLoginPage,
                        child: Text('Login',style: TextStyle(color: Color.fromARGB(255, 24, 48, 104)),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
