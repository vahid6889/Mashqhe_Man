import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mashgh/core/config/my_theme.dart';
import 'package:mashgh/core/presentation/ui/main_wrapper.dart';
import 'package:mashgh/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  /// init locator
  await setup();

  runApp(
    const MyApp(),
    // MultiBlocProvider(
    //   providers: [
    //     // BlocProvider(create: (_) => ThemeBloc()..add(ThemeSetInitialEvent())),
    //     // BlocProvider(create: (_) => LanguageBloc()..add(GetLanguage())),
    //     // BlocProvider(
    //     //     create: (_) => ChoiceChipBloc()..add(ChoiceChipInitialEvent())),
    //     // BlocProvider(create: (_) => FormBloc()..add(ObscureTextInitialEvent())),
    //     // BlocProvider(
    //     //     create: (_) => UserProfileBloc()..add(UserProfileInitialEvent())),
    //     // BlocProvider(
    //     //     create: (_) => locator<HomeBloc>()..add(LoadTopMarketCapEvent())),
    //     // BlocProvider(create: (_) => locator<MarketBloc>()),
    //     // BlocProvider(create: (_) => locator<ProfileBloc>()),
    //   ],
    //   child: const MyApp(),
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyThemes.lightTheme,
      debugShowCheckedModeBanner: false,
      title: "Todo AppWrite",
      home: const MainWrapper(),
      // home: FutureBuilder<bool>(
      //   future: prefsOperator.getLoggedIn("LoggedIn"),
      //   builder: (context, AsyncSnapshot<bool> snapshot) {
      //     if (snapshot.hasData) {
      //       return Directionality(
      //         textDirection: TextDirection.ltr,
      //         child: snapshot.data == true
      //             ? MainWrapper()
      //             : const SignUpScreen(),
      //       );
      //     } else {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),
      // initialRoute: "/",
      routes: {
        // SignUpPage.routeName: (context) => const SignUpPage(),
        // LoginPage.routeName: (context) => const LoginPage(),
        // MainWrapper.routeName: (context) => const MainWrapper(),
        // HomePage.routeName: (context) => const HomePage(),
        // AddTodoPage.routeName: (context) => const AddTodoPage(),
      },
    );
  }
}
