import 'package:Pruuu/features/feed/bloc/feed_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PictureWidget extends StatelessWidget {
  String authorUID;

  PictureWidget(this.authorUID);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeedBloc>(
      create: (context) => FeedBloc()..add(FetchPicture(authorUID: authorUID)),
      child: _build(context),
    );
  }

  Widget _build(BuildContext contextBloc) {
    return BlocBuilder<FeedBloc, FeedState>(
      builder: (contextBloc, state) {
        if (state is PictureFounded) {
          return _picture(state.picture);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _picture(String picturePath) {
    return picturePath != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(picturePath),
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
          );
  }
}
