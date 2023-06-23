import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:test_app/presentation/states/auth_provider.dart';
import 'package:test_app/presentation/views/mobile_sign.dart';
import 'package:test_app/utills/constants.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String email = "";
  bool isTyping = false;
  bool emailValidate = false;

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    emailController.addListener(() {
      setState(() {
        isTyping = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, bottom: 10, top: 10, right: 20),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                    text:
                                        "Nice to meet you benjamin\nWhat is your Email? ",
                                    style: TextStyle(fontSize: 22)),
                                WidgetSpan(
                                  child: Icon(Icons.email, size: 22),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: isTyping,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Lottie.asset(
                            'assets/icons/10357-chat-typing-indicator.json',
                            width: 70,
                            height: 70),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, bottom: 10, top: 10, right: 20),
                  child: Row(
                    children: [
                      Consumer<AuthProvider>(
                        builder: (context, authProvider, _) {
                          return Text(
                            emailController.text.isEmpty
                                ? "Enter your email address"
                                : authProvider.validateText,
                            style: TextStyle(
                                color: authProvider.validateTextColor),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  controller: emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    fillColor: Colors.blue,
                    suffixIcon: Container(
                      margin: const EdgeInsets.all(2),
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 1, color: Colors.white)),
                      child: IconButton(
                          onPressed: () async {
                            if (!emailController.text.isValidEmail()) {
                              Provider.of<AuthProvider>(context, listen: false)
                                  .setValidateEmail("went wrong");
                              Provider.of<AuthProvider>(context, listen: false)
                                  .setValidateTextColor(Colors.red);
                            } else {
                              Provider.of<AuthProvider>(context, listen: false)
                                  .setValidateEmail("");
                              emailController.clear();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MobileSignScreen()));
                            }
                          },
                          icon: const Icon(Icons.navigation_rounded)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black12,
                        width: 1.0,
                      ),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.redAccent,
                        width: 1.0,
                      ),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.redAccent,
                        width: 1.0,
                      ),
                    ),
                  ),
                  onSaved: (input) => email = input!.trim(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
