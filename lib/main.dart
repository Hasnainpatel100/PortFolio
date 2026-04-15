import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:proftolio/core/theme/app_theme.dart';
import 'package:proftolio/firebase_options.dart';
import 'presentation/bloc/portfolio_bloc.dart';
import 'presentation/bloc/chatbot/chatbot_bloc.dart';
import 'presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Custom error widget to gracefully handle errors in production
  // This prevents the red "Unexpected null value" error from showing
  ErrorWidget.builder = (FlutterErrorDetails details) {
    // Log the error for debugging
    debugPrint('Flutter Error: ${details.exception}');
    debugPrint('Stack trace: ${details.stack}');
    // Return an empty widget instead of the red error screen
    return const SizedBox.shrink();
  };

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Initialize Firebase (optional - comment out if not using Firebase)
  // Uncomment and add your Firebase configuration to use contact form with Firestore
  // await Firebase.initializeApp(
  //   options: const FirebaseOptions(
  //     apiKey: 'YOUR_API_KEY',
  //     appId: 'YOUR_APP_ID',
  //     messagingSenderId: 'YOUR_SENDER_ID',
  //     projectId: 'YOUR_PROJECT_ID',
  //   ),
  // );

  runApp(const MyPortfolioApp());
}

/// Root application widget
class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1080), // Design resolution
      minTextAdapt: true,
      splitScreenMode: true,   
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => PortfolioBloc()),
            BlocProvider(create: (context) => ChatbotBloc()),
          ],
          child: MaterialApp(
            title: 'Hasnain Patel | Flutter & Full Stack Developer',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.darkTheme,
            home: child,
            // You can add routes here if needed
            // routes: {
            //   '/': (context) => const HomePage(),
            // },
          ),
        );
      },
      child: const HomePage(),
    );
  }
}
