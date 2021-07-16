import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Image.asset(
                "assets/images/gofundme.png",
                height: size.height * 0.07,
                width: size.width * 0.01,
              ),
            ),
            Text(
              "Great job!",
              style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
              "Now create an account to preview and launch your fundraiser.",
              style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: 10.0,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "First name is required!";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "First name",
                    ),
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  TextFormField(
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Last name is required!";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Last name",
                    ),
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  TextFormField(
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email is required!";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Email",
                    ),
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  TextFormField(
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Phone number is required!";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Phone number",
                    ),
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  TextFormField(
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password is required!";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                    ),
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  SizedBox(
                    width: size.width,
                    height: size.height * 0.08,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context)
                            .secondaryHeaderColor
                            .withAlpha(180),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print("Logging...");
                        }
                      },
                      child: Text(
                        "SIGN UP",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.grey.shade600),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 18.0),
              child: Center(
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                      text: "Sign in",
                      style: TextStyle(color: Theme.of(context).accentColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SignupPage(),
                            ),
                          );
                        })
                ])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
