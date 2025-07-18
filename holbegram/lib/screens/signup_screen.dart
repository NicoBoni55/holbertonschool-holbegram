import 'package:flutter/material.dart';
import 'package:holbegram/widgets/text_field.dart';


class SignUp extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;
  final bool _passwordVisible;
  const SignUp({
    super.key,
    required this.emailController,
    required this.usernameController,
    required this.passwordController,
    required this.passwordConfirmController,
    bool passwordVisible = true,
    }) : _passwordVisible = passwordVisible;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = widget._passwordVisible;
  }

  @override
  void dispose() {
    super.dispose();
    widget.emailController.dispose();
    widget.usernameController.dispose();
    widget.passwordController.dispose();
    widget.passwordConfirmController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 28),
            Text(
              "Holbegram",
              style: TextStyle(fontFamily: "Billabong", fontSize: 50),
            ),
            Image.asset('assets/images/logo.webp', width: 80, height: 60),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 28),
                  TextFieldInput(
                    controller: widget.emailController, 
                    ispasword: false, 
                    hintText: 'Email', 
                    keyboardType: TextInputType.emailAddress,
                    ),
                  SizedBox(height: 24),
                  TextFieldInput(
                    controller: widget.usernameController, 
                    ispasword: false, 
                    hintText: 'Username', 
                    keyboardType: TextInputType.name,
                    ),
                  SizedBox(height: 24),
                  TextFieldInput(
                    controller: widget.passwordController, 
                    ispasword: !_passwordVisible, 
                    hintText: 'Password', 
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      alignment: Alignment.bottomLeft,
                      onPressed: () => {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        }),
                      }, 
                      icon: Icon(
                        _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off
                      )),
                    ),
                  SizedBox(height: 24),
                  TextFieldInput(
                    controller: widget.passwordConfirmController, 
                    ispasword: !_passwordVisible, 
                    hintText: 'Confirm Password', 
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      alignment: Alignment.bottomLeft,
                      onPressed: () => {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        }),
                      }, 
                      icon: Icon(
                        _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off
                      )),
                    ),
                  SizedBox(height: 28),
                  SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color.fromARGB(218, 226, 37, 24),
                        ),
                      ),
                      onPressed: () => {}, 
                      child: Text(
                        'Sign up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Divider(
                      thickness: 2,
                    ))
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}