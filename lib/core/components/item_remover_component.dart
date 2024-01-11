import 'package:flutter/material.dart';
import 'package:mashgh/core/components/show_modal_bottom_sheet_component.dart';
import 'package:mashgh/core/utils/value_manager.dart';

class ItemRemoverComponent extends StatelessWidget {
  const ItemRemoverComponent({
    super.key,
    required this.categoryTitle,
    required this.onPressed,
    required this.icon,
    required this.colorIcon,
  });

  final String categoryTitle;
  final void Function() onPressed;
  final IconData? icon;
  final Color? colorIcon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        ShowModalBottomSheetComponent(
          context: context,
          child: SizedBox(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('$categoryTitle حذف شود ؟؟'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FilledButton(
                      onPressed: onPressed,
                      style: FilledButton.styleFrom(
                        foregroundColor: Colors.red,
                        fixedSize: const Size(150, 35),
                        backgroundColor: const Color(0xFFFDF5E5),
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Vazir',
                        ),
                      ),
                      child: const Text(
                        'حذف',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: AppSize.s16,
                        ),
                      ),
                    ),
                    FilledButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: FilledButton.styleFrom(
                        foregroundColor: Colors.deepPurple,
                        fixedSize: const Size(150, 35),
                        backgroundColor: const Color(0xFFFDF5E5),
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Vazir',
                        ),
                      ),
                      child: const Text(
                        'انصراف',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: AppSize.s16,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
      icon: Icon(
        icon,
        color: colorIcon,
      ),
    );
  }
}
