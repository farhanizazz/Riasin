import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetTombolRegistrasiBawah extends StatelessWidget {
  final Function() nextPageOnTap;
  final String nextPageName;
  final String previousPageName;
  final bool useNextArrow;
  final bool usePrevButton;

  const WidgetTombolRegistrasiBawah({
    super.key,
    required this.nextPageOnTap,
    required this.nextPageName,
    required this.previousPageName,
    this.useNextArrow = true,
    this.usePrevButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
      usePrevButton ? Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.all(0)),
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xffD5F0E9)),
              overlayColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 145, 163, 159)),
              minimumSize:
                  MaterialStateProperty.all<Size>(const Size.fromHeight(60)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              elevation: MaterialStateProperty.all<double>(0.0),
              shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/arrowBack.svg',
                    ),
                    Text(previousPageName,
                        style: const TextStyle(
                          color: Color(0xff030806),
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ): const SizedBox(),
        SizedBox(
          width: usePrevButton ? 20 : 0,
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              nextPageOnTap();
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.all(0)),
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xffC55977)),
              minimumSize:
                  MaterialStateProperty.all<Size>(const Size.fromHeight(60)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              elevation: MaterialStateProperty.all<double>(0.0),
              shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: Row(
                mainAxisAlignment: usePrevButton ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                children: [
                  Text(nextPageName,
                      style: const TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w500,
                      )),
                  useNextArrow
                      ? Row(
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            SvgPicture.asset(
                              'assets/svg/arrowNext.svg',
                            ),
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
