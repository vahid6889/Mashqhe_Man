// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_element

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mashgh/core/components/item_remover_component.dart';
import 'package:mashgh/core/components/show_modal_bottom_sheet_component.dart';
import 'package:mashgh/core/config/appbar/colors.dart';
import 'package:mashgh/core/data/entities/category_entity.dart';
import 'package:mashgh/core/data/entities/worksheet_entity.dart';
import 'package:mashgh/core/params/category_params.dart';
import 'package:mashgh/core/params/shape_params.dart';
import 'package:mashgh/core/params/worksheet_params.dart';
import 'package:mashgh/core/usecase/use_case.dart';
import 'package:mashgh/core/utils/color_manager.dart';
import 'package:mashgh/core/utils/constants.dart';
import 'package:mashgh/core/utils/storage_operator.dart';
import 'package:mashgh/core/utils/value_manager.dart';
import 'package:mashgh/features/feature_document_worksheet/domain/use_cases/factories/document_worksheet_factory.dart';
import 'package:mashgh/features/feature_document_worksheet/presentation/bloc/toolbar/shapes/circle/circle_bloc.dart';
import 'package:mashgh/features/feature_image_worksheet/presentation/screens/image_worksheet_page.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/bloc/cubits/animate_add_new_category/animate_add_new_category_cubit.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/bloc/cubits/categories/category_color_cubit.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/bloc/cubits/categories/category_icon_cubit.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/bloc/workspace/categories_bloc/category_bloc.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/bloc/workspace/categories_bloc/create_category_status.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/bloc/workspace/categories_bloc/delete_category_status.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/bloc/workspace/categories_bloc/get_all_category_status.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/bloc/workspace/categories_bloc/update_category_status.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/bloc/workspace/worksheets_bloc/delete_worksheet_status.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/bloc/workspace/worksheets_bloc/get_all_worksheet_status.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/bloc/workspace/worksheets_bloc/workspace_worksheet_bloc.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/utils/constants.dart';
import 'package:mashgh/locator.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'dart:math' as math;

StorageOperator storageOperator = locator();

class WorksheetManagmentPage extends StatefulWidget {
  static const routeName = "/worksheet_managment";
  static int page = 0;
  const WorksheetManagmentPage({super.key});

  @override
  State<WorksheetManagmentPage> createState() => _WorksheetManagmentPageState();
}

class _WorksheetManagmentPageState extends State<WorksheetManagmentPage> {
  ScrollController? scrollController;
  final TextEditingController _textEditingController = TextEditingController();

  bool get isShrink {
    return scrollController != null &&
        scrollController!.hasClients &&
        scrollController!.offset > (AppSize.s260);
  }

  void scrollListener() {
    bool lastStatus =
        BlocProvider.of<AnimateAddNewCategoryButtonCubit>(context).lastStatus;
    if (isShrink != lastStatus) {
      BlocProvider.of<AnimateAddNewCategoryButtonCubit>(context)
          .changeScrollListener(isShrink);
    }
  }

  void initialCategory() async {
    // storageOperator.destroyKey('initialCategory');
    final initialCategoryStatus = await storageOperator.pull('initialCategory');

    if (initialCategoryStatus == null || initialCategoryStatus == '') {
      CategoryParams categoryParams = CategoryParams(
        name: '',
        nameFa: 'ریاضی',
        color: Colors.pink.value,
        icon: Icons.menu_book_rounded.codePoint,
      );
      BlocProvider.of<CategoryBloc>(context).add(
        CreateCategoryEvent(categoryParams),
      );
      storageOperator.push('initialCategory', '1');
    }
  }

