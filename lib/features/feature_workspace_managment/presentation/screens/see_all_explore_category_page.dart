// ignore_for_file: unused_field, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mashgh/core/utils/color_manager.dart';
import 'package:sizer/sizer.dart';

class SeeAllExploreCategoryPage extends StatefulWidget {
  static const routeName = "/see_all_explore_category";

  const SeeAllExploreCategoryPage({super.key});

  @override
  State<SeeAllExploreCategoryPage> createState() =>
      _SeeAllExploreCategoryPageState();
}

class _SeeAllExploreCategoryPageState extends State<SeeAllExploreCategoryPage> {
  final ScrollController _scrollController = ScrollController();
  MaterialColor? _headerAppBarColor;
  bool lastStatus = true;

  bool get isShrink {
    return _scrollController.hasClients && _scrollController.offset > (260);
  }

  void scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    /// get argument from navigator pages
    final Map<String, dynamic>? _args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    // _headerAppBarColor = _args?['categoryColor'] ?? getMaterialColor(Color(selectedColor!));
    _headerAppBarColor = _args?['categoryColor'];

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        body: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              elevation: 0,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    style: ButtonStyle(
                      iconSize: MaterialStateProperty.all(33),
                    ),
                    icon: const Icon(Icons.sort),
                    onPressed: () {},
                  ),
                ),
              ],
              iconTheme: const IconThemeData(
                color: Colors.white, //change your color here
              ),
              stretch: true,
              pinned: true,
              backgroundColor: _headerAppBarColor!.shade900,
              toolbarHeight: 50,
              expandedHeight: 15.h,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [StretchMode.zoomBackground],
                centerTitle: true,
                background: isShrink
                    ? null
                    : Stack(
                        fit: StackFit.expand,
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            left: -70.sp,
                            bottom: 10.sp,
                            child: _circularContainer(
                              38.w,
                              ColorManager.lightGrey.withOpacity(0.1),
                            ),
                          ),
                          Positioned(
                            top: -85.sp,
                            left: -35.sp,
                            child: _circularContainer(
                              40.w,
                              ColorManager.lightGrey.withOpacity(0.1),
                            ),
                          ),
                          Positioned(
                            top: -80.sp,
                            right: -75.sp,
                            child: _circularContainer(
                              70.w,
                              Colors.transparent,
                              borderColor: Colors.white38,
                            ),
                          ),
                          Container(
                            width: size.width,
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.h,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Gap(30),
                                Text(
                                  "نوشتاری",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            SliverAppBar(
              automaticallyImplyLeading: false,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              backgroundColor: _headerAppBarColor!.shade900,
              toolbarHeight: 8.4.h,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 13.sp,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: size.width - 16.w,
                                height: 5.5.h,
                                child: TextField(
                                  cursorColor: ColorManager.darkWhite3,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0.sp,
                                  ),
                                  onTap: () {},
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 1.h,
                                    ),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(60),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: const Color.fromARGB(9, 0, 0, 0),
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.only(left: 4.w),
                                      child: Icon(
                                        Icons.search,
                                        color: ColorManager.white,
                                      ),
                                    ),
                                    hintStyle: TextStyle(
                                      color: ColorManager.white,
                                    ),
                                  ),
                                  keyboardType: TextInputType.name,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 0.5.h,
                                  left: 1.5.w,
                                  bottom: 1.h,
                                ),
                                child: InkWell(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.white,
                                    size: 18.0.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 2000),
                            opacity: isShrink ? 1 : 0,
                            child: const Gap(8),
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 2000),
                            opacity: isShrink ? 1 : 0,
                            child: SizedBox(
                              height: 0.5.h,
                              child: Divider(
                                thickness: 1,
                                color: ColorManager.lightBlack,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(
                    height: size.height,
                    child: GridView.extent(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        left: 10.0,
                        right: 10.0,
                      ),
                      maxCrossAxisExtent: 100.sp, // maximum item width
                      mainAxisSpacing: 5.0.sp, // spacing between rows
                      crossAxisSpacing: 10.0.sp, // spacing between columns
                      childAspectRatio: 0.8,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.3.w,
                              color: ColorManager.greyTwo,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,
                                  left: 8.0,
                                  right: 8.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'درس انار',
                                      style: TextStyle(
                                        color: ColorManager.lightBlack1,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                    Icon(
                                      Icons.more_vert,
                                      color: ColorManager.lightBlack1,
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.folder,
                                size: 85.sp,
                                color: _headerAppBarColor!.shade900,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.3.w,
                                color: ColorManager.greyTwo,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8.0,
                                    left: 8.0,
                                    right: 8.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'درس انار',
                                        style: TextStyle(
                                          color: ColorManager.lightBlack1,
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                      Icon(
                                        Icons.more_vert,
                                        color: ColorManager.lightBlack1,
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.folder,
                                  size: 85.sp,
                                  color: _headerAppBarColor!.shade900,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.3.w,
                                color: ColorManager.greyTwo,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'چند روز پیش',
                                      style: TextStyle(
                                        color: ColorManager.lightBlack1,
                                        fontSize: 7.sp,
                                      ),
                                    ),
                                    Icon(
                                      Icons.more_vert,
                                      color: ColorManager.lightBlack1,
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 25.w,
                                  height: 12.h,
                                  decoration: BoxDecoration(
                                    color: ColorManager.darkWhite5,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Icon(
                                    Icons.insert_drive_file,
                                    size: 40.sp,
                                    color: _headerAppBarColor!.shade900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.3.w,
                                color: ColorManager.greyTwo,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'درس پاییز',
                                      style: TextStyle(
                                        color: ColorManager.lightBlack1,
                                        fontSize: 7.sp,
                                      ),
                                    ),
                                    Icon(
                                      Icons.more_vert,
                                      color: ColorManager.lightBlack1,
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 25.w,
                                  height: 12.h,
                                  decoration: BoxDecoration(
                                    color: ColorManager.darkWhite5,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Icon(
                                    Icons.insert_drive_file,
                                    size: 40.sp,
                                    color: _headerAppBarColor!.shade900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.3.w,
                                color: ColorManager.greyTwo,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'درس پاییز',
                                      style: TextStyle(
                                        color: ColorManager.lightBlack1,
                                        fontSize: 7.sp,
                                      ),
                                    ),
                                    Icon(
                                      Icons.more_vert,
                                      color: ColorManager.lightBlack1,
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 25.w,
                                  height: 12.h,
                                  decoration: BoxDecoration(
                                    color: ColorManager.darkWhite5,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Icon(
                                    Icons.insert_drive_file,
                                    size: 40.sp,
                                    color: _headerAppBarColor!.shade900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // FittedBox(
                        //   child: SizedBox(
                        //     height: 40.h,
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Container(
                        //           width: 67.w,
                        //           padding:
                        //               const EdgeInsets.fromLTRB(16, 10, 0, 20),
                        //           decoration: const BoxDecoration(
                        //             borderRadius: BorderRadius.horizontal(
                        //                 left: Radius.circular(15)),
                        //             color: Color(0xFF024751),
                        //           ),
                        //           child: Column(
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.start,
                        //             children: [
                        //               // Image.asset(Assets.cardsVisaYellow,
                        //               //     width: 60, height: 50, fit: BoxFit.cover),
                        //               Text(
                        //                 'cardsVisaYellow',
                        //                 style: TextStyle(
                        //                   fontSize: 14.sp,
                        //                   color: ColorManager.darkWhite3,
                        //                 ),
                        //               ),
                        //               Text(
                        //                 '\1500.00 DHS',
                        //                 style: TextStyle(
                        //                   fontWeight: FontWeight.bold,
                        //                   fontSize: 22.sp,
                        //                   color: Colors.white,
                        //                 ),
                        //               ),
                        //               // const Gap(20),
                        //               Text(
                        //                 'CARD NUMBER',
                        //                 style: TextStyle(
                        //                   color: Colors.white.withOpacity(0.5),
                        //                   fontSize: 12.sp,
                        //                 ),
                        //               ),
                        //               // const Gap(5),
                        //               Text(
                        //                 '3829 4820 4629 5025',
                        //                 style: TextStyle(
                        //                   color: Colors.white,
                        //                   fontSize: 15.sp,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         Container(
                        //           width: 27.w,
                        //           padding:
                        //               const EdgeInsets.fromLTRB(20, 10, 0, 20),
                        //           decoration: const BoxDecoration(
                        //             borderRadius: BorderRadius.horizontal(
                        //                 right: Radius.circular(15)),
                        //             color: Color(0xFFDFE94B),
                        //           ),
                        //           child: Column(
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.start,
                        //             children: [
                        //               Container(
                        //                 padding: const EdgeInsets.all(10),
                        //                 margin: const EdgeInsets.only(top: 10),
                        //                 decoration: const BoxDecoration(
                        //                   shape: BoxShape.circle,
                        //                   color: Color(0xFF024751),
                        //                 ),
                        //                 child: Icon(
                        //                   Icons.swipe_rounded,
                        //                   color: Colors.white,
                        //                   size: 35.sp,
                        //                 ),
                        //               ),
                        //               const Spacer(),
                        //               Text(
                        //                 'VALID',
                        //                 style: TextStyle(
                        //                   fontSize: 12.sp,
                        //                 ),
                        //               ),
                        //               // const Gap(5),
                        //               Text(
                        //                 '05/22',
                        //                 style: TextStyle(
                        //                   fontSize: 15.sp,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // FittedBox(
                        //   child: SizedBox(
                        //     height: 40.h,
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Container(
                        //           width: 67.w,
                        //           padding:
                        //               const EdgeInsets.fromLTRB(16, 10, 0, 20),
                        //           decoration: const BoxDecoration(
                        //             borderRadius: BorderRadius.horizontal(
                        //                 left: Radius.circular(15)),
                        //             color: Color(0xFF024751),
                        //           ),
                        //           child: Column(
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.start,
                        //             children: [
                        //               // Image.asset(Assets.cardsVisaYellow,
                        //               //     width: 60, height: 50, fit: BoxFit.cover),
                        //               Text(
                        //                 'cardsVisaYellow',
                        //                 style: TextStyle(
                        //                   fontSize: 14.sp,
                        //                   color: ColorManager.darkWhite3,
                        //                 ),
                        //               ),
                        //               Text(
                        //                 '\1500.00 DHS',
                        //                 style: TextStyle(
                        //                   fontWeight: FontWeight.bold,
                        //                   fontSize: 22.sp,
                        //                   color: Colors.white,
                        //                 ),
                        //               ),
                        //               // const Gap(20),
                        //               Text(
                        //                 'CARD NUMBER',
                        //                 style: TextStyle(
                        //                   color: Colors.white.withOpacity(0.5),
                        //                   fontSize: 12.sp,
                        //                 ),
                        //               ),
                        //               // const Gap(5),
                        //               Text(
                        //                 '3829 4820 4629 5025',
                        //                 style: TextStyle(
                        //                   color: Colors.white,
                        //                   fontSize: 15.sp,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         Container(
                        //           width: 27.w,
                        //           padding:
                        //               const EdgeInsets.fromLTRB(20, 10, 0, 20),
                        //           decoration: const BoxDecoration(
                        //             borderRadius: BorderRadius.horizontal(
                        //                 right: Radius.circular(15)),
                        //             color: Color(0xFFDFE94B),
                        //           ),
                        //           child: Column(
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.start,
                        //             children: [
                        //               Container(
                        //                 padding: const EdgeInsets.all(10),
                        //                 margin: const EdgeInsets.only(top: 10),
                        //                 decoration: const BoxDecoration(
                        //                   shape: BoxShape.circle,
                        //                   color: Color(0xFF024751),
                        //                 ),
                        //                 child: Icon(
                        //                   Icons.swipe_rounded,
                        //                   color: Colors.white,
                        //                   size: 35.sp,
                        //                 ),
                        //               ),
                        //               const Spacer(),
                        //               Text(
                        //                 'VALID',
                        //                 style: TextStyle(
                        //                   fontSize: 12.sp,
                        //                 ),
                        //               ),
                        //               // const Gap(5),
                        //               Text(
                        //                 '05/22',
                        //                 style: TextStyle(
                        //                   fontSize: 15.sp,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // FittedBox(
                        //   child: SizedBox(
                        //     height: 40.h,
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Container(
                        //           width: 67.w,
                        //           padding:
                        //               const EdgeInsets.fromLTRB(16, 10, 0, 20),
                        //           decoration: const BoxDecoration(
                        //             borderRadius: BorderRadius.horizontal(
                        //                 left: Radius.circular(15)),
                        //             color: Color(0xFF024751),
                        //           ),
                        //           child: Column(
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.start,
                        //             children: [
                        //               // Image.asset(Assets.cardsVisaYellow,
                        //               //     width: 60, height: 50, fit: BoxFit.cover),
                        //               Text(
                        //                 'cardsVisaYellow',
                        //                 style: TextStyle(
                        //                   fontSize: 14.sp,
                        //                   color: ColorManager.darkWhite3,
                        //                 ),
                        //               ),
                        //               Text(
                        //                 '\1500.00 DHS',
                        //                 style: TextStyle(
                        //                   fontWeight: FontWeight.bold,
                        //                   fontSize: 22.sp,
                        //                   color: Colors.white,
                        //                 ),
                        //               ),
                        //               // const Gap(20),
                        //               Text(
                        //                 'CARD NUMBER',
                        //                 style: TextStyle(
                        //                   color: Colors.white.withOpacity(0.5),
                        //                   fontSize: 12.sp,
                        //                 ),
                        //               ),
                        //               // const Gap(5),
                        //               Text(
                        //                 '3829 4820 4629 5025',
                        //                 style: TextStyle(
                        //                   color: Colors.white,
                        //                   fontSize: 15.sp,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         Container(
                        //           width: 27.w,
                        //           padding:
                        //               const EdgeInsets.fromLTRB(20, 10, 0, 20),
                        //           decoration: const BoxDecoration(
                        //             borderRadius: BorderRadius.horizontal(
                        //                 right: Radius.circular(15)),
                        //             color: Color(0xFFDFE94B),
                        //           ),
                        //           child: Column(
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.start,
                        //             children: [
                        //               Container(
                        //                 padding: const EdgeInsets.all(10),
                        //                 margin: const EdgeInsets.only(top: 10),
                        //                 decoration: const BoxDecoration(
                        //                   shape: BoxShape.circle,
                        //                   color: Color(0xFF024751),
                        //                 ),
                        //                 child: Icon(
                        //                   Icons.swipe_rounded,
                        //                   color: Colors.white,
                        //                   size: 35.sp,
                        //                 ),
                        //               ),
                        //               const Spacer(),
                        //               Text(
                        //                 'VALID',
                        //                 style: TextStyle(
                        //                   fontSize: 12.sp,
                        //                 ),
                        //               ),
                        //               // const Gap(5),
                        //               Text(
                        //                 '05/22',
                        //                 style: TextStyle(
                        //                   fontSize: 15.sp,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // FittedBox(
                        //   child: SizedBox(
                        //     height: 40.h,
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Container(
                        //           width: 67.w,
                        //           padding:
                        //               const EdgeInsets.fromLTRB(16, 10, 0, 20),
                        //           decoration: const BoxDecoration(
                        //             borderRadius: BorderRadius.horizontal(
                        //                 left: Radius.circular(15)),
                        //             color: Color(0xFF024751),
                        //           ),
                        //           child: Column(
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.start,
                        //             children: [
                        //               // Image.asset(Assets.cardsVisaYellow,
                        //               //     width: 60, height: 50, fit: BoxFit.cover),
                        //               Text(
                        //                 'cardsVisaYellow',
                        //                 style: TextStyle(
                        //                   fontSize: 14.sp,
                        //                   color: ColorManager.darkWhite3,
                        //                 ),
                        //               ),
                        //               Text(
                        //                 '\1500.00 DHS',
                        //                 style: TextStyle(
                        //                   fontWeight: FontWeight.bold,
                        //                   fontSize: 22.sp,
                        //                   color: Colors.white,
                        //                 ),
                        //               ),
                        //               // const Gap(20),
                        //               Text(
                        //                 'CARD NUMBER',
                        //                 style: TextStyle(
                        //                   color: Colors.white.withOpacity(0.5),
                        //                   fontSize: 12.sp,
                        //                 ),
                        //               ),
                        //               // const Gap(5),
                        //               Text(
                        //                 '3829 4820 4629 5025',
                        //                 style: TextStyle(
                        //                   color: Colors.white,
                        //                   fontSize: 15.sp,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         Container(
                        //           width: 27.w,
                        //           padding:
                        //               const EdgeInsets.fromLTRB(20, 10, 0, 20),
                        //           decoration: const BoxDecoration(
                        //             borderRadius: BorderRadius.horizontal(
                        //                 right: Radius.circular(15)),
                        //             color: Color(0xFFDFE94B),
                        //           ),
                        //           child: Column(
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.start,
                        //             children: [
                        //               Container(
                        //                 padding: const EdgeInsets.all(10),
                        //                 margin: const EdgeInsets.only(top: 10),
                        //                 decoration: const BoxDecoration(
                        //                   shape: BoxShape.circle,
                        //                   color: Color(0xFF024751),
                        //                 ),
                        //                 child: Icon(
                        //                   Icons.swipe_rounded,
                        //                   color: Colors.white,
                        //                   size: 35.sp,
                        //                 ),
                        //               ),
                        //               const Spacer(),
                        //               Text(
                        //                 'VALID',
                        //                 style: TextStyle(
                        //                   fontSize: 12.sp,
                        //                 ),
                        //               ),
                        //               // const Gap(5),
                        //               Text(
                        //                 '05/22',
                        //                 style: TextStyle(
                        //                   fontSize: 15.sp,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // FittedBox(
                        //   child: SizedBox(
                        //     height: 40.h,
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Container(
                        //           width: 67.w,
                        //           padding:
                        //               const EdgeInsets.fromLTRB(16, 10, 0, 20),
                        //           decoration: const BoxDecoration(
                        //             borderRadius: BorderRadius.horizontal(
                        //                 left: Radius.circular(15)),
                        //             color: Color(0xFF024751),
                        //           ),
                        //           child: Column(
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.start,
                        //             children: [
                        //               // Image.asset(Assets.cardsVisaYellow,
                        //               //     width: 60, height: 50, fit: BoxFit.cover),
                        //               Text(
                        //                 'cardsVisaYellow',
                        //                 style: TextStyle(
                        //                   fontSize: 14.sp,
                        //                   color: ColorManager.darkWhite3,
                        //                 ),
                        //               ),
                        //               Text(
                        //                 '\1500.00 DHS',
                        //                 style: TextStyle(
                        //                   fontWeight: FontWeight.bold,
                        //                   fontSize: 22.sp,
                        //                   color: Colors.white,
                        //                 ),
                        //               ),
                        //               // const Gap(20),
                        //               Text(
                        //                 'CARD NUMBER',
                        //                 style: TextStyle(
                        //                   color: Colors.white.withOpacity(0.5),
                        //                   fontSize: 12.sp,
                        //                 ),
                        //               ),
                        //               // const Gap(5),
                        //               Text(
                        //                 '3829 4820 4629 5025',
                        //                 style: TextStyle(
                        //                   color: Colors.white,
                        //                   fontSize: 15.sp,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         Container(
                        //           width: 27.w,
                        //           padding:
                        //               const EdgeInsets.fromLTRB(20, 10, 0, 20),
                        //           decoration: const BoxDecoration(
                        //             borderRadius: BorderRadius.horizontal(
                        //                 right: Radius.circular(15)),
                        //             color: Color(0xFFDFE94B),
                        //           ),
                        //           child: Column(
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.start,
                        //             children: [
                        //               Container(
                        //                 padding: const EdgeInsets.all(10),
                        //                 margin: const EdgeInsets.only(top: 10),
                        //                 decoration: const BoxDecoration(
                        //                   shape: BoxShape.circle,
                        //                   color: Color(0xFF024751),
                        //                 ),
                        //                 child: Icon(
                        //                   Icons.swipe_rounded,
                        //                   color: Colors.white,
                        //                   size: 35.sp,
                        //                 ),
                        //               ),
                        //               const Spacer(),
                        //               Text(
                        //                 'VALID',
                        //                 style: TextStyle(
                        //                   fontSize: 12.sp,
                        //                 ),
                        //               ),
                        //               // const Gap(5),
                        //               Text(
                        //                 '05/22',
                        //                 style: TextStyle(
                        //                   fontSize: 15.sp,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circularContainer(
    double height,
    Color color, {
    Color borderColor = Colors.transparent,
    double borderWidth = 2,
  }) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }
}
