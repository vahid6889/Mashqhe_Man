// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:mashgh/core/components/show_modal_bottom_sheet_component.dart';
import 'package:mashgh/features/feature_document_worksheet/domain/use_cases/factories/document_worksheet_factory.dart';
import 'package:mashgh/features/feature_image_worksheet/presentation/screens/image_worksheet_page.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/screens/workspace_managment_page.dart';

class ModalFloatingActionButtonWidget extends StatelessWidget {
  final PageController pageController;
  final Color titleColors;
  final FontWeight titleFontWeight;
  ModalFloatingActionButtonWidget({
    super.key,
    required this.pageController,
    required this.titleColors,
    required this.titleFontWeight,
  });

  List<Widget>? itemsModalFloatingActionButton;

  @override
  Widget build(BuildContext context) {
    itemsModalFloatingActionButton = [
      TextButton.icon(
        onPressed: () {
          pageController.animateToPage(
            WorksheetManagmentPage.page,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          Navigator.pop(context);
        },
        icon: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(60)),
              child: Container(
                height: 50,
                width: 50,
                // color: Colors.amber,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(40),
                  ),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                    style: BorderStyle.solid,
                  ),
                ),
                child: const Icon(
                  Icons.view_list,
                  color: Colors.green,
                  size: 25,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Worksheets',
              style: TextStyle(
                color: titleColors,
                fontWeight: titleFontWeight,
              ),
            ),
          ],
        ),
        label: const Text(''),
      ),
      TextButton.icon(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(60)),
              child: Container(
                height: 50,
                width: 50,
                // color: Colors.amber,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(40),
                  ),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                    style: BorderStyle.solid,
                  ),
                ),
                child: const Icon(
                  Icons.save,
                  color: Colors.black87,
                  size: 25,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'save',
              style: TextStyle(
                color: titleColors,
                fontWeight: titleFontWeight,
              ),
            ),
          ],
        ),
        label: const Text(''),
      ),
      TextButton.icon(
        onPressed: () {
          pageController.animateToPage(
            ImageWorksheetPage.page,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          Navigator.pop(context);
        },
        icon: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(60)),
              child: Container(
                height: 50,
                width: 50,
                // color: Colors.amber,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(40),
                  ),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                    style: BorderStyle.solid,
                  ),
                ),
                child: const Icon(
                  Icons.image,
                  color: Colors.black87,
                  size: 25,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Photo worksheet',
              style: TextStyle(
                color: titleColors,
                fontWeight: titleFontWeight,
              ),
            ),
          ],
        ),
        label: const Text(''),
      ),
      TextButton.icon(
        onPressed: () {
          pageController.animateToPage(
            DocumentWorksheetFactory.page,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          Navigator.pop(context);
        },
        icon: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(60)),
              child: Container(
                height: 50,
                width: 50,
                // color: Colors.amber,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(40),
                  ),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                    style: BorderStyle.solid,
                  ),
                ),
                child: const Icon(
                  Icons.edit_document,
                  color: Colors.black87,
                  size: 25,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Text worksheet',
              style: TextStyle(
                color: titleColors,
                fontWeight: titleFontWeight,
              ),
            ),
          ],
        ),
        label: const Text(''),
      ),
      TextButton.icon(
        onPressed: () {
          // pageController.animateToPage(
          //   TextWorksheetPage.page,
          //   duration: const Duration(milliseconds: 300),
          //   curve: Curves.easeInOut,
          // );
          Navigator.pop(context);
        },
        icon: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(60)),
              child: Container(
                height: 50,
                width: 50,
                // color: Colors.amber,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(40),
                  ),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                    style: BorderStyle.solid,
                  ),
                ),
                child: const Icon(
                  Icons.disabled_by_default,
                  color: Colors.black87,
                  size: 25,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Default',
              style: TextStyle(
                color: titleColors,
                fontWeight: titleFontWeight,
              ),
            ),
          ],
        ),
        label: const Text(''),
      ),
      TextButton.icon(
        onPressed: () {
          // pageController.animateToPage(
          //   1,
          //   duration: const Duration(milliseconds: 300),
          //   curve: Curves.easeInOut,
          // );
          Navigator.pop(context);
        },
        icon: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(60)),
              child: Container(
                height: 50,
                width: 50,
                // color: Colors.amber,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(40),
                  ),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                    style: BorderStyle.solid,
                  ),
                ),
                child: const Icon(
                  Icons.disabled_by_default,
                  color: Colors.black87,
                  size: 25,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Default',
              style: TextStyle(
                color: titleColors,
                fontWeight: titleFontWeight,
              ),
            ),
          ],
        ),
        label: const Text(''),
      ),
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: 100,
          ),
          child: FloatingActionButton(
            onPressed: () {
              ShowModalBottomSheetComponent(
                context: context,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
                  child: GridView.builder(
                    physics:
                        const NeverScrollableScrollPhysics(), //kill scrollable
                    shrinkWrap: true,
                    itemCount: itemsModalFloatingActionButton!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          itemsModalFloatingActionButton![index],
                        ],
                      );
                    },
                  ),
                ),
              );
              // ModalBottomSheetComponent(
              //   builderInput: Padding(
              //     padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
              //     child: GridView.builder(
              //       physics:
              //           const NeverScrollableScrollPhysics(), //kill scrollable
              //       shrinkWrap: true,
              //       itemCount: itemsModalFloatingActionButton!.length,
              //       gridDelegate:
              //           const SliverGridDelegateWithFixedCrossAxisCount(
              //               crossAxisCount: 3),
              //       itemBuilder: (BuildContext context, int index) {
              //         return Column(
              //           mainAxisSize: MainAxisSize.min,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             itemsModalFloatingActionButton![index],
              //           ],
              //         );
              //       },
              //     ),
              //   ),
              // );
              // showModalBottomSheet(
              //   shape: const RoundedRectangleBorder(
              //     borderRadius: BorderRadius.only(
              //       topLeft: Radius.circular(20.0),
              //       topRight: Radius.circular(20.0),
              //     ),
              //   ),
              //   backgroundColor: Colors.white,
              //   context: context,
              //   builder: (context) {
              //     return Padding(
              //       padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
              //       child: GridView.builder(
              //         physics:
              //             const NeverScrollableScrollPhysics(), //kill scrollable
              //         shrinkWrap: true,
              //         itemCount: itemsModalFloatingActionButton!.length,
              //         gridDelegate:
              //             const SliverGridDelegateWithFixedCrossAxisCount(
              //                 crossAxisCount: 3),
              //         itemBuilder: (BuildContext context, int index) {
              //           return Column(
              //             mainAxisSize: MainAxisSize.min,
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               itemsModalFloatingActionButton![index],
              //             ],
              //           );
              //         },
              //       ),
              //     );
              //   },
              // );
            },
            child: const Icon(
              Icons.settings_accessibility,
            ),
          ),
        ),
      ],
    );
  }
}
