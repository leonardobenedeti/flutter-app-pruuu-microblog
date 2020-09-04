import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<Pruuu> pruuus = [];

  @override
  void initState() {
    pruuus.addAll([
      new Pruuu(
        id: "djiajiasi",
        content:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut non nunc vitae tellus molestie eleifend. Praesent feugiat sapien erat, ut aliquet ante varius in. Duis aliquam tincidunt nunc, elementum bibendum eros commodo aliquet. Nulla facilisi. Interdum et malesuada fames ac orci.",
        timestamp: DateTime.now().subtract(Duration(days: 2)),
        user: new User(
          id: "xpto",
          username: "leonardobenedeti",
          email: "leonardobenedeti@gmail.com",
          nome: "Leonardo Benedeti",
          picturePath:
              "https://leonardobenedeti.github.io/assets/img/foto-perfil.png",
        ),
      ),
      new Pruuu(
        id: "djiajiasi",
        content: "Desafio aceito.",
        timestamp: DateTime.now(),
        user: new User(
          id: "xpto",
          username: "leonardobenedeti",
          email: "leonardobenedeti@gmail.com",
          nome: "Flutter dev",
          picturePath: null,
        ),
      )
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: 20,
        padding: EdgeInsets.only(bottom: 70),
        itemBuilder: (context, position) {
          return _pruuu(pruuus[position % 2 > 0 ? 0 : 1]);
        },
      ),
    );
  }

  Widget _pruuu(Pruuu pruuu) {
    DateTime now = DateTime.now().subtract(Duration(days: 1));
    var format = pruuu.timestamp.isAfter(now)
        ? DateFormat('HH:mm')
        : DateFormat('dd/MM/yy');
    String timeStamp = format.format(pruuu.timestamp);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.only(right: 10),
                child: pruuu.user.picturePath != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(pruuu.user.picturePath),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          child: Icon(
                            Icons.person_outline,
                            color: Colors.white,
                          ),
                          color: Colors.black,
                        ),
                      ),
              ),
              Container(
                width: constraints.maxWidth * .8,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          pruuu.user.nome,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          timeStamp,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    Bubble(
                      margin: BubbleEdges.only(top: 10),
                      alignment: Alignment.topLeft,
                      nip: BubbleNip.leftTop,
                      child: Text(pruuu.content),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class Pruuu {
  Pruuu(
      {@required this.id,
      @required this.timestamp,
      @required this.content,
      @required this.user});

  String id;
  DateTime timestamp;
  String content;
  User user;
}

class User {
  User(
      {@required this.id,
      @required this.email,
      @required this.nome,
      @required this.username,
      @required this.picturePath});

  String id;
  String email;
  String nome;
  String username;
  String picturePath;
}
