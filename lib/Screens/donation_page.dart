import 'package:flutter/material.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({Key? key}) : super(key: key);

  @override
  DonationPageState createState() => DonationPageState();
}

class DonationPageState extends State<DonationPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "GoFundMe",
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  width: size.width,
                  child: Image.asset(
                    "assets/images/image1.png",
                    fit: BoxFit.fill,
                    height: size.height * 0.25,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "You're supporiting",
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                            TextSpan(
                              text: " Help Dave Fund",
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "You're supporiting",
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                            TextSpan(
                              text: " Help Dave Fund",
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(
                        thickness: 1.5,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Enter your donation",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      TextField(
                        textAlign: TextAlign.end,
                        keyboardType: TextInputType.number,
                        // cursorHeight: 40.0,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          suffixText: ".00",
                          contentPadding: EdgeInsets.only(
                            top: 10.0,
                            bottom: 10.0,
                            right: 20.0,
                          ),
                          prefixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "\$",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "USD",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Divider(
                        thickness: 1.5,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Tip GoFundMe Services",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        child: Text(
                          'GoFundMe has a 0% platform fee for organizers. GoFundMe will continue offering its services thanks to donors who will leave an option.',
                          style: TextStyle(color: Colors.grey, height: 1.5),
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(flex: 1, child: Text("0%")),
                          Expanded(
                            flex: 10,
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.6),
                                  trackHeight: 4.0,
                                  tickMarkShape: RoundSliderTickMarkShape(),
                                  thumbColor: Theme.of(context).accentColor,
                                  activeTickMarkColor: Colors.white,
                                  inactiveTickMarkColor: Colors.white,
                                  valueIndicatorColor:
                                      Theme.of(context).backgroundColor),
                              child: Slider.adaptive(
                                label: "12%",
                                divisions: 10,
                                min: 0.0,
                                max: 25.0,
                                value: 12.5,
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Text(
                                "25%",
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Paywith",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500),
                      ),
                      PaymentButton(
                        size: size,
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Center(
                        child: Text(
                          "or",
                          style: TextStyle(
                              color: Theme.of(context).secondaryHeaderColor),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Card(
                        elevation: 4.0,
                        color: Colors.white60,
                        child: SizedBox(
                          width: size.width,
                          child: TextButton(
                            style: TextButton.styleFrom(),
                            child: Image.asset(
                              'assets/images/telebirr.png',
                              height: 40.0,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class PaymentButton extends StatelessWidget {
  const PaymentButton({Key? key, required this.size, required this.onPressed})
      : super(key: key);

  final Size size;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      color: Colors.amber,
      child: SizedBox(
        width: size.width,
        child: TextButton(
            onPressed: () {
              onPressed();
            },
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "Pay",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      color: Colors.blue[900]),
                ),
                TextSpan(
                  text: "Pal",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      color: Colors.cyan),
                ),
              ]),
            )),
      ),
    );
  }
}
