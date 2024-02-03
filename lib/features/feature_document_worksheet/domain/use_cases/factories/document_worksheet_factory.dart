import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mashgh/core/blocs/cubits/toolbar_component_cubit.dart';
import 'package:mashgh/features/feature_document_worksheet/presentation/screens/documents/document_worksheet_page.dart';

class DocumentWorksheetFactory extends StatefulWidget {
  static const routeName = "/document_worksheet";
  static int page = 2;
  const DocumentWorksheetFactory({super.key});

  @override
  State<DocumentWorksheetFactory> createState() =>
      _DocumentWorksheetFactoryState();
}

class _DocumentWorksheetFactoryState extends State<DocumentWorksheetFactory> {
  @override
  void initState() {
    BlocProvider.of<ToolbarComponentCubit>(context).shapeVisibility(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const DocumentWorksheetPage();
  }
}
