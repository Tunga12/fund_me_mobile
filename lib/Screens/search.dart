import 'package:crowd_funding_app/Models/category.dart';
import 'package:crowd_funding_app/Models/donation.dart';
import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Screens/loading_screen.dart';
import 'package:crowd_funding_app/Screens/popular_fundraise_detail.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/services/provider/category.dart';
import 'package:crowd_funding_app/services/provider/fundraise.dart';
import 'package:crowd_funding_app/widgets/authdialog.dart';
import 'package:crowd_funding_app/widgets/campaign_card.dart';
import 'package:crowd_funding_app/widgets/response_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool textFieldIsFocused = true;
  TextEditingController searchController = TextEditingController();

  toggleFocused() {
    setState(
      () {
        textFieldIsFocused = !textFieldIsFocused;
      },
    );
  }

  bool search = false;
  List<Fundraise> searchFundraises = [];
  @override
  Widget build(BuildContext context) {
    print('search $search');
    final size = MediaQuery.of(context).size;
    Response response = context.watch<CategoryModel>().response;
    FocusScopeNode currentFocus = FocusScope.of(context);

    HomeFundraise homeFundraise = context.watch<FundraiseModel>().homeFundraise;
    Response homeResponse = context.watch<FundraiseModel>().response;

    if (response.status == ResponseStatus.CONNECTIONERROR &&
        homeResponse.status == ResponseStatus.CONNECTIONERROR) {
      return ResponseAlert(response.message);
    } else if (response.status == ResponseStatus.LOADING &&
        homeResponse.status == ResponseStatus.LOADING) {
      return LoadingScreen();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: TextField(
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    print("the value is $value");
                    setState(() {
                      searchFundraises = homeFundraise.fundraises!
                          .where((fundraise) => fundraise.title!
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                      search = true;
                    });
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).secondaryHeaderColor,
                            width: 1.0)),
                    suffixIcon: textFieldIsFocused
                        ? IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Theme.of(context).accentColor,
                            ),
                            onPressed: () {
                              if (searchController.text.isNotEmpty) {
                                searchController.clear();
                              } else {
                                toggleFocused();
                                currentFocus.unfocus();
                              }
                            },
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.search,
                              color: Theme.of(context).accentColor,
                            ),
                            onPressed: () {
                              setState(
                                () {
                                  textFieldIsFocused = !textFieldIsFocused;
                                },
                              );
                            },
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
        body: search
            ? searchFundraises.isEmpty
                ? Center(
                    child: Text(
                      "No such fundraise!",
                      style: labelTextStyle.copyWith(
                          color: Theme.of(context).secondaryHeaderColor),
                    ),
                  )
                : Container(
                    color:
                        Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
                    child: ListView.builder(
                        primary: true,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: searchFundraises.length,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () {
                              String id = searchFundraises[index].id!;
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CampaignDetail(
                                    id: id,
                                  ),
                                ),
                              );
                            },
                            child: CampaignCard(
                              image: searchFundraises[index].image!,
                              donation:
                                  searchFundraises[index].donations!.length > 0
                                      ? searchFundraises[index].donations![0]
                                      : Donation(),
                              goalAmount: searchFundraises[index].goalAmount!,
                              locaion: 'location',
                              title: searchFundraises[index].title as String,
                              totalRaised: searchFundraises[index].totalRaised!,
                            ),
                          );
                        }),
                  )
            : SingleChildScrollView(
                primary: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: Text(
                        "Browse GoFundMe",
                        style: titleTextStyle.copyWith(
                            color: Theme.of(context).secondaryHeaderColor),
                      ),
                    ),
                  ],
                ),
              ),
      );
    }
  }
}
