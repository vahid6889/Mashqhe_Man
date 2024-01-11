part of 'circle_bloc.dart';

@immutable
abstract class CircleEvent {}

/// get all circle from shapes table
class GetAllCircleEvent extends CircleEvent {
  final ShapeParams shapeParams;
  GetAllCircleEvent(this.shapeParams);
}

class GetAllCircleInitialEvent extends CircleEvent {
  final NoParams noParams;
  GetAllCircleInitialEvent(this.noParams);
}

/// save cirlce when move in toolbar on worksheet
class SaveCirlceToolbarEvent extends CircleEvent {
  final ShapeParams shapeParams;
  SaveCirlceToolbarEvent(this.shapeParams);
}

class SaveCircleToolbarInitialEvent extends CircleEvent {
  final NoParams noParams;
  SaveCircleToolbarInitialEvent(this.noParams);
}

/// save cirle when move in worksheet on worksheet
class SaveCirlceWorksheetEvent extends CircleEvent {
  final ShapeParams shapeParams;
  SaveCirlceWorksheetEvent(this.shapeParams);
}

class SaveCircleWorksheetInitialEvent extends CircleEvent {
  final NoParams noParams;
  SaveCircleWorksheetInitialEvent(this.noParams);
}

/// update circle content
class UpdateCirlceContentEvent extends CircleEvent {
  /// update just content circle shape
  final ShapeParams shapeParams;
  UpdateCirlceContentEvent(this.shapeParams);
}

class UpdateCircleInitialEvent extends CircleEvent {}

/// delete circle by id
class DeleteCirlceEvent extends CircleEvent {
  final ShapeParams shapeParams;
  DeleteCirlceEvent(this.shapeParams);
}
