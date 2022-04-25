import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:near_laundry/models/sign_up.dart';
import 'package:near_laundry/screens/login_screen.dart';

import '../providers/database_helper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();

  String? _firstName;
  String? _lastName;
  String? _contact;
  String? _email;
  late String _password;
  late String? _cPassword;

  bool _isAllFieldsValid() {
    if (_firstNameController.text.isEmpty) {
      return false;
    }
    if (_lastNameController.text.isEmpty) {
      return false;
    }
    if (_contactController.text.isEmpty) {
      return false;
    }
    if (_emailController.text.isEmpty) {
      return false;
    }
    if (_passwordController.text.isEmpty) {
      return false;
    }
    if (_passwordController.text.isEmpty) {
      return false;
    }
    if (_cPasswordController.text.isEmpty) {
      return false;
    }
    return true;
  }

  Widget _firstNameTextField() {
    return Container(
      margin: const EdgeInsets.all(15),
      child: TextFormField(
        // initialValue: _firstName,
        controller: _firstNameController,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
                borderSide: BorderSide(color: Colors.transparent)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            prefixIcon: const Icon(Icons.person),
            filled: true,
            hintText: "First Name"),
        onChanged: (String firstName) => setState(
          () {
            firstName = _firstNameController.toString();
            _firstName = firstName;
          },
        ),

        autofocus: true,
      ),
    );
  }

  Widget _lastNameTextField() {
    return Container(
      margin: const EdgeInsets.all(15),
      child: TextFormField(
          //  initialValue: _lastName,
          controller: _lastNameController,
          decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  borderSide: BorderSide(color: Colors.transparent)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              prefixIcon: const Icon(Icons.person),
              filled: true,
              hintText: "Last Name"),
          onChanged: (String lastName) {
            setState(() {
              lastName = _lastNameController.toString();
              _lastName = lastName;
            });
          }),
    );
  }

  Widget _contactTextField() {
    return Container(
      margin: const EdgeInsets.all(15),
      child: TextFormField(
          //     initialValue: _contact,
          controller: _contactController,
          decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  borderSide: BorderSide(color: Colors.transparent)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              prefixIcon: const Icon(Icons.contact_page),
              filled: true,
              hintText: "Cell Number"),
          onChanged: (String contact) {
            setState(() {
              contact = _contactController.toString();
              _contact = contact;
            });
          }),
    );
  }

  Widget _emailTextField() {
    return Container(
      margin: const EdgeInsets.all(15),
      child: TextFormField(
          //   initialValue: _email,
          controller: _emailController,
          decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  borderSide: BorderSide(color: Colors.transparent)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              prefixIcon: const Icon(Icons.email_sharp),
              filled: true,
              hintText: "Email"),
          onChanged: (String email) {
            setState(() {
              email = _emailController.toString();
              _email = email;
            });
          }),
    );
  }

  Widget _passwordTextField() {
    return Container(
      margin: const EdgeInsets.all(15),
      child: TextFormField(
          // validator: (value) {
          //   if (value == '' || value == null) {
          //     return 'Confirm password is required';
          //   }
          //   return null;
          // },
          //    initialValue: _password,
          controller: _passwordController,
          decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  borderSide: BorderSide(color: Colors.transparent)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              prefixIcon: const Icon(Icons.lock),
              filled: true,
              hintText: "Password"),
          obscureText: true,
          onChanged: (String password) {
            setState(() {
              password = _passwordController.toString();
              _password = password;
            });
          }),
    );
  }

  Widget _confirmPasswordTextField() {
    return Container(
      margin: const EdgeInsets.all(15),
      child: TextFormField(
          //   initialValue: _cPassword,

          controller: _cPasswordController,
          decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  borderSide: BorderSide(color: Colors.transparent)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              prefixIcon: const Icon(Icons.key),
              filled: true,
              hintText: "Confirm Password"),
          obscureText: true,
          onChanged: (String cpassword) {
            setState(
              () {
                cpassword = _cPasswordController.toString();
                _cPassword = cpassword;
              },
            );
          }),
    );
  }

//Save all text from the controller to the database
  void _signUp() async {
    await DatabaseHelper.instance.add(
      SignUp(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          contact: _contactController.text,
          email: _emailController.text,
          password: _passwordController.text,
          createdAt: DateTime.now()),
    );

    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
            content: Text(
              'Registered successfully!',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )),
      );
    });
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }

  Widget _signUpButton() {
    return SizedBox(
      height: 50,
      width: 350,
      child: RaisedButton(
        color: _isAllFieldsValid()
            ? const Color.fromARGB(255, 155, 50, 137)
            : Colors.grey,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        onPressed: _isAllFieldsValid() ? _signUp : null,
        child: const Text(
          "Sign In",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            BackButton(
              color: Color.fromARGB(255, 155, 50, 137),
            ),
            Text(
              'Register ',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.blue,
                  fontSize: 30.0),
            ),
            Image(
              image: AssetImage('assets/images/login.png'),
              width: 50,
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50.0),
              _buildHeader(),
              const SizedBox(height: 10.0),
              _firstNameTextField(),
              _lastNameTextField(),
              _contactTextField(),
              _emailTextField(),
              _passwordTextField(),
              _confirmPasswordTextField(),
              const SizedBox(height: 50.0),
              _signUpButton(),
            ],
          ),
        ),
      ),
    );
  }
}
