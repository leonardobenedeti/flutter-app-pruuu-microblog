import 'package:Pruuu/feed/feed.page.dart';
import 'package:Pruuu/trending/trending.page.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _controller = PageController(
    initialPage: 0,
  );

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        _pagesHome(),
        _bottomButtons(),
      ],
    ));
  }

  Widget _bottomButtons() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FlatButton(
            color: Colors.black87,
            textColor: Colors.white,
            child: Text(
              _currentPage == 0 ? "Trending" : "Feed",
            ),
            onPressed: () {
              setState(() => _currentPage = _currentPage == 0 ? 1 : 0);
              _controller.animateToPage(_currentPage,
                  duration: Duration(milliseconds: 250), curve: Curves.linear);
            },
          ),
          FloatingActionButton(
            onPressed: () => _openBottomSheet(),
            child: Icon(Icons.ac_unit),
          )
        ],
      ),
    );
  }

  Widget _pagesHome() {
    return PageView(
      onPageChanged: (currentPage) =>
          setState(() => _currentPage = currentPage),
      physics: ClampingScrollPhysics(),
      controller: _controller,
      children: [
        FeedPage(),
        TrendingPage(),
      ],
    );
  }

  _openBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Container();
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
