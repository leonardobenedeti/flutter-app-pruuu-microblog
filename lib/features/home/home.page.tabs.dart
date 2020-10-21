import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
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
        labelColor: Theme.of(context).textTheme.headline1.color,
        unselectedLabelColor: Theme.of(context).textTheme.headline2.color,
        labelStyle: Theme.of(context).textTheme.headline1,
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
