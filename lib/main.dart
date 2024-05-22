import 'package:flutter/material.dart';
import 'package:node/common/widgets/bottom_bar.dart';
import 'package:node/constants/global_variable.dart';
import 'package:node/features/admin/screens/admin_screen.dart';
import 'package:node/features/auth/screens/auth_screen.dart';
import 'package:node/features/auth/services/auth_service.dart';
import 'package:node/providers/user_provider.dart';
import 'package:node/router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    authService.getUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'balle',
        theme: ThemeData(
            scaffoldBackgroundColor: GlobalVariables.backgroundColor,
            appBarTheme: const AppBarTheme(
                elevation: 0, iconTheme: IconThemeData(color: Colors.black)),
            colorScheme: const ColorScheme.light(
              primary: GlobalVariables.secondaryColor,
            )),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: Provider.of<UserProvider>(context).user.token.isNotEmpty
        ?Provider.of<UserProvider>(context).user.type=='user'
            ? const BottomBar():AdminScreen()
            : const AuthScreen());
  }
}
