// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'dart:ui';
//
// Future<Uint8List> _combineImages(
//     Uint8List capturedImageBytes,
//     Uint8List mapImageBytes,
//     String userAddress,
//     String currentTime,
//     ) async {
//   final capturedImage = await decodeImageFromList(capturedImageBytes);
//   final mapImage = await decodeImageFromList(mapImageBytes);
//
//   final recorder = ui.PictureRecorder();
//   final canvas = Canvas(recorder, Size(capturedImage.width.toDouble(), capturedImage.height.toDouble()));
//
//   final paintImage = Paint();
//   canvas.drawImage(capturedImage, Offset.zero, paintImage);
//   canvas.drawImage(mapImage, Offset(capturedImage.width.toDouble() - mapImage.width.toDouble(), 0), paintImage);
//
//   final textPainter = TextPainter(
//     text: TextSpan(
//       text: '$userAddress\n$currentTime',
//       style: TextStyle(fontSize: 12, color: Colors.black),
//     ),
//     textDirection: TextDirection.ltr,
//   );
//   textPainter.layout();
//   textPainter.paint(canvas, Offset(16, capturedImage.height.toDouble() - mapImage.height.toDouble()));
//
//   final picture = recorder.endRecording();
//   final combinedImage = await picture.toImage(capturedImage.width, capturedImage.height);
//   final combinedBytes = await combinedImage.toByteData(format: ui.ImageByteFormat.png);
//
//   return combinedBytes!.buffer.asUint8List();
// }
