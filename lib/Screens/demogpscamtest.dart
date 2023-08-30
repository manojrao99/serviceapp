// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:image/image.dart' as img;
// import 'package:flutter/services.dart';
// import 'package:stamp_image/stamp_image.dart';
// // import 'package:extended_image/extended_image.dart';
//
// void main() {
//   runApp(CameraMapApp());
// }
//
// class CameraMapApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: CameraMapScreen(),
//     );
//   }
// }
//
// class CameraMapScreen extends StatefulWidget {
//   @override
//   _CameraMapScreenState createState() => _CameraMapScreenState();
// }
//
// class _CameraMapScreenState extends State<CameraMapScreen> {
//   late CameraController _controller;
//   late GoogleMapController _mapController;
//   XFile? xFile;
//   List<Marker> _markers = [];
//   LatLng _center = LatLng(0, 0); // Default center
//   Uint8List? _processedImageBytes;
//
//   @override
//   void initState() {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
//     super.initState();
//
//     _initializeCamera();
//     _getCurrentLocation();
//   }
//
//   Future<void> _initializeCamera() async {
//     final cameras = await availableCameras();
//     final firstCamera = cameras.first;
//     _controller = CameraController(firstCamera, ResolutionPreset.medium);
//     await _controller.initialize();
//     setState(() {});
//   }
//
//   Future<void> _getCurrentLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     setState(() {
//       _center = LatLng(position.latitude, position.longitude);
//     });
//     // Use Geocoder package to get the address from the latitude and longitude
//     // _address = await _getAddressFromLatLng(position.latitude, position.longitude);
//   }
//
//   Future<void> _captureAndCombine() async {
//     // Capture the image
//     final capturedImage = await _controller.takePicture();
//
//     // Get the map snapshot
//     final mapImage = await _mapController.takeSnapshot();
// print("image ${File(capturedImage.path)}");
//     // Combine captured image with mapImage and other UI elements
//      StampImage.create(
//       context: context,
//       image: File(capturedImage.path),
//       children: [
//         Positioned(
//           bottom: 100,
//           right: 0,
//           child: Container(
//             height: 100,
//             child: Image.memory(mapImage!),
//           ),
//         ),
//       ],
//       onSuccess: (file) async {
//         Uint8List uint8List = await file!.readAsBytes();
//         print("allimage ${uint8List}");
//         setState(() {
//           _processedImageBytes = uint8List;
//         });
//       },
//     );
//
//     // Now you can use the 'stampedImage' result if needed
//     // For example, you could print the path:
//     // print('Stamped image saved at: ${stampedImage.}');
//   }
//
//
//
//
//
//   // More code for handling Google Maps, Drawing, Saving images, etc.
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (!_controller.value.isInitialized) {
//       return Container();
//     }
//     return Scaffold(
//       // appBar: AppBar(title: Text('Camera with Map')),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: _processedImageBytes == null
//             ? Stack(
//           children: [
//             Container(
//               height: MediaQuery.of(context).size.height,
//               child: CameraPreview(_controller),
//             ),
//             Positioned(
//               bottom: 100,
//               child: Container(
//                 width: 300,
//                 height: 200,
//                 child: GoogleMap(
//                   onMapCreated: (controller) => _mapController = controller,
//                   initialCameraPosition: CameraPosition(target: _center, zoom: 15),
//                   markers: Set<Marker>.from(_markers),
//                 ),
//               ),
//             ),
//           ],
//         )
//             : Stack(
//           children: [
//             Image.memory(_processedImageBytes!),
//             Positioned(
//               bottom: 300,
//
//                 child: Text("Manoj"))
//           ],
//         )
//       ),
//       floatingActionButton: _processedImageBytes == null
//           ? FloatingActionButton(
//         onPressed: _captureAndCombine,
//         child: Icon(Icons.camera),
//       )
//           : SizedBox(),
//     );
//   }
// }
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stamp_image/stamp_image.dart';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_watermark/image_watermark.dart';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stamp_image/stamp_image.dart';
void main() {
  runApp(CameraMapApp());
}


class CameraMapApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stamp Image',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final picker = ImagePicker();
  File? image;

  void takePicture() async {
    //     final image = await _picker.pickImage(
//       source: ImageSource.gallery,
//     );
//     if (image != null) {
//       _image = image;
//       var t = await image.readAsBytes();
//       imgBytes =File(_image!.path);
//     }

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    print("image picked ${pickedFile!.path}");
    if (pickedFile != null) {
      // await resetImage();

      StampImage.create(
        context: context,
        image: File(pickedFile.path),
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: _watermarkItem(),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: _logoFlutter(),
          )
        ],
        onSuccess: (file) => resultStamp(file),
      );
    }
    print("image picked null");
  }

  ///Resetting an image file
  Future resetImage() async {
    setState(() {
      image = null;
    });
  }

  ///Handler when stamp image complete
  void resultStamp(File? file) {
    print(file?.path);
    setState(() {
      image = file;
    });
  }

  Widget _watermarkItem() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            DateTime.now().toString(),
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          SizedBox(height: 5),
          Text(
            "Made By Stamp Image",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _logoFlutter() {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: FlutterLogo(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stamp Imager"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageWidget(),
            SizedBox(height: 10),
            _buttonTakePicture()
          ],
        ),
      ),
    );
  }

  Widget _buttonTakePicture() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () => takePicture(),
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Text(
          "Take Picture",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  Widget _imageWidget() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      child: image != null ? Image.file(image!) : SizedBox(),
    );
  }
}



