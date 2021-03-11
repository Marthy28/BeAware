import 'package:be_aware/Fragments/HistoryFragment.dart';
import 'package:be_aware/Fragments/HomeFragment.dart';
import 'package:be_aware/Fragments/ProfileFragment.dart';
import 'package:be_aware/Util/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motion_tab_bar/MotionTabBarView.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/motiontabbar.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  MotionTabController _tabController;

  List<Widget> mainFragments;
  List<BuildContext> navStack = [null, null, null];

  var taraTAB = [
    HistoryFragment(),
    HomeFragment(),
    ProfileFragment(),
  ];

  var labels = ["A", "B", "C"];

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    super.initState();
    _tabController =
        MotionTabController(initialIndex: 0, vsync: this, length: 3);

    mainFragments = <Widget>[
      Navigator(onGenerateRoute: (RouteSettings settings) {
        return PageRouteBuilder(pageBuilder: (context, animiX, animiY) {
          navStack[0] = context;
          return taraTAB[0];
        });
      }),
      Navigator(onGenerateRoute: (RouteSettings settings) {
        return PageRouteBuilder(pageBuilder: (context, animiX, animiY) {
          navStack[1] = context;
          return taraTAB[1];
        });
      }),
      Navigator(onGenerateRoute: (RouteSettings settings) {
        return PageRouteBuilder(pageBuilder: (context, animiX, animiY) {
          navStack[2] = context;
          return taraTAB[2];
        });
      }),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Widget build(BuildContext context) {
    //auth.signUp("test@mail.com", "123456", "toto");
    return WillPopScope(
      child: Scaffold(
        bottomNavigationBar: MotionTabBar(
          labels: labels,
          initialSelectedTab: labels[0],
          tabIconColor: Colors.lightBlue,
          tabSelectedColor: Colors.red,
          onTabItemSelected: (int value) {
            setState(() {
              _tabController.index = value;
            });
          },
          icons: [Icons.hourglass_bottom, Icons.home, Icons.account_circle],
          textStyle: TextStyle(color: Colors.transparent),
        ),
        body: MotionTabBarView(
          // callbackOnChange: onChange,
          controller: _tabController,
          children: mainFragments,
        ),
      ),
      onWillPop: () async {
        if (Navigator.of(navStack[_tabController.index]).canPop()) {
          Navigator.of(navStack[_tabController.index]).pop();
          setState(() {
            _tabController.index;
          });
          return false;
        } else {
          if (_tabController.index == 0) {
            setState(() {
              _tabController.index;
            });
            SystemChannels.platform
                .invokeMethod('SystemNavigator.pop'); // close the app
            return true;
          } else {
            _tabController.index =
                0; // back to first tap if current tab history stack is empty
            setState(() {
              _tabController.index;
            });
            return false;
          }
        }
      },
    );
  }
}
