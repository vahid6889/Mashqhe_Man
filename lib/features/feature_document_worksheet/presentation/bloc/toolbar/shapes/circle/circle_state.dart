part of 'circle_bloc.dart';

class CircleState extends Equatable {
  final GetAllCircleStatus getAllCircleStatus;
  final SaveCircleToolbarStatus saveCircleToolbarStatus;
  final SaveCircleWorksheetStatus saveCircleWorksheetStatus;
  final DeleteCircleStatus deleteCircleStatus;

  const CircleState({
    required this.getAllCircleStatus,
    required this.saveCircleToolbarStatus,
    required this.saveCircleWorksheetStatus,
    required this.deleteCircleStatus,
  });

  CircleState copyWith({
    GetAllCircleStatus? newGetAllCircleStatus,
    SaveCircleToolbarStatus? newSaveCircleToolbarStatus,
    SaveCircleWorksheetStatus? newSaveCircleWorksheetStatus,
    DeleteCircleStatus? newDeleteCircleStatus,
  }) {
    return CircleState(
      getAllCircleStatus: newGetAllCircleStatus ?? getAllCircleStatus,
      saveCircleToolbarStatus:
          newSaveCircleToolbarStatus ?? saveCircleToolbarStatus,
      saveCircleWorksheetStatus:
          newSaveCircleWorksheetStatus ?? saveCircleWorksheetStatus,
      deleteCircleStatus: newDeleteCircleStatus ?? deleteCircleStatus,
    );
  }

  @override
  List<Object?> get props => [
        getAllCircleStatus,
        saveCircleToolbarStatus,
        saveCircleWorksheetStatus,
        deleteCircleStatus,
      ];
}