// class CameraMapApp extends StatelessWidget {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'image_watermark',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const HomeScreen(),
//     );
//   }
// }
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   HomeScreenState createState() => HomeScreenState();
// }
//
// class HomeScreenState extends State<HomeScreen> {
//   final _picker = ImagePicker();
//   File? imgBytes;
//   File? imgBytes2;
//   XFile? _image;
//   Uint8List? watermarkedImgBytes;
//   bool isLoading = false;
//   String watermarkText = "", imgname = "image not selected";
//   List<bool> textOrImage = [true, false];
//
//   pickImage() async {
//     final image = await _picker.pickImage(
//       source: ImageSource.gallery,
//     );
//     if (image != null) {
//       _image = image;
//       var t = await image.readAsBytes();
//       imgBytes =File(_image!.path);
//     }
//     setState(() {});
//   }
//
//   pickImage2() async {
//     XFile? image = await _picker.pickImage(
//       source: ImageSource.gallery,
//     );
//     if (image != null) {
//       _image = image;
//       imgname = image.name;
//       var t = await image.readAsBytes();
//       imgBytes2 =File(image.path);
//     }
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('image_watermark'),
//       ),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Center(
//           child: SizedBox(
//             width: 600,
//             child: Column(
//               children: [
//                 GestureDetector(
//                   onTap: pickImage,
//                   child: Container(
//                       margin: const EdgeInsets.all(15),
//                       decoration: BoxDecoration(
//                           border: Border.all(),
//                           borderRadius:
//                           const BorderRadius.all(Radius.circular(5))),
//                       width: 600,
//                       height: 250,
//                       child: _image == null
//                           ? Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: const [
//                           Icon(Icons.add_a_photo),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Text('Click here to choose image')
//                         ],
//                       )
//                           : Image.file(imgBytes!,
//                           width: 600, height: 200, fit: BoxFit.fitHeight)),
//                 ),
//                 ToggleButtons(
//                   fillColor: Colors.blue,
//                   borderRadius: const BorderRadius.all(Radius.circular(8)),
//                   borderWidth: 3,
//                   borderColor: Colors.black26,
//                   selectedBorderColor: Colors.black54,
//                   selectedColor: Colors.black,
//                   onPressed: (index) {
//                     textOrImage = [false, false];
//                     setState(() {
//                       textOrImage[index] = true;
//                     });
//                   },
//                   isSelected: textOrImage,
//                   children: const [
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text(
//                         '  Text  ',
//                       ),
//                     ),
//                     // second toggle button
//                     Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Text(
//                           '  Image  ',
//                         ))
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 textOrImage[0]
//                     ? Padding(
//                   padding: const EdgeInsets.all(15),
//                   child: SizedBox(
//                     width: 600,
//                     child: TextField(
//                       onChanged: (val) {
//                         watermarkText = val;
//                       },
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Watermark Text',
//                         hintText: 'Watermark Text',
//                       ),
//                     ),
//                   ),
//                 )
//                     : Row(
//                   children: [
//                     ElevatedButton(
//                         onPressed: pickImage2,
//                         child: const Text('Select Watermark image')),
//                     Text(imgname)
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 ElevatedButton(
//                   onPressed: () async {
//                     setState(() {
//                       isLoading = true;
//                     });
//                     if (textOrImage[0]) {
//                       File file = File(imgBytes!.path); // Replace with your file path
//                       Uint8List uint8List = await file.readAsBytes();
//                       watermarkedImgBytes =
//                       await ImageWatermark.addTextWatermark(
//                         ///image bytes
//                         imgBytes: uint8List,
//
//                         ///watermark text
//                         watermarkText: watermarkText,
//                         dstX: 20,
//                         dstY: 30,
//                       );
//
//                       /// default : imageWidth/2
//                     } else {
//                       // void generate() {
//                         StampImage.create(
//                           context: context,
//                           image: File(imgBytes!.path),
//                           children: [
//                             Positioned(
//                               bottom: 0,
//                               right: 0,
//                               child: Image.file(imgBytes2!),
//                             ),
//
//                           ],
//                           onSuccess: (file) async{
//                             // File file = File(); // Replace with your file path
//                             Uint8List uint8List = await file.readAsBytes();
//                          setState(() {
//                            watermarkedImgBytes =uint8List;
//                            // setState(() {
//                              isLoading = false;
//                            // });
//                          });
//                           },
//                         );
//                       // }
//
//
//
//
//
//                       // await ImageWatermark.addImageWatermark(
//                       //   //image bytes
//                       //     originalImageBytes: imgBytes!,
//                       //     waterkmarkImageBytes: imgBytes2!,
//                       //     imgHeight: 600,
//                       //     imgWidth: 700,
//                       //     dstY: 10,
//                       //     dstX: 10);
//                     }
//
//                     setState(() {
//                       isLoading = false;
//                     });
//                   },
//                   child: const Text('Add Watermark'),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 isLoading ? const CircularProgressIndicator() : Container(),
//                 watermarkedImgBytes == null
//                     ? const SizedBox()
//                     : Image.memory(watermarkedImgBytes!),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final picker = ImagePicker();
//   File? image;
//
//   void takePicture() async {
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       await resetImage();
//
//       StampImage.create(
//         context: context,
//         image: File(pickedFile.path),
//         children: [
//           Positioned(
//             bottom: 0,
//             right: 0,
//             child: _watermarkItem(),
//           ),
//           Positioned(
//             top: 0,
//             left: 0,
//             child: _logoFlutter(),
//           )
//         ],
//         onSuccess: (file) => resultStamp(file),
//       );
//     }
//   }
//
//   ///Resetting an image file
//   Future resetImage() async {
//     setState(() {
//       image = null;
//     });
//   }
//
//   ///Handler when stamp image complete
//   void resultStamp(File? file) {
//     print(file?.path);
//     setState(() {
//       image = file;
//     });
//   }
//
//   Widget _watermarkItem() {
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Text(
//             DateTime.now().toString(),
//             style: TextStyle(color: Colors.white, fontSize: 15),
//           ),
//           SizedBox(height: 5),
//           Text(
//             "Made By Stamp Image",
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(
//               color: Colors.blue,
//               fontWeight: FontWeight.bold,
//               fontSize: 15,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _logoFlutter() {
//     return Container(
//       margin: EdgeInsets.all(10),
//       decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
//       child: Padding(
//         padding: const EdgeInsets.all(8),
//         child: FlutterLogo(),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Stamp Imager"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _imageWidget(),
//             SizedBox(height: 10),
//             _buttonTakePicture()
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buttonTakePicture() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 20),
//       width: MediaQuery.of(context).size.width,
//       child: ElevatedButton(
//         onPressed: () => takePicture(),
//         style: ElevatedButton.styleFrom(
//           primary: Colors.blue,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(5),
//           ),
//         ),
//         child: Text(
//           "Take Picture",
//           style: TextStyle(color: Colors.white, fontSize: 20),
//         ),
//       ),
//     );
//   }
//
//   Widget _imageWidget() {
//     return Container(
//       width: MediaQuery.of(context).size.width / 1.1,
//       child: image != null ? Image.file(image!) : SizedBox(),
//     );
//   }
// }