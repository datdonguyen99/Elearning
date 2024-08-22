import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
// import 'package:elearning/widgets/spinner.dart';
import 'package:elearning/widgets/base_button.dart';
import 'package:elearning/extensions/l10n.dart';
import 'package:elearning/utilities/toast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obsecureText = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'login page',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildEmailField(),
                  _buildPasswordField(),
                  const SizedBox(height: 30),
                  _buildLoginButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            return MultiValidator([
              RequiredValidator(errorText: 'Please type email address'),
              EmailValidator(errorText: 'Please correct email filled'),
            ]).call(value);
          },
          decoration: const InputDecoration(
            hintText: 'abc@gmail.com',
            labelText: 'Email',
            prefixIcon: Icon(Icons.email),
            errorStyle: TextStyle(fontSize: 14.0, color: Colors.red),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(9.0)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: TextFormField(
          controller: _passwordController,
          obscureText: _obsecureText,
          validator: (value) {
            return MultiValidator([
              RequiredValidator(errorText: 'Please enter password'),
              MinLengthValidator(6,
                  errorText: 'Password must be at least 6 characters')
            ]).call(value);
          },
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obsecureText = !_obsecureText;
                });
              },
              icon: Icon(
                _obsecureText == true ? Icons.visibility : Icons.visibility_off,
              ),
            ),
            errorStyle: const TextStyle(fontSize: 14.0, color: Colors.red),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(9.0)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
      child: BaseButton(
        title: context.l10n!.login,
        width: MediaQuery.of(context).size.width * 0.85,
        height: 60.0,
        onPress: () {
          if (_formKey.currentState?.validate() ?? false) {
            login(_emailController.text.toString(),
                _passwordController.text.toString());
          }
        },
      ),
    );
  }

  // Widget _buildLoadingWidget() {
  //   return const Center(
  //     child: Padding(
  //       padding: EdgeInsets.all(35),
  //       child: Spinner(),
  //     ),
  //   );
  // }

  void login(String email, String password) async {
    // print('Login button pressed: $email, $password');
    showCustomToast(message: "Test login toast");
  }
}
