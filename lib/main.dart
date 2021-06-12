import 'package:chatbot/data/services/storage/storage_service.dart';
import 'package:chatbot/logic/cubits/auth/auth_cubit.dart';
import 'package:chatbot/presentation/screens/splash/splash_screen.dart';
import 'package:chatbot/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await StorageService.initStorageService();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Chatbot',
        theme: LightTheme.appLightTheme,
        home: SplashScreen(),
      ),
    );
  }
}
