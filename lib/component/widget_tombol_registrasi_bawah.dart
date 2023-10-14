import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetTombolRegistrasiBawah extends StatelessWidget {
  final Widget nextPage;
  final String nextPageName;
  final String previousPageName;
  final bool useNextArrow;

  const WidgetTombolRegistrasiBawah({
    super.key,
    required this.nextPage,
    required this.nextPageName,
    required this.previousPageName,
    this.useNextArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ButtonStyle(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svg/arrowBack.svg',
                  ),
                  const SizedBox(
                    width: 10,
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
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => nextPage,
                  ));
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(horizontal: 0)),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
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
      ],
    );
  }
}
