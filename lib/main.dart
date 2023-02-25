import 'package:addrec_employee_management/app/data/constants/api_client.dart';
import 'package:addrec_employee_management/app/data/constants/const.dart';
import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/data/controller/menu_controller.dart';
import 'package:addrec_employee_management/app/data/helper/theme_change_notifier.dart';
import 'package:addrec_employee_management/app/modules/employee-details/controllers/tab_controller.dart';
import 'package:addrec_employee_management/app/modules/home/model/company_model.dart';
import 'package:addrec_employee_management/app/modules/home/model/employee_services_model.dart';
import 'package:addrec_employee_management/app/modules/home/model/family_details_model.dart';
import 'package:addrec_employee_management/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/modules/home/model/check_box_model.dart';
import 'app/routes/app_pages.dart';

import 'package:http/http.dart' as http;

// final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
var isLogin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences pref = await SharedPreferences.getInstance();
  isLogin = (pref.getBool('login') == null) ? false : pref.getBool('login');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await _flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
  Get.put(MenuController());
  Get.put(MyTabController());
  // Get.put(HomeController());

  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    // asyncMethod();a
    if (isLogin) {
      asynchronousMethod();
    }
    super.initState();
  }

  asyncMethod() async {
    await getLoginData();
  }

  getLoginData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      isLogin = pref.getBool('login') ?? false;
      print(pref.getString('accessToken'));
      print(pref.getString('deviceToken'));
    });
  }

  void asynchronousMethod() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if ((pref.getInt('counter') ?? 0) == 0) {
      pref.setBool('login', false);
    } else {
      pref.setBool('login', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    // getLoginData();

    return ChangeNotifierProvider(
      create: (_) => ThemeChangeNotifier(),
      child: Consumer<ThemeChangeNotifier>(
        builder: (context, value, child) {
          // fsyncMethod() async {
          //   print(value.isDarkMode.toString() + 'darkMode');
          //   if (value.isDarkMode) {
          //     setState(() {
          //       colorPrimary = Color(0xFFF3ECE6);
          //       colorPrimaryDark = Color(0xFFF3ECE6);
          //       colorPrimaryLight = Color(0xFFF3ECE6);
          //       colorBackground = Color(0xFF343740);
          //       white = Color(0xFF343740);
          //       black = Color(0xFFF3ECE6);
          //     });
          //   }
          // }

          return FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
              var data = snapshot.data;
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                if (data!.getBool('login') ?? false) {
                  print(data.getBool('login')!);
                  print('home');
                  return GetMaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: "Application",
                    defaultTransition: Transition.rightToLeft,
                    initialRoute: Routes.HOME,
                    getPages: AppPages.routes,
                  );
                } else {
                  print('login');
                  return GetMaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: "Application",
                    defaultTransition: Transition.rightToLeft,
                    initialRoute: '/',
                    getPages: AppPages.routes,
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
            },
          );
        },
      ),
    );
  }
}
