// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:riasin_app/register_page.dart';

void main() {
  runApp(const MainPage());
}

const textColor = Color(0xFF030806);
const backgroundColor = Color(0xFFecf8f5);
const primaryColor = Color(0xFFc55977);
const primaryFgColor = Color(0xFF030806);
const secondaryColor = Color(0xFFd5f0e9);
const secondaryFgColor = Color(0xFF030806);
const accentColor = Color(0xFFb94163);
const accentFgColor = Color(0xFFecf8f5);

const colorScheme = ColorScheme(
  brightness: Brightness.light,
  background: backgroundColor,
  onBackground: textColor,
  primary: primaryColor,
  onPrimary: primaryFgColor,
  secondary: secondaryColor,
  onSecondary: secondaryFgColor,
  tertiary: accentColor,
  onTertiary: accentFgColor,
  surface: backgroundColor,
  onSurface: textColor,
  error: Brightness.light == Brightness.light
      ? Color(0xffB3261E)
      : Color(0xffF2B8B5),
  onError: Brightness.light == Brightness.light
      ? Color(0xffFFFFFF)
      : Color(0xff601410),
);

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Color(0xffC55977)),
            overlayColor: MaterialStateProperty.all<Color>(
                Color.fromARGB(255, 103, 45, 62).withOpacity(0.5)),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
            contentPadding: const EdgeInsets.symmetric(horizontal: 22.0),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(57),
                borderSide:
                    BorderSide(color: Color.fromARGB(102, 197, 89, 120)))),
        colorScheme: colorScheme,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterPage(),
                ));
          },
          child: const Text('Launch screen'),
        ),
      ),
    );
  }
}
