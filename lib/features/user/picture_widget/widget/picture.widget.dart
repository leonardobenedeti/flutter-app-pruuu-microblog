import 'package:Pruuu/features/user/picture_widget/stores/picture.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
      child: Observer(
        builder: (_) {
          if (pictureStore.pictureState == PictureState.ready) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(pictureStore.picturePath),
            );
          } else {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
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
