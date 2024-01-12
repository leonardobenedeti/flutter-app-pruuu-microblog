import 'package:flutter/material.dart';

class HomePageTabs extends StatefulWidget {
  final List<Tab> tabs;
  final List<Widget> childTabs;

  HomePageTabs({
    required this.tabs,
    required this.childTabs,
  }) : assert(tabs.length == childTabs.length);

  @override
  State<StatefulWidget> createState() {
    return new HomeWidgetState();
  }
}

class HomeWidgetState extends State<HomePageTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
        labelColor: Theme.of(context).textTheme.displayLarge?.color,
        unselectedLabelColor: Theme.of(context).textTheme.displayMedium?.color,
        labelStyle: Theme.of(context).textTheme.displayLarge,
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
