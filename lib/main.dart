import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat_app/firebase_options.dart';
import 'package:scholar_chat_app/screens/chat_screen.dart';
import 'package:scholar_chat_app/screens/login_screen.dart';
import 'screens/register_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholarChatApp());
}

class ScholarChatApp extends StatelessWidget {
  const ScholarChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.id : (context) => LoginScreen(),
        SignUpScreen.id : (context) => SignUpScreen(),
        ChatScreen.id : (context) => ChatScreen(),
      },
      initialRoute: LoginScreen.id,
    );
  }
}
