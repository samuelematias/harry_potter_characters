import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    @required this.tooltipMessage,
    this.onTap,
    Key key,
  }) : super(key: key);

  final String tooltipMessage;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltipMessage,
      child: InkWell(
        onTap: onTap,
        child: const Icon(Icons.favorite),
      ),
    );
  }
}
