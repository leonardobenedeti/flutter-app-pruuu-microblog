import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePageTabs extends StatefulWidget {
  List<Tab> tabs;
  List<Widget> childTabs;

  HomePageTabs({
    @required this.tabs,
    @required this.childTabs,
  }) : assert(tabs.length == childTabs.length);

  @override
  State<StatefulWidget> createState() {
    return new HomeWidgetState();
  }
}

class HomeWidgetState extends State<HomePageTabs>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: widget.tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new TabBar(
        isScrollable: true,
        unselectedLabelColor: Colors.grey,
        labelColor: Colors.black,
        labelStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(),
        tabs: widget.tabs,
        controller: _tabController,
      ),
      body: new TabBarView(
        controller: _tabController,
        children: widget.childTabs.map((Widget tabChild) {
          return tabChild;
        }).toList(),
      ),
    );
  }
}
