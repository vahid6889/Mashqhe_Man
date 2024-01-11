// import 'dart:typed_data';

// import 'package:equatable/equatable.dart';
// import 'package:floor/floor.dart';

// @Entity(tableName: 'temporary_worksheet')
// class TemporaryWorksheetEntity extends Equatable {
//   @PrimaryKey(autoGenerate: true)
//   int? id;

//   final String? uniqueId;

//   /// This field can store both text/html and image data
//   final Uint8List? content;

//   /// JSON serialized shapes {uniqueID: 5, type: “circle”, content: 5555, xPosition: 445.5, yPosition: 122.9}
//   String? shapes;

//   TemporaryWorksheetEntity({
//     this.uniqueId,
//     this.content,
//     this.shapes,
//   });

//   @override
//   List<Object?> get props => [
//         uniqueId,
//         content,
//         shapes,
//       ];
// }
