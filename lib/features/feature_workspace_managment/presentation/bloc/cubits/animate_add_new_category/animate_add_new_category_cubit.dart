import 'package:bloc/bloc.dart';

class AnimateAddNewCategoryButtonCubit extends Cubit<bool> {
  bool lastStatus = true;

  AnimateAddNewCategoryButtonCubit()
      : super(
          false,
        );

  changeScrollListener(isShrink) {
    emit(isShrink);
  }
}
