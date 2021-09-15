import 'package:crowd_funding_app/Models/donation.dart';
import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Screens/loading_screen.dart';
import 'package:crowd_funding_app/Screens/popular_fundraise_detail.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/services/provider/fundraise.dart';
import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:crowd_funding_app/widgets/campaign_card.dart';
import 'package:crowd_funding_app/widgets/response_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool textFieldIsFocused = true;
  TextEditingController searchController = TextEditingController();
  ScrollController _campaignScrollController = ScrollController();
  Response _response =
      Response(status: ResponseStatus.SUCCESS, data: null, message: '');
  String _searchTitle = '';
  List<Fundraise> _searchedFundraises = [];

  toggleFocused() {
    setState(
      () {
        textFieldIsFocused = !textFieldIsFocused;
      },
    );
  }

  int _pageNumber = 0;

  @override
  void initState() {
    super.initState();
    _campaignScrollController.addListener(() async {
      if (_campaignScrollController.position.pixels ==
          _campaignScrollController.position.maxScrollExtent) {
        _loadMore(_searchTitle, ++_pageNumber);
      }
    });
  }

  bool _bottomLoading = false;

  bool _searching = false;

  _searchFundraises(String title) async {
    setState(() {
      _searching = true;
    });
    await context.read<FundraiseModel>().searchFundraises(title, 0);
    Response response = context.read<FundraiseModel>().response;
    setState(() {
      _searching = false;
      _response = response;
      _searchedFundraises.addAll(response.data.fundraises);
    });
  }

  _loadMore(String title, int page) async {
    setState(() {
      _bottomLoading = true;
    });
    await context.read<FundraiseModel>().searchFundraises(_searchTitle, page);
    Response _response = context.read<FundraiseModel>().response;
    setState(() {
      _searchedFundraises.addAll(_response.data.fundraises);
      _bottomLoading = true;
    });
  }

  bool search = false;

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (_searching) {
      return LoadingScreen();
    } else if (_response.status == ResponseStatus.CONNECTIONERROR) {
      return ResponseAlert(
        _response.message,
        retry: () => _searchFundraises(_searchTitle),
        status: ResponseStatus.CONNECTIONERROR,
      );
    } else if (_response.status == ResponseStatus.SUCCESS) {
      List<Fundraise> searchFundraises = _searchedFundraises;

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
                      search = true;
                      _searchTitle = value;
                    });
                    _searchFundraises(value);
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
                      LocaleKeys.no_such_fundraisre_text.tr(),
                      style: labelTextStyle.copyWith(
                          color: Theme.of(context).secondaryHeaderColor),
                    ),
                  )
                : Container(
                    color:
                        Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
                    child: Scrollbar(
                      controller: _campaignScrollController,
                      isAlwaysShown: true,
                      child: ListView(
                        controller: _campaignScrollController,
                        children: [
                          ListView.builder(
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
                                  fundraiseId: searchFundraises[index].id!,
                                  image: searchFundraises[index].image!,
                                  donation:
                                      searchFundraises[index].donations!.length >
                                              0
                                          ? searchFundraises[index].donations![0]
                                          : Donation(),
                                  goalAmount: searchFundraises[index].goalAmount!,
                                  locaion: 'location',
                                  title: searchFundraises[index].title as String,
                                  totalRaised:
                                      searchFundraises[index].totalRaised!,
                                ),
                              );
                            },
                          ),
                          if (_bottomLoading)
                            Container(
                              color: Theme.of(context).backgroundColor,
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                        ],
                      ),
                    ),
                  )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: Text(
                       LocaleKeys.browse_label_text.tr(),
                        style: titleTextStyle.copyWith(
                            color: Theme.of(context).secondaryHeaderColor),
                      ),
                    ),
                  ],
                ),
              ),
      );
    } else {
      return ResponseAlert(
        _response.message,
        retry: () => _searchFundraises(_searchTitle),
        status: ResponseStatus.MISMATCHERROR,
      );
    }
  }
}
