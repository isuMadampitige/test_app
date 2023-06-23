import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:test_app/presentation/states/auth_provider.dart';
import 'package:test_app/presentation/views/Home_screen.dart';
import 'package:test_app/utills/constants.dart';

class MobileSignScreen extends StatefulWidget {
  const MobileSignScreen({super.key});

  @override
  State<MobileSignScreen> createState() => _MobileSignScreenState();
}

class _MobileSignScreenState extends State<MobileSignScreen> {
  TextEditingController mobileController = TextEditingController();

  String mobile = "";
  bool isTyping = false;
  bool emailValidate = false;

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    mobileController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    mobileController.addListener(() {
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
                    left: 10, bottom: 10, top: 10, right: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back, size: 20)),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                    text:
                                        "Thanks Benjamin\nWhat is your Mobile number? ",
                                    style: TextStyle(fontSize: 22)),
                                WidgetSpan(
                                  child: Icon(Icons.phone_android, size: 20),
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
                            mobileController.text.isEmpty
                                ? "Enter your mobile number"
                                : authProvider.validateTextMobile,
                            style: TextStyle(
                                color: authProvider.validateTextColorMobile),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  controller: mobileController,
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
                            if (!mobileController.text.isMobileNumberValid()) {
                              Provider.of<AuthProvider>(context, listen: false)
                                  .setValidateMobile("went wrong");
                              Provider.of<AuthProvider>(context, listen: false)
                                  .setValidateTextColorMobile(Colors.red);
                            } else {
                              Provider.of<AuthProvider>(context, listen: false)
                                  .setValidateMobile("");
                              mobileController.clear();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeScreen()));
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
                  onSaved: (input) => mobile = input!.trim(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
