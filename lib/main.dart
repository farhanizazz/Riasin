import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:riasin_app/Url.dart';
import 'package:riasin_app/layout/login_pages/splash_screen.dart';
import 'package:riasin_app/layout/register_pages/client/register_page.dart';
import 'package:riasin_app/providers/form_data_provider.dart';
import 'package:dio/dio.dart' as dio;
import 'package:riasin_app/layout/mua/dashboard_mua.dart';
import 'package:riasin_app/layout/client/dashboard_client.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => FormData())],
      child: MaterialApp(
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
          fontFamily: GoogleFonts.poppins().fontFamily,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xffC55977)),
              overlayColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 103, 45, 62).withOpacity(0.5)),
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
              hintStyle: const TextStyle(height: 2),
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.w600, color: Color(0x1B090E61)),
              alignLabelWithHint: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 2),
              floatingLabelStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
              focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red[900]!, width: 4)),
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red[900]!, width: 4)),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 197, 89, 120), width: 4)),
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(102, 197, 89, 120), width: 4))),
          colorScheme: colorScheme,
          textTheme: const TextTheme(
            titleMedium: TextStyle(color: Color(0xffC55977), fontSize: 20),
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _storage = const FlutterSecureStorage();

  final Dio = dio.Dio();

  Future<dio.Response<String>> getUser() async {
    return await Dio.get('$baseUrl/api/profile',
        options: dio.Options(
            headers: {'Authorization': 'Bearer ${await _checkToken()}'}));
  }

  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(seconds: 1), () async {
      String? token = await _checkToken();
      if (token != null) {
        try {
          dio.Response user = await getUser();
          int idRole = jsonDecode(user.data)['data']['role_id'];
          switch (idRole) {
            case 3:
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DashboardClient(
                            token: token,
                          )));
              break;
            case 2:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => DashboardMua()));
              break;
          }
        } on dio.DioException catch (e) {
          _storage.delete(key: 'token');
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const RegisterPage()));
        }

        return;
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const RegisterPage()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(resizeToAvoidBottomInset: false, body: SplashScreen()
        // body: DetailMua(idMua: 1,),
        // body: DashboardMua(),
        // body: RegisterPageDataJasa(),
        );
  }

  Future<String?> _checkToken() async {
    return await _storage.read(key: 'token');
  }
}
