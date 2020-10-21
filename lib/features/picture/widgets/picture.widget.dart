import 'package:Pruuu/features/picture/stores/picture.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

// ignore: must_be_immutable
class PictureWidget extends StatefulWidget {
  String authorUID;

  PictureWidget(this.authorUID);

  @override
  _PictureWidgetState createState() => _PictureWidgetState();
}

class _PictureWidgetState extends State<PictureWidget> {
  PictureStore pictureStore = PictureStore();

  @override
  void initState() {
    pictureStore.fetchPicture(widget.authorUID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).accentColor,
          width: 1.5,
        ),
      ),
      child: Observer(
        builder: (_) {
          if (pictureStore.pictureState == PictureState.ready) {
            return ClipOval(
              child: Image.network(
                pictureStore.picturePath,
                fit: BoxFit.cover,
              ),
            );
          } else {
            return ClipOval(
              child: Container(
                child: Icon(
                  Icons.person_outline,
                  color: pictureStore.pictureState == PictureState.error
                      ? Colors.grey
                      : Colors.white,
                ),
                color: Colors.black,
              ),
            );
          }
        },
      ),
    );
  }
}