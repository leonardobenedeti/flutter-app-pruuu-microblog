import 'package:Pruuu/feed/feed.page.dart';
import 'package:flutter/material.dart';

class UserWidget extends StatefulWidget {
  @override
  _UserWidgetState createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  User user;

  @override
  void initState() {
    user = new User(
      id: "xpto",
      username: "leonardobenedeti",
      email: "leonardobenedeti@gmail.com",
      nome: "Leonardo Benedeti",
      picturePath:
          "https://leonardobenedeti.github.io/assets/img/foto-perfil.png",
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Usuário conectado",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FlatButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 80,
                width: 80,
                child: user.picturePath != null
                    ? ClipOval(
                        child: Image.network(user.picturePath),
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
              SizedBox(
                width: 16,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.nome,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    Text("@${user.username}"),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          FlatButton(
            child: Text(
              "Sair do app",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () => Navigator.pop(context),
            textColor: Colors.red,
          )
        ],
      ),
    );
  }
}
