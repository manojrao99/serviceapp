// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class DraggableMarkerMap extends StatefulWidget {
//   @override
//   _DraggableMarkerMapState createState() => _DraggableMarkerMapState();
// }
//
// class _DraggableMarkerMapState extends State<DraggableMarkerMap> {
//   LatLng? markerPosition;
//   bool isDragging = false;
//   int markerId = 0;
//   Set<Marker> _markers = {};
//
//   GoogleMapController? _mapController;
//
//   @override
//   Widget build(BuildContext context) {
//     final Size screenSize = MediaQuery.of(context).size;
//     final double centerX = screenSize.width / 2;
//     final double centerY = screenSize.height / 2;
//
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           height: screenSize.height,
//           child: Stack(
//             children: [
//               GoogleMap(
//                 mapType: MapType.satellite,
//                 initialCameraPosition: CameraPosition(target: LatLng(0, 0)),
//                 markers: _markers,
//                 onTap: (LatLng latLng) {
//                   setState(() {
//                     markerPosition = latLng;
//                   });
//                 },
//                 onMapCreated: (GoogleMapController controller) {
//                   _mapController = controller;
//                 },
//               ),
//               if (markerPosition != null)
//                 Positioned(
//                   left: centerX - 16,
//                   top: centerY - 16,
//                   child: Draggable(
//                     feedback: Image.asset("assets/images/MapAppTargetPointer.png"),
//                     child: Image.asset("assets/images/MapAppTargetPointer.png"),
//                     onDragStarted: () {
//                       setState(() {
//                         isDragging = true;
//                       });
//                     },
//                     onDragEnd: (details) {
//                       setState(() {
//                         isDragging = false;
//                         markerPosition = LatLng(
//                           markerPosition!.latitude + details.offset.dy * 0.0001,
//                           markerPosition!.longitude + details.offset.dx * 0.0001,
//                         );
//                       });
//                     },
//                     onDraggableCanceled: (_, __) {
//                       setState(() {
//                         isDragging = false;
//                       });
//                     },
//                     childWhenDragging: Container(),
//                   ),
//                 ),
//               if (markerPosition != null && !isDragging)
//                 Positioned(
//                   right: 16,
//                   bottom: 16,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (markerPosition != null) {
//                         // Create a marker at the dragged position
//                         final marker = Marker(
//                           markerId: MarkerId(markerId.toString()),
//                           position: markerPosition!,
//                         );
//
//                         setState(() {
//                           markerId++;
//                           _markers.add(marker);
//                         });
//
//                         // Add the marker to the map
//                         // _mapController?.addMarker(marker);
//                       }
//                     },
//                     child: Text('Add Marker'),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:ui' as ui;
//
// class DraggableMarkerMap extends StatefulWidget {
//   @override
//   _DraggableMarkerMapState createState() => _DraggableMarkerMapState();
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
class DraggableMarkerMap extends StatefulWidget {
  @override
  _MarkerCreationMapState createState() => _MarkerCreationMapState();
}

class _MarkerCreationMapState extends State<DraggableMarkerMap> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  GlobalKey _iconKey = GlobalKey();
  BitmapDescriptor? _markerIcon;

  @override
  void initState() {
    super.initState();
    _createCustomMarkerIcon();
  }

  void _createCustomMarkerIcon() async {
    final Uint8List markerIconBytes = await getBytesFromAsset(
      path: "assets/images/MapAppTargetPointer.png",
      width: 100, // Adjust the size of the marker icon
    );
    setState(() {
      _markerIcon = BitmapDescriptor.fromBytes(markerIconBytes);
    });
  }

  Future<Uint8List> getBytesFromAsset({required String path, required int width}) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              _mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(37.7749, -122.4194),
              zoom: 12,
            ),
            markers: _markers,
          ),
          Center(
            child: GestureDetector(
              onTap: _onIconTap,
              child: Image.asset(
                "assets/images/MapAppTargetPointer.png",
                key: _iconKey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onIconTap() async {
    RenderBox? iconBox = _iconKey.currentContext?.findRenderObject() as RenderBox?;
    if (iconBox != null) {
      Offset iconPosition = iconBox.localToGlobal(Offset.zero);
      LatLng? iconLatLng = await _mapController?.getLatLng(
        ScreenCoordinate(
          x: iconPosition.dx.toInt(),
          y: iconPosition.dy.toInt(),
        ),
      );

      if (iconLatLng != null) {
        double currentZoomLevel = await _mapController!.getZoomLevel();

        int numTiles = 1 << currentZoomLevel.toInt();
        double currentCameraPosition = await _mapController!.getZoomLevel();

        print("zoom level ${currentCameraPosition}");
        // Adjust the marker position by adding an offset
        // double zoomLevel = currentCameraPosition.zoom;

        // Adjust the marker position based on the zoom level
        double offsetX =  5 * 6.25-025; // Adjust the X offset based on the zoom level
        double offsetY = 5 * -5.5-025;

        LatLng markerLatLng = LatLng(
          iconLatLng.latitude *numTiles,
          iconLatLng.longitude * numTiles,
        );
      print(markerLatLng);
        setState(() {
          _markers.add(
            Marker(
              markerId: MarkerId("createdMarker"),
              position: markerLatLng,
              // icon: _markerIcon,
            ),
          );
        });
      }
    }
  }
}










