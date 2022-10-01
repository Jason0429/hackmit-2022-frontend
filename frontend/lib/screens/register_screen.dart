import 'package:flutter/material.dart';
import 'package:project/screens/login_screen.dart';
import 'package:project/services/navigation_service.dart';
import 'package:project/utils/routes.dart';
import 'package:project/view_models/login_viewmodel.dart';
import 'package:project/view_models/register_viewmodel.dart';
import 'package:project/widgets/round_button.dart';
import 'package:project/widgets/screen_starter.dart';
import 'package:project/widgets/text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenStarter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: const [
          DisruptLogo(),
          SizedBox(height: 40),
          RegisterForm(),
        ],
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  final _loginVM = LoginViewModel();
  final _registerVM = RegisterViewModel();

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          DisruptTextField(
            controller: _emailController,
            hintText: "Email",
            prefixIcon: const Icon(Icons.email),
            validator: (email) => _loginVM.validateEmail(email),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 10),
          DisruptTextField(
            controller: _passwordController,
            hintText: "Password",
            validator: (password) => _loginVM.validatePassword(password),
            keyboardType: TextInputType.visiblePassword,
            obscureText: !_isPasswordVisible,
            prefixIcon: const Icon(Icons.password),
            suffixIcon: IconButton(
              splashRadius: 15,
              icon: _isPasswordVisible
                  ? const Icon(Icons.remove_red_eye_outlined)
                  : const Icon(Icons.remove_red_eye_rounded),
              iconSize: 20,
              onPressed: () => _togglePasswordVisibility(),
            ),
          ),
          const SizedBox(height: 10),
          DisruptTextField(
            controller: _confirmPasswordController,
            hintText: "Confirm Password",
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            prefixIcon: const Icon(Icons.password),
            validator: (confirmPass) => _registerVM.validateConfirmPassword(
              confirmPass,
              _passwordController.text,
            ),
          ),
          const SizedBox(height: 40),
          DisruptButton(
            onPressed: () {
              String email = _emailController.text.trim();
              String password = _passwordController.text;
              _loginVM.validateThen(
                _formKey,
                () => _registerVM.handleRegister(email, password),
              );
            },
            text: "Register",
            backgroundColor: Colors.blueGrey[900]!,
            textColor: Colors.white,
          ),
          const SizedBox(height: 40),
          const Text("Already have an account?"),
          TextButton(
            onPressed: () {
              NavigationService.pushReplacementNamed(RouteNames.login);
            },
            child: Text(
              "Login",
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.blueGrey[900],
              ),
            ),
            // backgroundColor: Colors.blueGrey[900]!,
            // textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
