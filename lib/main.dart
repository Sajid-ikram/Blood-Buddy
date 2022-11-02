import 'package:blood_buddy/providers/authentication.dart';
import 'package:blood_buddy/providers/donor_provider.dart';
import 'package:blood_buddy/providers/post_provider.dart';
import 'package:blood_buddy/providers/profile_provider.dart';
import 'package:blood_buddy/view/Home/add_post.dart';
import 'package:blood_buddy/view/navigation_bar.dart';
import 'package:blood_buddy/view/profile/edit_profile.dart';
import 'package:blood_buddy/view/profile/map.dart';
import 'package:blood_buddy/view/sign_in_sign_up/forgot_pass.dart';
import 'package:blood_buddy/view/sign_in_sign_up/onboarding.dart';
import 'package:blood_buddy/view/sign_in_sign_up/sign_in.dart';
import 'package:blood_buddy/view/sign_in_sign_up/sign_up.dart';
import 'package:blood_buddy/view/sign_in_sign_up/varification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'constant/constant.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return ScreenUtilInit(
      designSize: const Size(414, 837),
      builder: (context, _) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Authentication()),
          ChangeNotifierProvider(create: (_) => PostProvider()),
          ChangeNotifierProvider(create: (_) => ProfileProvider()),
          ChangeNotifierProvider(create: (_) => DonorProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Blood Buddy',
          theme: ThemeData(
            primarySwatch: Colors.teal,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: FutureBuilder(
            future: _initialization,
            builder: (context, snapshot) {

              if (snapshot.hasError) {
                return const Exception(
                  massage: "Error",
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                return const MiddleOfHomeAndSignIn();
              }

              return const Exception(
                massage: "Loading",
              );
            },
          ),
          routes: {
            // "SignIn": (ctx) => const SignIn(),
            "SignIn": (ctx) => const SignIn(),
            "SignUp": (ctx) => const SignUp(),
            "OnBoarding": (ctx) => const OnBoarding(),
            "MiddleOfHomeAndSignIn": (ctx) => const MiddleOfHomeAndSignIn(),
            "AddNewPostPage": (ctx) => const AddNewPostPage(),
            "EditProfile": (ctx) => const EditProfile(),
            "ForgotPass": (ctx) => const ForgotPass(),
            "MyMap": (ctx) => const MyMap(),
          },
        ),
      ),
    );
  }
}

class Exception extends StatelessWidget {
  const Exception({Key? key, required this.massage}) : super(key: key);
  final String massage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: massage == "Error"
            ? const Text("An error occur")
            : const CircularProgressIndicator(),
      ),
    );
  }
}


class MiddleOfHomeAndSignIn extends StatefulWidget {
  const MiddleOfHomeAndSignIn({Key? key}) : super(key: key);

  @override
  _MiddleOfHomeAndSignInState createState() => _MiddleOfHomeAndSignInState();
}

class _MiddleOfHomeAndSignInState extends State<MiddleOfHomeAndSignIn> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream:
          Provider.of<Authentication>(context, listen: false).authStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: appMainColor),
          );
        }
        if (snapshot.data != null && snapshot.data!.emailVerified) {
          return const CustomNavigationBar();
        }
        return snapshot.data == null
            ? const OnBoarding()
            : const VerificationAndHomeScreen();
      },
    );
  }
}
