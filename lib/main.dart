import 'package:etrick/providers/theme_provider.dart';
import 'package:etrick/services/app_router.dart';
import 'package:etrick/services/auth_service.dart';
import 'package:etrick/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (_) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (_) => AppThemeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ValueListenable<User?> userChanges;
  @override
  void initState() {
    final authService = context.read<AuthService>();
    authService.initialize();
    userChanges =
        authService.authStateChanges.toValueNotifier(authService.user);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = AppRouter(userChanges).router;
    return Consumer<AppThemeProvider>(
      builder: (context, value, child) => MaterialApp.router(
        title: Constants.appName,
        theme: AppTheme.lightTheme,
        routeInformationProvider: router.routeInformationProvider,
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

extension StreamExtensions<T> on Stream<T> {
  ValueListenable<T> toValueNotifier(
    T initialValue, {
    bool Function(T previous, T current)? notifyWhen,
  }) {
    final notifier = ValueNotifier<T>(initialValue);
    listen((value) {
      if (notifyWhen == null || notifyWhen(notifier.value, value)) {
        notifier.value = value;
      }
    });
    return notifier;
  }

  Listenable toListenable() {
    final notifier = ChangeNotifier();
    listen((_) {
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      notifier.notifyListeners();
    });
    return notifier;
  }
}