  @override
  void initState() {
    super.initState();
    initialCategory();
    BlocProvider.of<CategoryBloc>(context).add(GetAllCategoryEvent());
    scrollController = ScrollController();
    scrollController = ScrollController()..addListener(scrollListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<ChangeCategoryColorCubit>(context).isChangeColor = false;

    /// get all temp document
    WorksheetParams getTempDocument = WorksheetParams(
      categoryId: null,
    );
    BlocProvider.of<WorkspaceWorksheetBloc>(context)
        .add(GetAllWorksheetEvent(getTempDocument));
  }

  @override
  void dispose() {
    scrollController?.removeListener(scrollListener);
    scrollController?.dispose();
    _textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarBackgroundColor,
        leading: Icon(
          Icons.menu,
          color: appBarIconMenuColor,
        ),
      ),
      extendBody: true,
      body: _buildBody(
          width: width, height: height, textController: _textEditingController),
    );
  }

  Stack _buildBody({width, height, textController}) {
    return Stack(
      children: [
        CustomScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              toolbarHeight: AppSize.s60,
              pinned: true,
              flexibleSpace: Padding(
                padding: const EdgeInsets.all(AppPadding.p12),
                child: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Stack(
                    children: [
                      BlocBuilder<AnimateAddNewCategoryButtonCubit, bool>(
                        builder: (context, stateIsShrink) {
                          BlocProvider.of<AnimateAddNewCategoryButtonCubit>(
                                  context)
                              .lastStatus = stateIsShrink;
                          return AnimatedPositioned(
                            duration: const Duration(
                                milliseconds: DurationConstant.d1000),
                            right:
                                stateIsShrink ? (width / 4 - 84.5) : AppSize.s0,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: _taskHeader(
                                textController: textController,
                                height: height,
                              ),
                            ),
                          );
                        },
                      ),

                      /// linear progress indicator to loading add new category
                      BlocConsumer<CategoryBloc, CategoryState>(
                        listenWhen: (previous, current) {
                          if (current.createCategoryStatus ==
                              previous.createCategoryStatus) {
                            return false;
                          }
                          return true;
                        },
                        buildWhen: (previous, current) {
                          if (current.createCategoryStatus ==
                              previous.createCategoryStatus) {
                            return false;
                          }
                          return true;
                        },
                        listener: (context, state) {
                          if (state.createCategoryStatus
                              is CreateCategoryCompleted) {
                            NoParams noParams = NoParams();
                            BlocProvider.of<CategoryBloc>(context)
                                .add(CreateCategoryInitialEvent(noParams));
                            BlocProvider.of<CategoryBloc>(context)
                                .add(GetAllCategoryEvent());
                          }
                          if (state.createCategoryStatus
                              is CreateCategoryError) {
                            final CreateCategoryError createCategoryError =
                                state.createCategoryStatus
                                    as CreateCategoryError;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    createCategoryError.message.toString()),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state.createCategoryStatus
                              is CreateCategoryLoading) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: SizedBox(
                                    width: width * 0.6,
                                    child: const LinearProgressIndicator(
                                      color: Colors.orange,
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          return Container();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<WorkspaceWorksheetBloc, WorksheetState>(
                        buildWhen: (previous, current) {
                          if (current.getAllWorksheetStatus ==
                              previous.getAllWorksheetStatus) {
                            return false;
                          }
                          return true;
                        },
                        builder: (context, state) {
                          if (state.getAllWorksheetStatus
                              is GetAllWorksheetCompleted) {
                            /// cast data
                            final GetAllWorksheetCompleted
                                _getAllWorksheetCompleted =
                                state.getAllWorksheetStatus
                                    as GetAllWorksheetCompleted;

                            final List<WorksheetEntity?> _worksheeTempEntity =
                                _getAllWorksheetCompleted.worksheetEntity;

                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: _tempDocumentList(
                                  _worksheeTempEntity,
                                  context,
                                ),
                              ),
                            );
                          }

                          return Container();
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: buildGrid(height),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      _onGoingHeader(),
                      const SizedBox(
                        height: 10,
                      ),
                      OnGoingTask(),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ],
    );
  }

  Row _onGoingHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "On Going",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {},
          child: const Text(
            "See all",
            style: TextStyle(
              // color: AppColors.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }

  Row _taskHeader({textController, height}) {
    final _formKey = GlobalKey<FormState>();
    return Row(
      children: [
        IconButton(
          onPressed: () {
            ShowModalBottomSheetComponent(
              context: context,
              child: SizedBox(
                height: height * 0.2,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: textController..text = '',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return null;
                          }
                          Navigator.pop(context);
                          return null;
                        },
                        autofocus: true,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Vazir',
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      FilledButton.icon(
                        icon: const Icon(Icons.add, size: 18),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            List<IconData> iconsCategoryList =
                                iconsCategory.values.toList();
                            IconData iconSelect = iconsCategoryList[
                                Random().nextInt(iconsCategoryList.length)];
                            CategoryParams categoryParams = CategoryParams(
                              name: '',
                              nameFa: textController.text,
                              color: Color(
                                (math.Random().nextDouble() * 0xFFFFFF).toInt(),
                              ).value,
                              icon: iconSelect.codePoint,
                            );
                            BlocProvider.of<CategoryBloc>(context)
                                .add(CreateCategoryEvent(categoryParams));
                            // BlocProvider.of<CategoryBloc>(context)
                            //     .categoryList = categoryParams.toJson();
                            textController.text = '';
                          }
                        },
                        style: FilledButton.styleFrom(
                          foregroundColor: Colors.deepPurple,
                          fixedSize: const Size(300, 35),
                          backgroundColor: const Color(0xFFFDF5E5),
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Vazir',
                          ),
                        ),
                        label: const Text('ایجاد پوشه جدید'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          icon: Icon(
            Icons.add_circle_outline,
            color: Colors.blue[400],
          ),
        ),
        SelectableText(
          "پوشه جدید",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: AppSize.s20,
          ),
        ),
      ],
    );
  }

  MaterialColor getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(color.value, shades);
  }

  buildGrid(height) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      buildWhen: (previous, current) {
        if (current.getAllCategoryStatus == previous.getAllCategoryStatus) {
          return false;
        }
        return true;
      },
      builder: (context, state) {
        if (state.getAllCategoryStatus is GetAllCategoryLoading) {
          return const CircularProgressIndicator.adaptive(
            strokeWidth: 0.3,
          );
        }
        if (state.getAllCategoryStatus is GetAllCategoryCompleted) {
          /// cast data
          final GetAllCategoryCompleted getAllCategoryCompleted =
              state.getAllCategoryStatus as GetAllCategoryCompleted;

          final List<CategoryEntity> categoryEntity =
              getAllCategoryCompleted.categoryEntity;

          return StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            children: _categoryStaggeredGridTileList(
              categoryEntity,
              height,
            ),
          );
        }
        if (state.getAllCategoryStatus is GetAllCategoryError) {}

        return Container();
      },
    );
  }

  List<Widget> _categoryStaggeredGridTileList(
      List<CategoryEntity> categories, double height) {
    final _formKey = GlobalKey<FormState>();
    List<StaggeredGridTile> listStaggerGridTile = [];
    Map<int, Map<String, int>> categoryList =
        BlocProvider.of<CategoryBloc>(context).categoryList;
    int categoryId = 0;

    for (int i = 0; i < categories.length; i++) {
      categoryList[categories[i].id!] = {
        'icon': categories[i].icon!,
        'color': categories[i].color!,
      };
      Color categoryColor = Color(categories[i].color!);
      IconData categoryIcon = IconData(
        categories[i].icon!,
        fontFamily: 'MaterialIcons',
      );

      int cellEditingCount = i + 1;
      listStaggerGridTile.add(
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: cellEditingCount % 2 == 0 ? 1 : 1.3,
          child: GestureDetector(
            onLongPress: () {
              categoryId = categories[i].id!;

              BlocProvider.of<ChangeCategoryIconCubit>(context).isChangeIcon =
                  false;
              BlocProvider.of<ChangeCategoryColorCubit>(context).isChangeColor =
                  false;

              ShowModalBottomSheetComponent(
                context: context,
                child: SizedBox(
                  height: 250,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          controller: _textEditingController
                            ..text = categories[i].nameFa!,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return null;
                            }
                            Navigator.pop(context);
                            return null;
                          },
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Vazir',
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 15.0,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFDDE8FD),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 7.5,
                                      horizontal: 10.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFB5CCFA),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        ShowModalBottomSheetComponent(
                                          context: context,
                                          child: IconPicker(
                                            onIconPicked: (icon) {
                                              BlocProvider.of<
                                                          ChangeCategoryIconCubit>(
                                                      context)
                                                  .changeCategoryIcon(
                                                IconData(
                                                  icon.codePoint,
                                                  fontFamily: 'MaterialIcons',
                                                ),
                                              );
                                              BlocProvider.of<
                                                          ChangeCategoryIconCubit>(
                                                      context)
                                                  .isChangeIcon = true;

                                              categoryList[categories[i].id]![
                                                  'icon'] = icon.codePoint;
                                            },
                                          ),
                                        );
                                      },
                                      icon: BlocBuilder<ChangeCategoryIconCubit,
                                          IconData>(
                                        builder: (context, stateIconData) {
                                          bool statusIconState = BlocProvider
                                                  .of<ChangeCategoryIconCubit>(
                                                      context)
                                              .isChangeIcon;

                                          int? listCategoryIcon = categoryList[
                                              categories[i].id]!['icon'];

                                          return Icon(
                                            statusIconState
                                                ? stateIconData
                                                : listCategoryIcon !=
                                                        categoryIcon.codePoint
                                                    ? IconData(
                                                        listCategoryIcon!,
                                                        fontFamily:
                                                            'MaterialIcons',
                                                      )
                                                    : categoryIcon,
                                            color: const Color(0xFF3541F1),
                                            size: AppSize.s24,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 18.0),
                                    child: Text(
                                      'تغییر آیکون',
                                      style: TextStyle(
                                        fontSize: AppSize.s12,
                                        color: Color(0xFF525458),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 15.0,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFCEFF6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15.5,
                                      horizontal: 5.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF9D9E8),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: BlocBuilder<ChangeCategoryColorCubit,
                                        Color>(
                                      builder: (context, stateColorData) {
                                        bool statusColorState = BlocProvider.of<
                                                    ChangeCategoryColorCubit>(
                                                context)
                                            .isChangeColor;

                                        int? listCategoryColor = categoryList[
                                            categories[i].id]!['color'];

                                        return ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: getMaterialColor(
                                                    statusColorState
                                                        ? stateColorData
                                                        : listCategoryColor !=
                                                                categoryColor
                                                                    .value
                                                            ? Color(
                                                                listCategoryColor!)
                                                            : categoryColor)
                                                .withOpacity(1),
                                            padding: const EdgeInsets.all(2.0),
                                            shape: const CircleBorder(),
                                          ),
                                          onPressed: () {
                                            ShowModalBottomSheetComponent(
                                              context: context,
                                              child: ColorPicker(
                                                onColorSelected: (color) {
                                                  BlocProvider.of<
                                                              ChangeCategoryColorCubit>(
                                                          context)
                                                      .changeCategoryColor(
                                                          color);
                                                  BlocProvider.of<
                                                              ChangeCategoryColorCubit>(
                                                          context)
                                                      .isChangeColor = true;

                                                  categoryList[categories[i]
                                                          .id]!['color'] =
                                                      color.value;
                                                },
                                              ),
                                            );
                                          },
                                          child: Container(),
                                        );
                                      },
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 18.0),
                                    child: Text(
                                      'تغییر رنگ',
                                      style: TextStyle(
                                        fontSize: AppSize.s12,
                                        color: Color(0xFF525458),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        FilledButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              CategoryParams categoryParams = CategoryParams(
                                id: categories[i].id,
                                name: '',
                                nameFa: _textEditingController.text,
                                color: BlocProvider.of<
                                            ChangeCategoryColorCubit>(context)
                                        .isChangeColor
                                    ? BlocProvider.of<ChangeCategoryColorCubit>(
                                            context)
                                        .selectedColor
                                    : categories[i].color,
                                icon: BlocProvider.of<
                                            ChangeCategoryIconCubit>(context)
                                        .isChangeIcon
                                    ? BlocProvider.of<ChangeCategoryIconCubit>(
                                            context)
                                        .selectedIcon
                                    : categories[i].icon,
                              );
                              BlocProvider.of<CategoryBloc>(context)
                                  .add(UpdateCategoryEvent(categoryParams));

                              _textEditingController.text = '';
                            }
                          },
                          style: FilledButton.styleFrom(
                            foregroundColor: Colors.deepPurple,
                            fixedSize: const Size(300, 35),
                            backgroundColor: const Color(0xFFFDF5E5),
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Vazir',
                            ),
                          ),
                          child: const Text('اعمال تغییرات'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            child: BlocBuilder<CategoryBloc, CategoryState>(
              buildWhen: (previous, current) {
                if (current.updateCategoryStatus ==
                        previous.updateCategoryStatus ||
                    categoryId != categories[i].id) {
                  return false;
                }
                return true;
              },
              builder: (context, state) {
                if (state.updateCategoryStatus is UpdateCategoryLoading) {}
                if (state.updateCategoryStatus is UpdateCategoryCompleted) {
                  NoParams noParams = NoParams();
                  BlocProvider.of<CategoryBloc>(context)
                      .add(UpdateCategoryInitialEvent(noParams));

                  int? selectedColor =
                      BlocProvider.of<ChangeCategoryColorCubit>(context)
                              .isChangeColor
                          ? BlocProvider.of<ChangeCategoryColorCubit>(context)
                              .selectedColor
                          : categories[i].color;

                  int? selectedIcon =
                      BlocProvider.of<ChangeCategoryIconCubit>(context)
                              .isChangeIcon
                          ? BlocProvider.of<ChangeCategoryIconCubit>(context)
                              .selectedIcon
                          : categories[i].icon;

                  return TaskGroupContainer(
                    categoryTitle: categories[i].nameFa!,
                    categoryId: categories[i].id!,
                    color: getMaterialColor(Color(selectedColor!)),
                    icon: IconData(selectedIcon!, fontFamily: 'MaterialIcons'),
                    isSmall: cellEditingCount % 2 == 0 ? true : false,
                    taskCount: categories[i].worksheetsCount != null
                        ? categories[i]
                            .worksheetsCount
                            .toString()
                            .toPersianDigit()
                        : '0'.toPersianDigit(),
                    taskGroup: categories[i].nameFa!,
                  );
                }
                if (state.updateCategoryStatus is UpdateCategoryError) {}

                int? selectedColor =
                    BlocProvider.of<ChangeCategoryColorCubit>(context)
                            .isChangeColor
                        ? BlocProvider.of<ChangeCategoryColorCubit>(context)
                            .selectedColor
                        : categories[i].color;

                int? selectedIcon =
                    BlocProvider.of<ChangeCategoryIconCubit>(context)
                            .isChangeIcon
                        ? BlocProvider.of<ChangeCategoryIconCubit>(context)
                            .selectedIcon
                        : categories[i].icon;

                return TaskGroupContainer(
                  key: ValueKey(categories[i].id),
                  categoryTitle: categories[i].nameFa!,
                  categoryId: categories[i].id!,
                  color: getMaterialColor(Color(selectedColor!)),
                  icon: IconData(selectedIcon!, fontFamily: 'MaterialIcons'),
                  isSmall: cellEditingCount % 2 == 0 ? true : false,
                  taskCount: categories[i].worksheetsCount != null
                      ? categories[i]
                          .worksheetsCount
                          .toString()
                          .toPersianDigit()
                      : '0'.toPersianDigit(),
                  taskGroup: categories[i].nameFa!,
                );
              },
            ),
          ),
        ),
      );
      // cellEditingCount++;
    }
    return listStaggerGridTile;
  }

  List<Widget> _tempDocumentList(
      List<WorksheetEntity?> _worksheeTempEntity, BuildContext context) {
    List<Widget> tempList = [];
    int loopCount = 0;

    for (var _worksheetTemp in _worksheeTempEntity) {
      DateTime dateTimeWorksheetTemp =
          DateTime.fromMillisecondsSinceEpoch(_worksheetTemp!.date!);
      String creationTempDocument =
          dateTimeWorksheetTemp.getDifferenceDateString();

      tempList.add(
        Expanded(
          child: InkWell(
            onTap: () {
              /// get worksheet by id
              WorksheetParams getTempDocument = WorksheetParams(
                id: _worksheetTemp.id,
              );
              BlocProvider.of<WorkspaceWorksheetBloc>(context)
                  .add(GetWorksheetByIdEvent(getTempDocument));

              if (_worksheetTemp.worksheetType ==
                  WorksheetEntity.TYPE_WORKSHEET_DOCUMENT) {
                eventHandler(
                  context,
                  _worksheetTemp.uniqueId!,
                  DocumentWorksheetFactory.routeName,
                );

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  DocumentWorksheetFactory.routeName,
                  ModalRoute.withName(DocumentWorksheetFactory.routeName),
                  arguments: {
                    'navigationMethod': 'pushNamedAndRemoveUntil',
                    'documentUniqueId': _worksheetTemp.uniqueId,
                    'documentId': _worksheetTemp.id,
                    'documentDate': _worksheetTemp.date,
                  },
                );
              } else if (_worksheetTemp.worksheetType ==
                  WorksheetEntity.TYPE_WORKSHEET_IMAGE) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  ImageWorksheetPage.routeName,
                  ModalRoute.withName(ImageWorksheetPage.routeName),
                  arguments: {
                    'navigationMethod': 'pushNamedAndRemoveUntil',
                    'documentUniqueId': _worksheetTemp.uniqueId,
                    'documentId': _worksheetTemp.id,
                    'documentDate': _worksheetTemp.date,
                  },
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 5.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFDDE8FD),
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                height: 45,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color(0xFFDDE8FD),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFB5CCFA),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: BlocConsumer<WorkspaceWorksheetBloc, WorksheetState>(
                      listenWhen: (previous, current) {
                        if (current.deleteWorksheetStatus ==
                            previous.deleteWorksheetStatus) {
                          return false;
                        }

                        return current.deleteWorksheetStatus
                                is DeleteWorksheetCompleted &&
                            (current.deleteWorksheetStatus
                                        as DeleteWorksheetCompleted)
                                    .worksheetId ==
                                _worksheetTemp.id;
                      },
                      buildWhen: (previous, current) {
                        if (current.deleteWorksheetStatus ==
                            previous.deleteWorksheetStatus) {
                          return false;
                        }

                        return current.deleteWorksheetStatus
                                is DeleteWorksheetCompleted &&
                            (current.deleteWorksheetStatus
                                        as DeleteWorksheetCompleted)
                                    .worksheetId ==
                                _worksheetTemp.id;
                      },
                      listener: (context, state) {
                        if (state.deleteWorksheetStatus
                            is DeleteWorksheetCompleted) {
                          /// get all temp document
                          WorksheetParams getTempDocument = WorksheetParams(
                            categoryId: null,
                          );
                          BlocProvider.of<WorkspaceWorksheetBloc>(context)
                              .add(GetAllWorksheetEvent(getTempDocument));
                        }
                      },
                      builder: (context, state) {
                        if (state.deleteWorksheetStatus
                            is DeleteWorksheetLoading) {
                          return const CircularProgressIndicator.adaptive(
                            strokeWidth: 0.3,
                          );
                        }
                        if (state.deleteWorksheetStatus
                            is DeleteWorksheetCompleted) {
                          /// set initial temporary get all worksheet and delete event
                          NoParams noParams = NoParams();

                          BlocProvider.of<WorkspaceWorksheetBloc>(context)
                              .add(DeleteWorksheetInitialEvent(noParams));
                        }
                        if (state.deleteWorksheetStatus
                            is DeleteWorksheetError) {}

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ItemRemoverComponent(
                              categoryTitle: 'پیش نویس',
                              onPressed: () {
                                /// delete temporary worksheet by id
                                BlocProvider.of<WorkspaceWorksheetBloc>(context)
                                    .add(
                                  DeleteWorksheetEvent(_worksheetTemp.id!),
                                );
                                Navigator.of(context).pop();
                              },
                              icon: Icons.delete,
                              colorIcon: const Color(0xFF3541F1),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'پیش نویس',
                                  style: TextStyle(
                                    fontSize: AppSize.s14,
                                    color: Color(0xFF525458),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    const Icon(
                                      Icons.notifications_on_outlined,
                                      color: Color(0xFF3541F1),
                                      size: AppSize.s18,
                                    ),
                                    Padding(
                                      /// resize normal all temporary width space
                                      padding: creationTempDocument
                                                  .split(' ')
                                                  .length >
                                              1
                                          ? const EdgeInsets.all(0)
                                          : EdgeInsets.only(
                                              right: creationTempDocument.length
                                                      .toDouble() *
                                                  5.5),
                                      child: Text(
                                        creationTempDocument,
                                        style: const TextStyle(
                                          fontSize: AppSize.s8,
                                          color: Color(0xFF525458),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      if (_worksheeTempEntity.length == 2 && loopCount == 0) {
        tempList.add(
          const VerticalDivider(width: 5.0),
        );
      }
      if (_worksheeTempEntity.length < 2) {
        tempList.add(
          Expanded(child: Container()),
        );
      }
      loopCount++;
    }
    return tempList;
  }

  void eventHandler(
      BuildContext context, String worksheetUniqueId, String pageType) {
    if (pageType == DocumentWorksheetFactory.routeName) {
      ShapeParams shapeParams = ShapeParams(
        type: ShapesType.circle.name,
        worksheetUniqueId: worksheetUniqueId,
      );
      BlocProvider.of<CircleBloc>(context).add(GetAllCircleEvent(shapeParams));
    } else if (pageType == ImageWorksheetPage.routeName) {}
  }
}

class OnGoingTask extends StatefulWidget {
  OnGoingTask({
    Key? key,
  }) : super(key: key);

  @override
  State<OnGoingTask> createState() => _OnGoingTaskState();
}

class _OnGoingTaskState extends State<OnGoingTask> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      width: 500.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 200.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Startup Website Design with Responsive",
                  style: TextStyle(
                    color: Colors.blueGrey[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.timelapse,
                      color: Colors.purple[300],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "10:00 AM - 12:30PM",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    "Complete - 80%",
                    style: TextStyle(
                      color: Colors.purple,
                    ),
                  ),
                )
              ],
            ),
          ),
          // const Icon(
          //   Icons.rocket_rounded,
          //   size: 60,
          //   color: Colors.orange,
          // )
        ],
      ),
    );
  }
}

