import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sablon/providers/user_provider.dart';
import 'package:sablon/services/firebase_auth_services.dart';
import 'package:sablon/view/splashscreen.dart';

// import 'DBfirebase/firebase_auth_services.dart';
// import 'Page/SplashScreen.dart';
// import 'Page/dashboard.dart';
// import 'Provider/user_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(value: FirebaseAuthServices.userStream),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Nyablon Apps",
        home: SplashScreen(),
      ),
    );
  }
}
