import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pruuu/view_model/picture/picture_view_model.dart';

class PictureWidget extends StatefulWidget {
  final String authorUID;

  PictureWidget(this.authorUID);

  @override
  _PictureWidgetState createState() => _PictureWidgetState();
}

class _PictureWidgetState extends State<PictureWidget> {
  PictureViewModel pictureViewModel = PictureViewModel();

  @override
  void initState() {
    pictureViewModel.fetchPicture(widget.authorUID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).cardColor,
          width: 1.5,
        ),
      ),
      child: Observer(
        builder: (_) {
          if (pictureViewModel.pictureState == PictureState.ready) {
            return ClipOval(
              child: Image.network(
                pictureViewModel.picturePath,
                fit: BoxFit.cover,
              ),
            );
          } else {
            return ClipOval(
              child: Container(
                child: Icon(
                  Icons.person_outline,
                  color: pictureViewModel.pictureState == PictureState.error
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
