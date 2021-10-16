import 'package:drushti/utils/custom_icons_icons.dart';
import 'package:drushti/utils/viewport_size.dart';
import 'package:flutter/widgets.dart';

class ArrowButton extends StatelessWidget {
  const ArrowButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ViewportSize.width - ViewportSize.width * 0.26,
      margin: EdgeInsets.only(
        top: ViewportSize.height * 0.06,
      ),
      alignment: Alignment.centerRight,
      child: Container(
        width: ViewportSize.width * 0.155,
        height: ViewportSize.width * 0.155,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: const Color(0xFFFFFFFF),
          shadows: [
            BoxShadow(
              color: const Color(0x55000000),
              blurRadius: ViewportSize.width * 0.9,
              offset: Offset(3, 3),
            ),
          ],
        ),
        child: Icon(CustomIcons.right_arrow),
      ),
    );
  }
}