class TaskGroupContainer extends StatelessWidget {
  final String categoryTitle;
  final int categoryId;
  final MaterialColor color;
  final bool? isSmall;
  final IconData icon;
  final String taskGroup;
  final String taskCount;
  const TaskGroupContainer({
    Key? key,
    required this.categoryTitle,
    required this.categoryId,
    required this.color,
    this.isSmall = false,
    required this.icon,
    required this.taskGroup,
    required this.taskCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int categoryIdContainer = 0;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color[400],
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 10,
            spreadRadius: 4,
            offset: const Offset(2, 6),
          )
        ],
        // gradient: AppColors.getDarkLinearGradient(color),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(
          //   height: 5,
          // ),
          Align(
            alignment: isSmall! ? Alignment.centerLeft : Alignment.center,
            child: Icon(
              icon,
              size: isSmall! ? 60 : 120,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Text(
            taskGroup,
            maxLines: 2,
            overflow: TextOverflow.fade,
            style: const TextStyle(
              color: Colors.white,
              fontSize: AppSize.s18,
              fontWeight: FontWeight.bold,
            ),
          ),
          // const SizedBox(
          //   height: 5,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$taskCount کاربرگ",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
              BlocConsumer<CategoryBloc, CategoryState>(
                listenWhen: (previous, current) {
                  if (current.deleteCategoryStatus ==
                          previous.deleteCategoryStatus ||
                      categoryIdContainer != categoryId) {
                    return false;
                  }
                  return true;
                },
                buildWhen: (previous, current) {
                  if (current.deleteCategoryStatus ==
                          previous.deleteCategoryStatus ||
                      categoryIdContainer != categoryId) {
                    return false;
                  }
                  return true;
                },
                listener: (context, stateListenerDelete) {
                  if (stateListenerDelete.deleteCategoryStatus
                      is DeleteCategoryError) {}
                },
                builder: (context, stateBuilderDelete) {
                  if (stateBuilderDelete.deleteCategoryStatus
                      is DeleteCategoryLoading) {
                    return const CircularProgressIndicator.adaptive(
                      strokeWidth: 5,
                    );
                  }
                  if (stateBuilderDelete.deleteCategoryStatus
                      is DeleteCategoryCompleted) {
                    categoryIdContainer = 0;
                    BlocProvider.of<CategoryBloc>(context).add(
                      GetAllCategoryEvent(),
                    );
                    NoParams noParams = NoParams();
                    BlocProvider.of<CategoryBloc>(context).add(
                      DeleteCategoryInitialEvent(noParams),
                    );
                  }

                  return ItemRemoverComponent(
                    categoryTitle: 'پوشه $categoryTitle',
                    onPressed: () {
                      CategoryParams categoryParams = CategoryParams(
                        id: categoryId,
                      );

                      BlocProvider.of<CategoryBloc>(context).add(
                        DeleteCategoryEvent(categoryParams),
                      );
                      BlocProvider.of<CategoryBloc>(context)
                          .categoryList
                          .remove(categoryId);
                      categoryIdContainer = categoryId;
                      Navigator.of(context).pop();
                    },
                    icon: Icons.delete,
                    colorIcon: ColorManager.white,
                  );
                },
              ),
            ],
          ),
          // const SizedBox(
          //   height: 5,
          // ),
        ],
      ),
    );
  }
}

