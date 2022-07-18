import 'package:flutter/material.dart';
import 'package:joso101/utils/hero_dialog_route.dart';

class PopUpIcon extends StatelessWidget {
  const PopUpIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(HeroDialogRoute(builder: (context) {
            return _PopUpIcon();
          }));
        },
        child: Hero(
          tag: _heroTag,
          createRectTween: (begin, end) {
            return RectTween(begin: begin, end: end);
          },
          child: Material(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: const Icon(
              Icons.print,
              size: 56,
            ),
          ),
        ),
      ),
    );
  }
}

const String _heroTag = 'hero1';

class _PopUpIcon extends StatelessWidget {
  const _PopUpIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Hero(
          tag: _heroTag,
          createRectTween: (begin, end) {
            return RectTween(begin: begin, end: end);
          },
          child: Material(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [Text("data here")],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
