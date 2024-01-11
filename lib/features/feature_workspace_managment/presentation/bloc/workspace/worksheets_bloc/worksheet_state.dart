part of 'workspace_worksheet_bloc.dart';

class WorksheetState extends Equatable {
  final GetAllWorksheetStatus getAllWorksheetStatus;
  final GetWorksheetByIdStatus getWorksheetByIdStatus;
  final DeleteWorksheetStatus deleteWorksheetStatus;

  const WorksheetState({
    required this.getAllWorksheetStatus,
    required this.getWorksheetByIdStatus,
    required this.deleteWorksheetStatus,
  });

  WorksheetState copyWith({
    GetAllWorksheetStatus? newGetAllWorksheetStatus,
    GetWorksheetByIdStatus? newGetWorksheetByIdStatus,
    DeleteWorksheetStatus? newDeleteWorksheetStatus,
  }) {
    return WorksheetState(
      getAllWorksheetStatus: newGetAllWorksheetStatus ?? getAllWorksheetStatus,
      getWorksheetByIdStatus:
          newGetWorksheetByIdStatus ?? getWorksheetByIdStatus,
      deleteWorksheetStatus: newDeleteWorksheetStatus ?? deleteWorksheetStatus,
    );
  }

  @override
  List<Object?> get props => [
        getAllWorksheetStatus,
        getWorksheetByIdStatus,
        deleteWorksheetStatus,
      ];
}
