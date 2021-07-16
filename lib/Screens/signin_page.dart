import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/Screens/signup_page.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign in"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Image.asset(
                "assets/images/gofundme.png",
                height: size.height * 0.07,
                width: size.width * 0.01,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Incorect email or password!";
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
                        return "Incorect Email or Password!";
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
                              .withAlpha(180)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print("Logging...");
                          Navigator.of(context)
                              .pushReplacementNamed('/homepage');
                        }
                      },
                      child: Text(
                        "SIGN IN",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Theme.of(context).backgroundColor),
                      ),
                    ),
                  )
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Forgot your password?',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 1.5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'or',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 20.0),
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 1.5,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: size.width * 0.7,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.facebook,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      "Continue with Facebook",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 17.0, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignupPage()),
                  );
                },
                child: Text(
                  "Don't have an account? Sign up.",
                  style: TextStyle(fontSize: 18.0),
                ))
          ],
        ),
      ),
    );
  }
}
