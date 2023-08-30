// import 'dart:async';
// import 'dart:io';
import 'package:gallery_saver/gallery_saver.dart';
// import 'package:flutter/material.dart';
import 'package:torch_control/torch_control.dart';
// import 'package:flutter/services.dart';
// import 'package:flashlight/flashlight.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter_native_screenshot/flutter_native_screenshot.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '/Screens/Deviceexamination.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
// import 'package:archive/archive.dart';
// import 'package:path/path.dart' as path;
// import 'package:camera/camera.dart';
// import 'package:image/image.dart' as img;
// import 'package:flutter/services.dart' show rootBundle;
// import 'dart:typed_data' show Uint8List;
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg/svg.dart';
//
// Future<Uint8List?> _readFileByte(String filePath) async {
//   Uri myUri = Uri.parse(filePath);
//   File audioFile = new File.fromUri(myUri);
//   Uint8List bytes;
//   await audioFile.readAsBytes().then((value) {
//     bytes = Uint8List.fromList(value);
//     print('reading of bytes is completed');
//   }).catchError((onError) {
//     print('Exception Error while reading audio from path:' +
//         onError.toString());
//   });
//   return null;
// }
//
// Future<void> main() async {
//   try {
//     await _readFileByte('assets/fonts/Poppins/Poppins-Black.ttf');
//
//     final fontZipFile = await File('assets/fonts/Poppins/Poppins-Black.ttf').readAsBytes();
//     print('erierorjwjini');
//   }
//   catch(r){
//     print("readiing error ${r}");
//   }
//   WidgetsFlutterBinding.ensureInitialized();
//   final cameras = await availableCameras();
//   final frontCamera = cameras.firstWhere(
//         (camera) => camera.lensDirection == CameraLensDirection.front,
//     orElse: () => cameras.first,
//   );
//   runApp(MyApp(frontCamera));
// }
//
// Future<Uint8List?> extractFontFromZip(String zipPath, String fontFileName) async {
//   final bytes = await File(zipPath).readAsBytes();
//   final archive = ZipDecoder().decodeBytes(bytes);
//
//   for (final file in archive) {
//     if (path.basename(file.name) == fontFileName) {
//       return file.content as Uint8List?;
//     }
//   }
//
//   return null;
// }
// class MyApp extends StatelessWidget {
//   final CameraDescription camera;
//
//   MyApp(this.camera);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Camera with Location',
//       theme: ThemeData.dark(),
//       home: CameraScreen(),
//     );
//   }
// }
//
// class CameraScreen extends StatefulWidget {
//   @override
//   _CameraScreenState createState() => _CameraScreenState();
// }
//
// class _CameraScreenState extends State<CameraScreen> {
//   CameraController? _controller;
//   Future<void> ?_initializeControllerFuture;
//   Position? _currentPosition;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//     _getCurrentLocation();
//   }
//
//   Future<void> _initializeCamera() async {
//     final cameras = await availableCameras();
//     final frontCamera = cameras.firstWhere(
//           (camera) => camera.lensDirection == CameraLensDirection.front,
//       orElse: () => cameras.first,
//     );
//     _controller = CameraController(frontCamera, ResolutionPreset.medium);
//     _initializeControllerFuture = _controller!.initialize();
//   }
//
//   Future<void> _getCurrentLocation() async {
//     try {
//       final position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//       setState(() {
//         _currentPosition = position;
//       });
//     } catch (e) {
//       print('Error getting current location: $e');
//     }
//   }
//
//   Future<bool> assetExists(String assetPath) async {
//     try {
//       await rootBundle.load(assetPath);
//       print("file theere ");
//       return true;
//     } catch (e) {
//       print("file not there  ");
//       return false;
//     }
//   }
//   static Future<img.BitmapFont> loadAssetFont(String asset) {
//     final Completer<img.BitmapFont> completer = Completer<img.BitmapFont>();
//
//     rootBundle.load(asset).then((ByteData bd) {
//       completer.complete(img.BitmapFont.fromZip(bd.buffer.asUint8List()));
//     }).catchError((dynamic exception, StackTrace stackTrace) {
//       completer.complete(null);
//     });
//
//     return completer.future;
//   }
//
//   Future<void> _capturePhoto() async {
//     try {
//       assetExists('assets/fonts/ABBERANC.zip');
//       final String zipPath = 'assets/fonts/FontPack.zip';
//       final String fontFileName = 'advent-Lt1.otf';
//
//       await _initializeControllerFuture;
//       final XFile image = await _controller!.takePicture();
//       final File imageFile = File(image.path);
//
//       // Load the captured image using the image package
//       final img.Image ?capturedImage = img.decodeImage(imageFile.readAsBytesSync())!;
//       // final ByteData fontData = await rootBundle.load('assets/fonts/AbrilFatface-Regular.ttf');
//       const List<int> _ARIAL_14 = [
//         // Replace with the binary data of your font file
//         0x4F, 0x54, 0x54, 0x4F, 0x00, // Example data
//         // ...
//       ];
//       var font = await loadAssetFont('assets/fonts/ABBERANC.zip');
//       // final fontZipFile = await File('assets/fonts/ABBERANC.zip').readAsBytes();
//       // final font = img.BitmapFont.fromZip(fontZipFile);
//       // var font = img.BitmapFont.fromFnt('zipPath',Poppins-ThinItalic);
//
//       // final img.BitmapFont arial_14 = new img.BitmapFont.fromZip(_ARIAL_14);
//       // ByteData fBitMapFontData = await loadAssetFont();
//       // final img.BitmapFont font = img.BitmapFont.fromZip('AbrilFatface-Regular', fontData);
//       // final FontLoader fontLoader = FontLoader('AbrilFatFace-Regular')..addFont(abrilFatFaceFontData);
//       // final font = Font.ttf(fontData);load('assets/fonts/arial.ttf');
//       // final customFont = await Svg.loadFont('assets/fonts/my_font.ttf');
//
//       // Create a font
//       // final font = img.arial_24;
//
//       // Define the text style
//       // final textStyle = img.TextStyle(color: img.Color.fromRgb(0, 0, 0), font: fontData);
//
//       // Calculate the position to draw the latitude and longitude text
//       final textX = 10;
//       final textY = 10;
//
//       // Draw the latitude and longitude text on the image
//       img.drawString(capturedImage!, font: font, y: textY, x: textX, 'Latide: ${_currentPosition?.latitude}',);
//      img.drawString(capturedImage,font: font, y: textY, x: textY+150, 'Longitude: ${_currentPosition?.longitude}');
//
//       // Save the modified image
//       final modifiedImagePath = image.path.replaceAll('.jpg', '_modified.jpg');
//       final modifiedImageFile = File(modifiedImagePath);
//       modifiedImageFile.writeAsBytesSync(img.encodeJpg(capturedImage));
//       final isSaved = await GallerySaver.saveImage(modifiedImagePath);
//       // Display the captured latitude and longitude
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Image Captured'),
//           content: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'Latitude: ${_currentPosition?.latitude ?? ''}',
//                 style: TextStyle(fontSize: 16, color: Colors.black),
//               ),
//               Text(
//                 'Longitude: ${_currentPosition?.longitude ?? ''}',
//                 style: TextStyle(fontSize: 16, color: Colors.black),
//               ),
//               SizedBox(height: 16),
//               Image.file(imageFile),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Close'),
//             ),
//           ],
//         ),
//       );
//     } catch (e) {
//       print('Error capturing photo: $e');
//     }
//   }
//
//   @override
//   void dispose() {
//     _controller!.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Camera with Location'),
//       ),
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return Stack(
//               children: [
//                 CameraPreview(_controller!),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Latitude: ${_currentPosition?.latitude ?? ''}',
//                         style: TextStyle(fontSize: 16, color: Colors.white),
//                       ),
//                       Text(
//                         'Longitude: ${_currentPosition?.longitude ?? ''}',
//                         style: TextStyle(fontSize: 16, color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                     bottom: 0,
//                     left: 20,
//                     child:   FloatingActionButton(onPressed: (){
//                   _capturePhoto();
//                 }))
//               ],
//             );
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//
//     );
//   }
// }

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  Position? position;
  String? address;
  int? indexposition;
  CameraScreen({this.position, this.address, this.indexposition});
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  CameraDescription? _currentCamera;
  bool _isFlashOn = false;
  bool _isButtonEnabled = true;
  double _zoomLevel = 1.0;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    initializeCamera();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _doTakeScreenshot() async {
    try {
      setState(() {
        _isButtonEnabled = false;
      });
      await Future.delayed(Duration(seconds: 1)).then((value) async {
        String? path = await FlutterNativeScreenshot.takeScreenshot();
        debugPrint('Screenshot taken, path: $path');
        if (path == null || path.isEmpty) {
          // _showSnackBar('Error taking the screenshot :(');
          return;
        } // if error
        // _showSnackBar('The screenshot has been saved to: $path');
        File imgFile = File(path);
        final isSaved = await GallerySaver.saveImage(path);
        setState(() {
          DeviceExaminationState.instance!.imagePaths[widget.indexposition!] =
              path;
        });

        // _imgHolder = Image.file(imgFile);
      });
    } catch (e) {
    } finally {
      await Future.delayed(Duration(seconds: 1)).then((value) {
        setState(() {
          _isButtonEnabled = true;
        });
      });
    }
  }

  Future<void> initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras!.length > 0) {
      _currentCamera = _cameras![0];
      _cameraController =
          CameraController(_currentCamera!, ResolutionPreset.medium);
      await _cameraController!.initialize();
      setState(() {});
    }
  }

  void toggleCamera() {
    if (_cameras!.length > 1) {
      int newCameraIndex =
          (_currentCamera!.lensDirection == CameraLensDirection.back) ? 1 : 0;
      _currentCamera = _cameras![newCameraIndex];
      _cameraController =
          CameraController(_currentCamera!, ResolutionPreset.medium);
      _cameraController!.initialize().then((_) {
        setState(() {});
      });
    }
  }

  void toggleFlash() {
    setState(() {
      if (_isFlashOn) {
        TorchControl.turnOff();
        _isFlashOn = false;
      } else {
        TorchControl.turnOn();
        _isFlashOn = true;
      }
    });
  }

  void handleZoom(double zoomFactor) {
    setState(() {
      _zoomLevel *= zoomFactor;
      // if (_zoomLevel < 1.0) _zoomLevel = 1.0;
      _zoomLevel = _zoomLevel * 10;
      if (_zoomLevel <= 8.0 && _zoomLevel >= 1.0) {
//Here we set the zoom level when we move slider pointer
        _cameraController!.setZoomLevel(_zoomLevel);
      }
//and to set slider pointer position visually, we divided the value by 10
//to give slider its original value.
      setState(() => _zoomLevel = _zoomLevel / 10);
      // // Update zoom level based on available zoom ratios
      // final availableZoomRatios = _cameraController!.value.zoomRatios;
      // if (_zoomLevel > availableZoomRatios.last) {
      //   _zoomLevel = availableZoomRatios.last.toDouble();
      // }

      // _cameraController.setZoomLevel(_zoomLevel.toInt());
    });
  }

  void takePhoto() async {
    if (!_cameraController!.value.isTakingPicture) {
      final image = await _cameraController!.takePicture();
      // Process the captured image
    }
  }

  @override
  void dispose() {
    _cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    String formattedDate = DateFormat.yMd().add_jm().format(now);
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      // appBar: AppBar(title: Text('Camera')),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: AspectRatio(
              aspectRatio: _cameraController!.value.aspectRatio,
              child: GestureDetector(
                onScaleUpdate: (details) {
                  handleZoom(details.scale);
                },
                child: CameraPreview(_cameraController!),
              ),
            ),
          ),
          Visibility(
            visible: _isButtonEnabled,
            child: Positioned(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: FloatingActionButton(
                          child: Icon(Icons.camera_alt),
                          onPressed: () {
                            _doTakeScreenshot();
                          },
                        )))),
          ),

          Visibility(
              visible: _isButtonEnabled,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.switch_camera),
                    onPressed: toggleCamera,
                  ),
                  IconButton(
                    icon: (_isFlashOn)
                        ? Icon(Icons.flash_on)
                        : Icon(Icons.flash_off),
                    onPressed: toggleFlash,
                  ),
                ],
              )),

          Positioned(
            bottom: 100,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 120,
                margin: EdgeInsets.only(left: 10, right: 10),
                width: MediaQuery.of(context).size.width - 30,
                color: Colors.black,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 15,
                          height: 35,
                        ),
                        Text(
                          "Lat: ${widget.position!.latitude}",
                          style: TextStyle(color: Colors.white),
                        ),
                        // SizedBox(width: 30,),
                        Text(
                          "Long:${widget.position!.longitude}",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                            "Date&Time: ${DateFormat('dd-MM-yyyy h:mm:ss a').format(DateTime.now())}",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Text("${widget.address}",
                        maxLines: 5,
                        softWrap: true,
                        style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
            ),
          ),
          // Align(
//           //   alignment: Alignment.bottomCenter,
//           //   child: Padding(
//           //     padding: EdgeInsets.only(bottom: 16.0),
//           //     child: FloatingActionButton(
//           //       child: Icon(Icons.camera),
//           //       onPressed: _doTakeScreenshot,
//           //     ),
//           //   ),
//           // ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.camera_alt),
      //   onPressed: takePhoto,
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
