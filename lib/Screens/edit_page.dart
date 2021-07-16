import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit",
        ),
        actions: [TextButton(onPressed: () {}, child: Text('SAVE'))],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    child: Image.asset(
                      "assets/images/image1.png",
                      height: size.height * 0.35,
                      width: size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      bottom: 10.0,
                      right: 20.0,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.black.withOpacity(0.2)),
                        child: Text("Change Cover",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {},
                      ))
                ],
              ),
              Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 1.0,
                                  blurRadius: 1.0,
                                  offset: Offset(0, 3))
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 20.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Campaign Overview",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              TextFormField(
                                onChanged: (value) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Title required!";
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: "Title",
                                ),
                              ),
                              SizedBox(
                                height: 18.0,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                onChanged: (value) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Goal Amount required!";
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: "Goal Ammount",
                                ),
                              ),
                              SizedBox(
                                height: 18.0,
                              ),
                              TextFormField(
                                maxLines: 3,
                                onChanged: (value) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Story required!";
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: "Story ",
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 1.0,
                                  blurRadius: 1.0,
                                  offset: Offset(0, 3))
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 20.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Campaign Details",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              TextFormField(
                                maxLines: 2,
                                onChanged: (value) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Campaign Link required!";
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: "Campaign Link",
                                ),
                              ),
                              SizedBox(
                                height: 18.0,
                              ),
                              DropdownButtonFormField<String>(
                                items: [
                                  DropdownMenuItem<String>(
                                    value: "1",
                                    child: Text(
                                      "Creative arts",
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "2",
                                    child: Text(
                                      "Travel and Adventure",
                                    ),
                                  )
                                ],
                                onChanged: (value) {},
                                validator: (value) {},
                                decoration: InputDecoration(
                                  labelText: "Category",
                                ),
                              ),
                              SizedBox(
                                height: 18.0,
                              ),
                              TextFormField(
                                onChanged: (value) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Story required!";
                                  }
                                },
                                decoration: InputDecoration(
                                  prefix: Icon(Icons.search),
                                  suffix: Icon(
                                    Icons.location_on,
                                    color: Colors.black,
                                  ),
                                  labelText: "Location",
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                "Campaign created on 07/14/2021",
                                style: Theme.of(context).textTheme.bodyText1,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 1.0,
                        blurRadius: 1.0,
                        offset: Offset(0, 3))
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Team",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "Fundraise with a team will display their name(s) on your campaign page, allow them to thank donors and keep them updated.",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(height: 1.5),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 1.0,
                        blurRadius: 1.0,
                        offset: Offset(0, 3))
                  ],
                ),
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fundraise Settings",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    FundraiseSettingItem(
                      title: 'Allow donors to leave comments on my fundraiser.',
                    ),
                    FundraiseSettingItem(
                      title: "Allow donations to my fundraiser",
                    ),
                    FundraiseSettingItem(
                      title: "Allow my fundraiser to appear in search results",
                    ),
                    Text(
                      "Your fundraiser will appear in GoFundMe search results and other online search engines (if this is turned off people will still be able to view your fundraiser if you have the link). ",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              CustomCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Team",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "You will no longer have access to this fundraiser after deleting. People who donated to your fundraiser will still be able to view a summary. For more information visit our",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 15.0),
                          ),
                          TextSpan(
                            text: " help center",
                            recognizer: TapGestureRecognizer()..onTap = () {},
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      width: size.width,
                      height: 50.0,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                                width: 1.5, color: Colors.red.shade900),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Delete fundraiser",
                          style: TextStyle(
                            color: Colors.red.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  Widget child;
  CustomCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1.0,
              blurRadius: 1.0,
              offset: Offset(0, 3))
        ],
      ),
      padding: EdgeInsets.all(20.0),
      child: child,
    );
  }
}

class FundraiseSettingItem extends StatelessWidget {
  String title;

  FundraiseSettingItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$title',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Switch.adaptive(value: true, onChanged: (value) {}),
        ],
      ),
    );
  }
}
