import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mashgh/core/blocs/cubits/toolbar_component_cubit.dart';
import 'package:mashgh/core/blocs/form_bloc/form_bloc.dart';
import 'package:mashgh/core/config/my_theme.dart';
import 'package:mashgh/core/presentation/ui/main_wrapper.dart';
import 'package:mashgh/core/utils/storage_operator.dart';
import 'package:mashgh/features/feature_auth/presentation/bloc/authentication/auth_bloc.dart';
import 'package:mashgh/features/feature_auth/presentation/cubits/count_down_time_otp_cubit.dart';
import 'package:mashgh/features/feature_auth/presentation/cubits/input_chip_cubit.dart';
import 'package:mashgh/features/feature_auth/presentation/screens/identity_form_page.dart';
import 'package:mashgh/features/feature_auth/presentation/screens/login_otp_page.dart';
import 'package:mashgh/features/feature_auth/presentation/screens/verification_otp_page.dart';
import 'package:mashgh/features/feature_document_worksheet/domain/use_cases/factories/document_worksheet_factory.dart';
import 'package:mashgh/features/feature_document_worksheet/presentation/bloc/toolbar/shapes/circle/circle_bloc.dart';
import 'package:mashgh/features/feature_document_worksheet/presentation/bloc/worksheet/document/document_bloc.dart';
import 'package:mashgh/features/feature_image_worksheet/presentation/screens/image_worksheet_page.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/bloc/cubits/categories/category_color_cubit.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/bloc/cubits/categories/category_icon_cubit.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/bloc/workspace/categories_bloc/category_bloc.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/bloc/workspace/worksheets_bloc/workspace_worksheet_bloc.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/screens/see_all_explore_category_page.dart';
import 'package:mashgh/locator.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  /// init locator
  await setup();

  runApp(
    // const MyApp(),
    MultiBlocProvider(
      providers: [
        /// blocs
        BlocProvider(create: (_) => FormBloc()..add(ObscureTextInitialEvent())),
        BlocProvider(create: (_) => locator<AuthBloc>()),

        BlocProvider(create: (_) => locator<WorkspaceWorksheetBloc>()),
        BlocProvider(create: (_) => locator<CategoryBloc>()),
        BlocProvider(create: (_) => locator<CircleBloc>()),
        BlocProvider(create: (_) => locator<DocumentBloc>()),

        /// cubits
        BlocProvider(create: (_) => ToolbarComponentCubit()),
        BlocProvider(create: (_) => ChangeCategoryIconCubit()),
        BlocProvider(create: (_) => ChangeCategoryColorCubit()),
        BlocProvider(create: (_) => ResendTimeOtpCubit()),
        BlocProvider(create: (_) => InputChipCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

StorageOperator storageOperator = locator();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: MyThemes.lightTheme,
          debugShowCheckedModeBanner: false,
          title: "Mashqh",
          home: FutureBuilder<dynamic>(
            future: storageOperator
                .pull("riseUpAuthentication")
                .then((value) => value),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data == 'true'
                    ? const MainWrapper()
                    : const LoginOtpPage();
                // return Directionality(
                //   textDirection: TextDirection.ltr,
                //   child: snapshot.data == true
                //       ? MainWrapper()
                //       : const SignUpScreen(),
                // );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          initialRoute: "/",
          routes: {
            MainWrapper.routeName: (context) => const MainWrapper(),
            DocumentWorksheetFactory.routeName: (context) =>
                const DocumentWorksheetFactory(),
            ImageWorksheetPage.routeName: (context) =>
                const ImageWorksheetPage(),
            SeeAllExploreCategoryPage.routeName: (context) =>
                const SeeAllExploreCategoryPage(),
            VerificationOtpPage.routeName: (context) =>
                const VerificationOtpPage(),
            LoginOtpPage.routeName: (context) => const LoginOtpPage(),
            IdentityFormPage.routeName: (context) => const IdentityFormPage(),
            // HomePage.routeName: (context) => const HomePage(),
          },
        );
      },
    );
  }
}
