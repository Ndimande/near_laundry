import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:near_laundry/models/sign_up.dart';
import 'package:near_laundry/models/user.dart';
import 'package:near_laundry/providers/database_helper.dart';
import 'package:near_laundry/screens/home_screen.dart';
import 'package:near_laundry/screens/signup_screen.dart';

void main() => runApp(const LoginScreen());

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _userNameControler = TextEditingController();
  TextEditingController _passwordControler = TextEditingController();
  String? _userName;
  String? _password;

  bool _isAllFieldsValid() {
    if (_userNameControler.text.isEmpty) {
      return false;
    }

    if (_passwordControler.text.isEmpty) {
      return false;
    }

    return true;
  }

  Widget _userNameTextField() {
    return Container(
      margin: const EdgeInsets.all(15),
      child: TextFormField(
        controller: _userNameControler,
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
          hintText: "Username",
        ),
        autofocus: true,
        onChanged: (String userName) {
          setState(() {
            userName = _userNameControler.text.toString();
            _userName = userName;
          });
        },
      ),
    );
  }

  Widget _passwordTextField() {
    return Container(
      margin: const EdgeInsets.all(15),
      child: TextFormField(
        controller: _passwordControler,
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
            hintText: "Password"),
        obscureText: true,
        onChanged: (String password) {
          setState(() {
            password = _passwordControler.text.toString();
            _password = password;
          });
        },
      ),
    );
  }

  bool isUserRegisteredInDB(List<SignUp> registeredUsers) {
    for (final SignUp user in registeredUsers) {
      if (user.email == _userName && user.password == _password) {
        return true;
      }
    }
    return false;
  }

  void _logIn() async {
    final List<SignUp> registeredUsers =
        await DatabaseHelper.instance.getRegisteredUsers();
    isUserRegisteredInDB(registeredUsers)
        ? await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            ),
          )
        : ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.white,
              duration: Duration(seconds: 2),
              content: Center(
                heightFactor: 2,
                child: Text(
                  'Please enter correct password and email',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );

    setState(() {});
  }

  Widget _loginButton() {
    return SizedBox(
      height: 50,
      width: 350,
      // ignore: deprecated_member_use
      child: RaisedButton(
        color: _isAllFieldsValid()
            ? const Color.fromARGB(255, 155, 50, 137)
            : Colors.grey,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(30),
        )),
        onPressed: _isAllFieldsValid() ? _logIn : null,
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

  Widget _forgotPassword() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 25),
          child: InkWell(
            onTap: _signUp,
            child: const Text(
              'Forgot password?',
              style: TextStyle(color: Colors.blue),
            ),
          ), // we can use FlatButton if we want here instead of Inkwel
        )
      ],
    );
  }

  void _signUp() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const SignUpScreen(),
      ),
    );
    setState(() {});
  }

  Widget _signUpRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Don't have an account ?",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          InkWell(
            onTap: _signUp,
            child: const Text(
              'Sign Up',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50.0),
              const Text(
                'Laundry Solutions',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.lightBlue,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    fontSize: 30.0),
              ),
              const SizedBox(height: 10.0),
              Lottie.network(
                'https://assets10.lottiefiles.com/packages/lf20_gn0tojcq.json',
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 10.0),
              _userNameTextField(),
              _passwordTextField(),
              const SizedBox(height: 10.0),
              _signUpRow(),
              const SizedBox(height: 20.0),
              _forgotPassword(),
              const SizedBox(height: 50.0),
              _loginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
