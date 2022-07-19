import 'package:flutter/material.dart';
import 'package:joso101/map/accident_class.dart';
import 'package:joso101/utils/hero_dialog_route.dart';

class PopUpIcon extends StatelessWidget {
  const PopUpIcon({required this.accident, required this.herotag});

  final Accident accident;
  final String herotag;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(HeroDialogRoute(builder: (context) {
          return _PopUpIcon(
            acc: accident,
            herotag: herotag,
          );
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Hero(
          tag: herotag,
          createRectTween: (begin, end) {
            return RectTween(begin: begin, end: end);
          },
          child: const Icon(
            Icons.location_on,
            size: 56,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

class _PopUpIcon extends StatelessWidget {
  const _PopUpIcon({required this.acc, required this.herotag});

  final String herotag;
  final Accident acc;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Hero(
          tag: herotag,
          createRectTween: (begin, end) {
            return RectTween(begin: begin, end: end);
          },
          child: Material(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(acc.email),
                      Text(acc.cause),
                      Text(acc.death.toString()),
                      Text(acc.injured.toString()),
                      Text(acc.accDate.toDate().toString()),
                      acc.expwStep != null
                          ? Text(acc.expwStep.toString())
                          : const Text("")
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
