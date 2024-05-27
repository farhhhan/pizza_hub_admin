import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizza_hut_admin/add_pizza.dart';
import 'package:pizza_hut_admin/bloc/indexbloc/slidebar_bloc.dart';
import 'package:pizza_hut_admin/custom_appBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPageScreen extends StatefulWidget {
  MainPageScreen({Key? key}) : super(key: key);

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  SharedPreferences? pref;
  String? username;

  @override
  void initState() {
    super.initState();
    initial();
  }

  initial() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      username = pref!.getString("email");
    });
  }

  List<Widget> pages = [
    AddPizzaScreen(),  // Placeholder for Dashboard page
    AddPizzaScreen(),
    AddPizzaScreen(),  // Placeholder for Bookings page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(450, 50),
        child: AppBarWidget(username: username, pref: pref),
      ),
      body: CollapsibleSidebar(
        iconSize: 20,
        backgroundColor: Color.fromARGB(255, 219, 231, 249),
        selectedTextColor: Color.fromARGB(255, 0, 0, 0),
        unselectedTextColor: Colors.grey,
        textStyle: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
        titleStyle: const TextStyle(
          fontSize: 20,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
        ),
        toggleTitleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        sidebarBoxShadow: const [],
        collapseOnBodyTap: false,
        itemPadding: 10,
        selectedIconBox: const Color.fromARGB(255, 255, 255, 255),
        selectedIconColor: Colors.blue,
        showTitle: false,
        items: [
          CollapsibleItem(
            isSelected: true,
            text: "Dashboard",
            icon: Icons.dashboard,
            onPressed: () {
              BlocProvider.of<SlidebarBloc>(context).add(SlidebarChangeEvent(index: 0));
            },
          ),
          CollapsibleItem(
            text: "Add Pizza",
            icon: Icons.add_circle_outline,
            onPressed: () {
              BlocProvider.of<SlidebarBloc>(context).add(SlidebarChangeEvent(index: 1));
            },
          ),
          CollapsibleItem(
            text: "Bookings",
            icon: FontAwesomeIcons.calendarWeek,
            onPressed: () {
              BlocProvider.of<SlidebarBloc>(context).add(SlidebarChangeEvent(index: 2));
            },
          ),
        ],
        body: BlocBuilder<SlidebarBloc, SlidebarState>(
          builder: (context, state) {
            if (state is SlidebarSuccessState) {
              return pages[state.index];
            }
            return pages[0];
          },
        ),
      ),
    );
  }
}