class IconPicker extends StatefulWidget {
  final ValueChanged<IconData> onIconPicked;

  IconPicker({required this.onIconPicked});

  @override
  _IconPickerState createState() => _IconPickerState();
}

class _IconPickerState extends State<IconPicker> {
  Map<String, IconData> _filteredIcons = {};

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _filteredIcons = iconsCategory;

    super.initState();
  }

  void _filterIcons(String query) {
    _filteredIcons = Map.fromEntries(
      iconsCategory.entries
          .where(
            (entry) => entry.key.contains(query),
          )
          .map(
            (entry) => MapEntry(entry.key, entry.value),
          ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        // title: const Text(
        //   "لیست آیکون ها",
        //   style: TextStyle(
        //     color: Colors.blueGrey,
        //     fontSize: 20,
        //     fontWeight: FontWeight.bold,
        //     fontFamily: 'Vazir',
        //   ),
        // ),
        actions: [
          Container(
            height: 50,
            width: 100,
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                if (_filteredIcons.isNotEmpty) {
                  widget.onIconPicked(_filteredIcons.entries.first.value);
                }
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.grey.shade500,
                ),
              ),
              child: const Row(
                children: [
                  Text(
                    "انتخاب",
                    style: TextStyle(
                      color: Color(0xFFB8F1BD),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(10),
              hintText: "جستجو ...",
              hintTextDirection: TextDirection.rtl,
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
            ),
            onChanged: _filterIcons,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 6,
              children: _filteredIcons.entries.map(
                (icon) {
                  return IconButton(
                    color: Colors.green,
                    iconSize: AppSize.s60,
                    icon: Icon(icon.value),
                    onPressed: () {
                      widget.onIconPicked(icon.value);
                      Navigator.of(context).pop();
                    },
                  );
                },
              ).toList(),
            ),
          )
        ],
      ),
    );
  }
}

class ColorPicker extends StatefulWidget {
  final void Function(Color color) onColorSelected;

  const ColorPicker({super.key, required this.onColorSelected});

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late List<Color> colors;
  late List<Color> filteredColors;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    colors = getDefaultColors();
    filteredColors = colors;
    super.initState();
  }

  void filterColors(String query) {
    // TODO: implement search logic
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 25.0),
              // child: Text(
              //   "لیست رنگ ها",
              //   style: TextStyle(
              //     color: Colors.blueGrey,
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //     fontFamily: 'Vazir',
              //   ),
              // ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10.0),
          Expanded(
            child: GridView.count(
              crossAxisCount: 5,
              children: filteredColors.map((color) {
                return GestureDetector(
                  onTap: () {
                    widget.onColorSelected(color);
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: color,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  List<Color> getDefaultColors() {
    return [
      Colors.red,
      Colors.green,
      Colors.blue,
    ];
  }
}
