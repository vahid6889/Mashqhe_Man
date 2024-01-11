part of 'workspace_worksheet_bloc.dart';

@immutable
abstract class WorksheetEvent {}

class GetAllWorksheetEvent extends WorksheetEvent {
  final WorksheetParams worksheetParams;
  GetAllWorksheetEvent(this.worksheetParams);
}

class GetAllWorksheetInitialEvent extends WorksheetEvent {
  final NoParams noParams;
  GetAllWorksheetInitialEvent(this.noParams);
}

class GetWorksheetByIdEvent extends WorksheetEvent {
  final WorksheetParams worksheetParams;
  GetWorksheetByIdEvent(this.worksheetParams);
}

class GetWorksheetByIdInitialEvent extends WorksheetEvent {
  final NoParams noParams;
  GetWorksheetByIdInitialEvent(this.noParams);
}

class DeleteWorksheetEvent extends WorksheetEvent {
  final int worksheetId;
  DeleteWorksheetEvent(this.worksheetId);
}

class DeleteWorksheetInitialEvent extends WorksheetEvent {
  final NoParams noParams;

  DeleteWorksheetInitialEvent(this.noParams);
}
