import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mashgh/core/presentation/widgets/modal_floating_action_button_widget.dart';
import 'package:mashgh/core/utils/storage_operator.dart';
import 'package:mashgh/features/feature_document_worksheet/domain/use_cases/factories/document_worksheet_factory.dart';
import 'package:mashgh/features/feature_image_worksheet/presentation/screens/image_worksheet_page.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/bloc/cubits/animate_add_new_category/animate_add_new_category_cubit.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/screens/workspace_managment_page.dart';
import 'package:mashgh/locator.dart';

StorageOperator storageOperator = locator();
const levelScreenStorageKey = 'level_screen';

class MainWrapper extends StatefulWidget {
  static const routeName = "/main_wrapper";

  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final PageController _pageController = PageController(
    initialPage: WorkspaceManagmentPage.page,
  );

  List<Widget> levelScreens = [
    // const SizedBox.shrink(),

    /// workspace managment page
    BlocProvider(
      create: (BuildContext context) => AnimateAddNewCategoryButtonCubit(),
      child: const WorkspaceManagmentPage(),
    ),

    /// image worksheet page
    const ImageWorksheetPage(),

    /// document worksheet page
    const DocumentWorksheetFactory(),
  ];

  @override
  void initState() {
    super.initState();

    // final levelScreenKey = storageOperator.pull(levelScreenStorageKey);

    // levelScreenKey.then(
    //   (levelScreen) async {
    //     if (levelScreen != '') {
    //       int levelScreenNumber = int.parse(levelScreen);
    //       pageController.animateToPage(
    //         levelScreenNumber,
    //         duration: const Duration(milliseconds: 300),
    //         curve: Curves.easeInOut,
    //       );
    //     }
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
      ),
    );

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: ModalFloatingActionButtonWidget(
        pageController: _pageController,
        titleColors: Colors.black87,
        titleFontWeight: FontWeight.bold,
      ),
      // floatingActionButton: AppFloatingActionButton(
      //   distanceBetween: 80.0,
      //   subChildren: [
      //     MaterialButton(
      //       onPressed: () {
      //         pageController.animateToPage(
      //           0,
      //           duration: const Duration(milliseconds: 300),
      //           curve: Curves.easeInOut,
      //         );
      //         storageOperator.push(levelScreenStorageKey, 0.toString());
      //       },
      //       color: Color(0xFFF4C76C),
      //       textColor: Colors.black,
      //       padding: const EdgeInsets.all(16),
      //       shape: const CircleBorder(),
      //       child: const Icon(
      //         Icons.view_list,
      //         size: 20,
      //       ),
      //     ),
      //     MaterialButton(
      //       onPressed: () {
      //         // pageController.animateToPage(
      //         //   0,
      //         //   duration: const Duration(milliseconds: 300),
      //         //   curve: Curves.easeInOut,
      //         // );
      //         // storageOperator.push(levelScreenStorageKey, 0.toString());
      //       },
      //       color: Color(0xFFF4C76C),
      //       textColor: Colors.black,
      //       padding: const EdgeInsets.all(16),
      //       shape: const CircleBorder(),
      //       child: const Icon(
      //         Icons.save,
      //         size: 20,
      //       ),
      //     ),
      //     MaterialButton(
      //       onPressed: () {
      //         // pageController.animateToPage(
      //         //   0,
      //         //   duration: const Duration(milliseconds: 300),
      //         //   curve: Curves.easeInOut,
      //         // );
      //         // storageOperator.push(levelScreenStorageKey, 0.toString());
      //       },
      //       color: Color(0xFFF4C76C),
      //       textColor: Colors.black,
      //       padding: const EdgeInsets.all(16),
      //       shape: const CircleBorder(),
      //       child: const Icon(
      //         Icons.image,
      //         size: 20,
      //       ),
      //     ),
      //     MaterialButton(
      //       onPressed: () {
      //         pageController.animateToPage(
      //           TextWorksheetPage.page,
      //           duration: const Duration(milliseconds: 300),
      //           curve: Curves.easeInOut,
      //         );
      //         storageOperator.push(
      //             levelScreenStorageKey, TextWorksheetPage.page.toString());
      //       },
      //       color: Color(0xFFF4C76C),
      //       textColor: Colors.black,
      //       padding: const EdgeInsets.all(16),
      //       shape: const CircleBorder(),
      //       child: const Icon(
      //         Icons.edit_document,
      //         size: 20,
      //       ),
      //     ),
      //   ],
      // ),
      // floatingActionButton: AppFloatingActionButton(
      //   onPressed: () {
      // Navigator.push(
      //   context,
      //   PageRouteBuilder(
      //     transitionDuration: const Duration(milliseconds: 250),
      //     reverseTransitionDuration: const Duration(milliseconds: 250),
      //     pageBuilder: (context, animation, secondaryAnimation) =>
      //         const AddTodoPage(),
      //     transitionsBuilder:
      //         (context, animation, secondaryAnimation, child) {
      //       animation =
      //           CurvedAnimation(parent: animation, curve: Curves.linear);
      //       return SlideTransition(
      //         position: Tween<Offset>(
      //           begin: const Offset(0, 1),
      //           end: Offset.zero,
      //         ).animate(animation),
      //         child: child,
      //       );
      //     },
      //   ),
      // );
      //   },
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      // bottomNavigationBar: const BottomToolBox(),
      // body: const HomePage(),

      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        // onPageChanged: (int page) {
        //   print("Current page number is $page");
        // },
        children: levelScreens,
      ),
    );
  }

  // Future<void> checkLoged() async {
  //   const sessionKey = 'rise_up_session';
  //   // storageOperator.destroyKey(sessionKey);
  //   final riseUpSession = storageOperator.pull(sessionKey);

  //   riseUpSession.then(
  //     (session) async {
  //       if (session.isEmpty) {
  //         // Navigator.pushNamedAndRemoveUntil(
  //         //   context,
  //         //   LoginPage.routeName,
  //         //   (route) => false,
  //         // );
  //       } else {
  //         // Navigator.pushNamedAndRemoveUntil(
  //         //   context,
  //         //   HomePage.routeName,
  //         //   (route) => false,
  //         // );
  //       }
  //     },
  //   );
  // }
}
