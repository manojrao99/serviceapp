import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dart_jts/dart_jts.dart' as jts;
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hexcolor/hexcolor.dart';
import '/models/devicelocations.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math' as math;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';
import 'package:permission_handler/permission_handler.dart';
import '/Screens/farmermapdatadetails.dart';
import '/models/farmlandcordinates.dart';

import 'package:flutter_gif/flutter_gif.dart';
import '../models/farmermapdata.dart';
import '../stayles.dart';
import 'Permissiondenydiloag.dart';

class Location {
  double latitude;
  double longitude;

  Location(this.latitude, this.longitude);

  LatLng getLatLng() {
    return LatLng(latitude, longitude);
  }
}

class MapScreen extends StatefulWidget {
  final incerpermission;
  List<Polygronclass>? polygrondata;
  List<AlreadyFarmlands>? alreadyprcent;
  List<Farmermobile> data;
  int? farmeracussationid;
  final bool accausation;
  bool? isloading;

  MapScreen(
      {this.farmeracussationid,
      required this.accausation,
      required this.incerpermission,
      required this.data,
      this.polygrondata,
      this.isloading,
      this.alreadyprcent});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  ScrollController _scrolcontroller = new ScrollController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final mywidgetkey = GlobalKey();
  final double zoomLevel = 12.0;
  double draggableX = 0.0;
  double draggableY = 0.0;
  String? activearrayname;
  // final Color bagroundcolor = HexColor.fromHex('#3e3e3d');
  bool satilite = true;
  bool Edit = false;
  LatLng? editlatlg;
  Offset position = Offset(0, 0);
  // double widgetSize = 100.0;
  Color widgetColor = Colors.blue;
  double widgetWidth = 100.0; // Update with the desired width of the widget
  double widgetHeight = 100.0;
  LatLng _center = LatLng(0.0, 0.0);
  Set<Marker> _markers = {};
  Set<Marker> _sensormarker = {};
  // FlutterGifController ?gifcontroller;
  late GoogleMapController _controller;
  double _currentMapBearing = 0.0;
  bool direct = false;
  String? selectedItem;
  List<List> farmlandlist = [];
  Color color = Colors.red.withOpacity(0.2);
  Color markercolor = Colors.red;
  int i = 0;
  int preivious = 0;
  List<dynamic> allaray = [];

  Polygon? selected;
  LatLng? editlat;

  List<Farmarraay> Directarray = [];

  // Function to handle tap events on the map
  List<Polygon> polygons = [];
  Map<String, List<LatLng>> polygon2OffsetCoordinates = {};

  LatLng calculatePolygonsCenter(List<LatLng> points) {
    double latSum = 0.0;
    double lngSum = 0.0;
    int totalPoints = points.length;

    for (LatLng point in points) {
      latSum += point.latitude;
      lngSum += point.longitude;
    }

    double centerLat = latSum / totalPoints;
    double centerLng = lngSum / totalPoints;
    setState(() {
      _center = LatLng(centerLat, centerLng);
    });
    return LatLng(centerLat, centerLng);
  }

  void alldata() {
    // if(widget.alreadyprcent !=[] || widget.alreadyprcent !=null){
    widget.alreadyprcent!.forEach((farmlandpolygrom) {
      print("sensor type ${farmlandpolygrom.SensorType}");
      final regex = RegExp(r'LatLng\(([-0-9.]+), ([-0-9.]+)\)');
      List<LatLng> mapbondries = [];
      final matches =
          regex.allMatches(farmlandpolygrom.polygonBoundaryes.toString());
      matches.forEach((element) {
        mapbondries.add(LatLng(
            double.tryParse(element.group(1).toString())!.toDouble(),
            double.tryParse(element.group(2).toString())!.toDouble()));
        // print("all matches ${element.group(1)},${element.group(2)}");
      });

      List<Marker> markers = [];

      farmerarray.add(Farmarraay(
          color: farmlandpolygrom.farmLandName!.startsWith("F")
              ? Colors.red
              : farmlandpolygrom.farmLandName!.startsWith("B")
                  ? Colors.blue
                  : farmlandpolygrom.SensorType == "DS"
                      ? Colors.green.withOpacity(0.5)
                      : farmlandpolygrom.SensorType == "TP"
                          ? Colors.yellow.withOpacity(0.5)
                          : Colors.grey,
          marker: markers,
          name: farmlandpolygrom.farmLandName,
          mapboundrieslat: mapbondries,
          Plottype: farmlandpolygrom.SensorType,
          Sensorlatlang: LatLng(farmlandpolygrom.sensorlat ?? 0.0,
              farmlandpolygrom.sensorlang ?? 0.0)));
      polygons = [];

      farmerarray.forEach((element) {
        _markers.addAll(element.marker);
        if (element.mapboundrieslat.length > 2) {
          element.polygran = Polygon(
            polygonId: PolygonId(element.name.toString()),
            points: element.mapboundrieslat,
            fillColor: element.color!.withOpacity(0.5),
            strokeColor: Colors.blue,
            strokeWidth: 2,
          );
          polygons.add(element.polygran!);
        }

        if (element.Plottype == 'DS') {
          final marker = Marker(
            markerId: MarkerId(element.Sensorlatlang.toString()),
            position: element.Sensorlatlang!,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
          );
          _markers.add(marker);
        } else if (element.Plottype == 'TP') {
          final marker = Marker(
            markerId: MarkerId(element.Sensorlatlang.toString()),
            position: element.Sensorlatlang!,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueYellow),
          );
          _markers.add(marker);
        } else if (element.Plottype == 'AP') {
          final marker = Marker(
            markerId: MarkerId(element.Sensorlatlang.toString()),
            position: element.Sensorlatlang!,
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
          );
          _markers.add(marker);
        }
      });
    });
    List<LatLng> allpolygronslatlangs = [];
    polygons.forEach((polygron) {
      allpolygronslatlangs.addAll(polygron.points);
    });
    calculatePolygonsCenter(allpolygronslatlangs);
  }

  void _updatePolygonMarker(LatLng newPositiondata, LatLng oldPosition) {
    print("new position ${newPositiondata} oldposition ${oldPosition}");
    for (int u = 0; u < farmerarray.length; u++) {
      var element = farmerarray[u];

      final index = element.mapboundrieslat.indexOf(oldPosition);
      if (index != -1) {
        setState(() {
          element.mapboundrieslat.removeAt(index);
          element.mapboundrieslat.insert(index, newPositiondata);
          final marker = element.marker
              .firstWhere((marker) => marker.position == oldPosition);
          element.marker.remove(marker);
          _markers.remove(marker);

          final marker1 = Marker(
            markerId: marker.markerId,
            position: newPositiondata,
            draggable: true,
            icon: BitmapDescriptor.defaultMarker,
            onDragEnd: (newPosition) {
              _updatePolygonMarker(newPosition, newPositiondata);
            },
          );
          final updatedMarker = Marker(
            markerId: marker1.markerId,
            position: marker1.position,
            draggable: marker1.draggable,
            icon: BitmapDescriptor.defaultMarker,
            onTap: () {
              if (Edit) {
                setState(() {
                  Edit = false;
                  activearrayname = previousselectedname;
                });
                print(activearrayname);
                _unselectMarkerTapped(marker1);
              } else {
                _onMarkerTapped(marker1);
                polygons.forEach((element) {
                  if (element.points.contains(marker1.position)) {
                    setState(() {
                      // previousselectedname=activearrayname!;
                      activearrayname = element.polygonId.value.toString();
                    });
                  }
                });
              }
            },
            onDragEnd: (newPosition) {
              _updatePolygonMarker(newPosition, newPositiondata);
            },
          );

          // final updatedMarker = marker.copyWith(
          //   positionParam: newPositiondata,
          //
          //   onDragEndParam: (newPosition) {
          //     _updatePolygonMarker(newPosition, newPositiondata);
          //   },
          // );
          element.marker.add(updatedMarker);
          _markers.add(updatedMarker);
          if (element.polygran != null) {
            polygons.remove(element.polygran);
          }
          if (element.mapboundrieslat.length > 2) {
            element.polygran = Polygon(
              polygonId: element.polygran!.polygonId,
              points: element.mapboundrieslat,
              fillColor: element.color!.withOpacity(0.5),
              strokeColor: Colors.blue,
              strokeWidth: 2,
            );
            polygons.add(element.polygran!);
          }
        });
        break;
      }
    }
  }

  polygrons(BuildContext context) {
    List<LatLng> allpolygronslatlangs = [];

    widget.polygrondata!.forEach((element) {
      allpolygronslatlangs.addAll(element.latlist);
      polygons.add(Polygon(
        polygonId: PolygonId(element.id.toString()),
        points: element.latlist,
        fillColor: Colors.yellow.withOpacity(0.5),
        strokeColor: Colors.blue,
        strokeWidth: 2,
        consumeTapEvents: true,
        onTap: () {
          print("manoj");
          int index = 0;
          var z = farmerarray
              .indexWhere((element) => element.name!.startsWith('p'));
          print("z value is $z");
          index = z;
          index++;
          print("mankfjknsfjk ${index}");

          if (direct) {
            polygons.forEach((polygrondele) {
              // setState(() {
              //   loading = true;
              // });
              if (int.parse(polygrondele.polygonId.value) == element.id) {
                List<Marker> markers = [];

                polygrondele.points.forEach((element) {
                  final marker = Marker(
                    markerId: MarkerId(element.toString()),
                    position: element,
                    draggable: true,
                    icon: BitmapDescriptor.defaultMarker,
                    onDragEnd: (newPosition) {
                      _updatePolygonMarker(newPosition, element);
                    },
                  );
                  final updatedMarker = Marker(
                    markerId: marker.markerId,
                    position: marker.position,
                    draggable: marker.draggable,
                    icon: BitmapDescriptor.defaultMarker,
                    onTap: () {
                      if (Edit) {
                        setState(() {
                          Edit = false;
                          activearrayname = previousselectedname;
                        });
                        _unselectMarkerTapped(marker);
                      } else {
                        _onMarkerTapped(marker);
                        polygons.forEach((element) {
                          if (element.points.contains(marker.position)) {
                            setState(() {
                              // previousselectedname=activearrayname!;
                              activearrayname =
                                  element.polygonId.value.toString();
                            });
                          }
                        });
                      }
                    },
                    onDragEnd: (newPosition) {
                      _updatePolygonMarker(newPosition, element);
                    },
                  );
                  markers.add(updatedMarker);
                });
                farmerarray.add(Farmarraay(
                  color: Colors.greenAccent,
                  marker: markers,
                  name: "plots$index",
                  mapboundrieslat: polygrondele.points,
                ));
              }
              // polygons=[];
              // setState(() {
              //   polygons.removeWhere((manok) => manok.polygonId==polygrondele.polygonId,);
              // });
            });
            farmerarray.forEach((element) {
              print("farmer array name ${element.name}");
              _markers.addAll(element.marker);
              if (element.mapboundrieslat.length > 2) {
                element.polygran = Polygon(
                    polygonId: PolygonId(element.name.toString()),
                    points: element.mapboundrieslat,
                    fillColor: element.color!.withOpacity(0.5),
                    strokeColor: Colors.blue,
                    strokeWidth: 2,
                    onTap: () {});
                polygons.add(element.polygran!);
              }
            });
            setState(() {
              loading = false;
            });
          } else {
            print("manoj");
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Builder(
                  builder: (BuildContext context) {
                    return AlertDialog(
                      // title: Text(''),
                      content: Text(
                          'Do you want to select this polygon and clear others?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            polygons.forEach((polygrondele) {
                              setState(() {
                                loading = true;
                              });
                              if (int.parse(polygrondele.polygonId.value) ==
                                  element.id) {
                                List<Marker> markers = [];

                                polygrondele.points.forEach((element) {
                                  final marker = Marker(
                                    markerId: MarkerId(element.toString()),
                                    position: element,
                                    draggable: true,
                                    icon: BitmapDescriptor.defaultMarker,
                                    onDragEnd: (newPosition) {
                                      _updatePolygonMarker(
                                          newPosition, element);
                                    },
                                  );
                                  final updatedMarker = Marker(
                                    markerId: marker.markerId,
                                    position: marker.position,
                                    draggable: marker.draggable,
                                    icon: BitmapDescriptor.defaultMarker,
                                    onTap: () {
                                      if (Edit) {
                                        setState(() {
                                          Edit = false;
                                          activearrayname =
                                              previousselectedname;
                                        });
                                        _unselectMarkerTapped(marker);
                                      } else {
                                        _onMarkerTapped(marker);
                                        polygons.forEach((element) {
                                          if (element.points
                                              .contains(marker.position)) {
                                            setState(() {
                                              // previousselectedname=activearrayname!;
                                              activearrayname = element
                                                  .polygonId.value
                                                  .toString();
                                            });
                                          }
                                        });
                                      }
                                    },
                                    onDragEnd: (newPosition) {
                                      _updatePolygonMarker(
                                          newPosition, element);
                                    },
                                  );
                                  markers.add(updatedMarker);
                                });
                                farmerarray.add(Farmarraay(
                                  color: Colors.red,
                                  marker: markers,
                                  name: "Farmland0",
                                  mapboundrieslat: polygrondele.points,
                                ));
                              }
                              polygons = [];
                            });
                            farmerarray.forEach((element) {
                              _markers.addAll(element.marker);
                              if (element.mapboundrieslat.length > 2) {
                                element.polygran = Polygon(
                                  polygonId: PolygonId(element.name.toString()),
                                  points: element.mapboundrieslat,
                                  fillColor: element.color!.withOpacity(0.5),
                                  strokeColor: Colors.blue,
                                  strokeWidth: 2,
                                );
                              }
                              polygons.add(element.polygran!);
                            });

                            setState(() {
                              loading = false;
                            });
                            // Perform an action when the button is pressed
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Ok',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Perform an action when the button is pressed

                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'NO',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          }
        },
      ));
    });
    calculatePolygonsCenter(allpolygronslatlangs);
  }

  var previousselectedname = '';

  void _onMapTapped(LatLng location) {
    print("index");
    print(previousselectedname);
    // if(!direct) {
    if (selectedItem != null &&
        selectedItem != 'TPR Sensor' &&
        selectedItem != 'DSR Sensor' &&
        selectedItem != 'AWD Sensor') {
      for (int f = 0; f < farmerarray.length; f++) {
        var element = farmerarray[f];
        if (Edit) {
          var index = element.mapboundrieslat.indexOf(editlatlg!);
          if (index != -1) {
            var editindex = ++index;
            element.mapboundrieslat.insert(editindex, location);
            final marker = Marker(
              markerId: MarkerId(location.toString()),
              position: location,
              draggable: true,
              icon: BitmapDescriptor.defaultMarker,
              onDragEnd: (newPosition) {
                _updatePolygonMarker(newPosition, location);
              },
            );
            final updatedMarker = Marker(
              markerId: marker.markerId,
              position: marker.position,
              draggable: marker.draggable,
              icon: BitmapDescriptor.defaultMarker,
              onTap: () {
                print("manoj ${Edit}");
                if (Edit) {
                  setState(() {
                    Edit = false;
                    activearrayname = previousselectedname;
                  });
                  _unselectMarkerTapped(marker);
                } else {
                  _onMarkerTapped(marker);
                  polygons.forEach((element) {
                    if (element.points.contains(marker.position)) {
                      setState(() {
                        // previousselectedname=activearrayname!;
                        activearrayname = element.polygonId.value.toString();
                      });
                    }
                  });
                }
              },
              onDragEnd: (newPosition) {
                _updatePolygonMarker(newPosition, location);
              },
            );
            element.marker.add(updatedMarker);
            break;
          }
        } else if (!Edit) {
          if (element.name == activearrayname) {
            element.mapboundrieslat.add(location);
            final marker = Marker(
              markerId: MarkerId(location.toString()),
              position: location,
              draggable: true,
              icon: BitmapDescriptor.defaultMarker,
              onDragEnd: (newPosition) {
                _updatePolygonMarker(newPosition, location);
              },
            );
            final updatedMarker = Marker(
              markerId: marker.markerId,
              position: marker.position,
              draggable: marker.draggable,
              icon: BitmapDescriptor.defaultMarker,
              onTap: () {
                print("manoj${Edit}");
                if (Edit) {
                  setState(() {
                    Edit = false;
                    activearrayname = previousselectedname;
                  });
                  _unselectMarkerTapped(marker);
                } else {
                  _onMarkerTapped(marker);
                  polygons.forEach((element) {
                    if (element.points.contains(marker.position)) {
                      setState(() {
                        // previousselectedname=activearrayname!;
                        activearrayname = element.polygonId.value.toString();
                      });
                    }
                  });
                }
              },
              onDragEnd: (newPosition) {
                _updatePolygonMarker(newPosition, location);
              },
            );
            element.marker.add(updatedMarker);
          }
        }
      }

      farmerarray.forEach((element) {
        if (element.mapboundrieslat.length > 2) {
          element.polygran = Polygon(
            polygonId: PolygonId(element.name.toString()),
            points: element.mapboundrieslat,
            fillColor: element.color!.withOpacity(0.5),
            strokeColor: Colors.blue,
            strokeWidth: 2,
          );
        }
        // var areadata=  Areacalculate(element.mapboundrieslat).t;

        if (element.mapboundrieslat.length > 2) {
          setState(() {
            // element.area=areadata;
            polygons.add(element.polygran!);
          });
        }
        element.marker.forEach((marker) {
          setState(() {
            _markers.add(marker);
          });
        });
      });
      Edit = false;
    } else if (selectedItem == 'DSR Sensor') {
      Polygon? closestPolygon = _findClosestPolygon(location);
      if (closestPolygon != null) {
        final updatedPolygons = polygons.map((polygon) {
          farmerarray.forEach((farmaray) {
            if (farmaray.polygran == closestPolygon) {
              final updatefarmerarray = farmaray.polygran?.copyWith(
                fillColorParam: Colors.green.withOpacity(0.5),
                // Set desired color here
                strokeColorParam: Colors.red, // Set desired color here
              );
              setState(() {
                farmaray.Plottype = 'DS';
                farmaray.Sensorlatlang =
                    LatLng(location.latitude, location.longitude);
                farmaray.color = Colors.green.withOpacity(0.5);
                farmaray.polygran = updatefarmerarray;
              });
            }
          });
          if (polygon.polygonId == closestPolygon.polygonId) {
            return polygon.copyWith(
              fillColorParam: Colors.green.withOpacity(0.5),
              // Set desired color here
              strokeColorParam: Colors.red, // Set desired color here
            );
          } else {
            return polygon;
          }
        }).toSet();
        final marker = Marker(
          markerId: MarkerId(location.toString()),
          position: location,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        );

        setState(() {
          polygons = [];
          _markers.add(marker);
          _sensormarker.add(marker);
          polygons.addAll(updatedPolygons);
        });
        print("^^^^^^^^^^^^^^^${closestPolygon.polygonId}");
      } else {
        if (!direct) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                // title: Text('Save Success'),
                content: Text('Sensor is outside Plot Area, cannot continue.'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          final marker = Marker(
            markerId: MarkerId(location.toString()),
            position: location,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
          );
          farmerarray.add(Farmarraay(
            mapboundrieslat: [],
            marker: [marker],
            Plottype: 'DS',
            Sensorlatlang: location,
            direct: true,
            name: "pLot${location}",
            area: 0,
          ));
          setState(() {
            _markers.add(marker);
            _sensormarker.add(marker);
          });
        }
      }
    } else if (selectedItem == 'TPR Sensor') {
      Polygon? closestPolygon = _findClosestPolygon(location);
      if (closestPolygon != null) {
        farmerarray.forEach((farmaray) {
          if (farmaray.polygran == closestPolygon) {
            final updatefarmerarray = farmaray.polygran?.copyWith(
              fillColorParam: Colors.yellow.withOpacity(0.5),
              // Set desired color here
              strokeColorParam: Colors.red, // Set desired color here
            );
            setState(() {
              farmaray.Plottype = 'TP';
              farmaray.Sensorlatlang =
                  LatLng(location.latitude, location.longitude);
              farmaray.color = Colors.yellow.withOpacity(0.5);
              farmaray.polygran = updatefarmerarray;
            });
          }
        });

        final updatedPolygons = polygons.map((polygon) {
          if (polygon.polygonId == closestPolygon.polygonId) {
            return polygon.copyWith(
              fillColorParam: Colors.yellow.withOpacity(0.5),
              // Set desired color here
              strokeColorParam: Colors.red, // Set desired color here
            );
          } else {
            return polygon;
          }
        }).toSet();
        final marker = Marker(
          markerId: MarkerId(location.toString()),
          position: location,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        );

        setState(() {
          polygons = [];
          _markers.add(marker);
          _sensormarker.add(marker);
          polygons.addAll(updatedPolygons);
        });
        print("^^^^^^^^^^^^^^^${closestPolygon.polygonId}");
      } else {
        if (!direct) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                // title: Text('Save Success'),
                content: Text('Sensor is outside Plot Area, cannot continue.'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          final marker = Marker(
            markerId: MarkerId(location.toString()),
            position: location,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueYellow),
          );
          farmerarray.add(Farmarraay(
            mapboundrieslat: [],
            marker: [marker],
            Plottype: 'TP',
            Sensorlatlang: location,
            direct: true,
            name: "pLot${location}",
            area: 0,
          ));
          setState(() {
            _markers.add(marker);
            _sensormarker.add(marker);
          });
        }
      }
    } else if (selectedItem == 'AWD Sensor') {
      Polygon? closestPolygon = _findClosestPolygon(location);
      if (closestPolygon != null) {
        farmerarray.forEach((farmaray) {
          if (farmaray.polygran == closestPolygon) {
            final updatefarmerarray = farmaray.polygran?.copyWith(
              fillColorParam: Colors.blueAccent.withOpacity(0.5),
              // Set desired color here
              strokeColorParam: Colors.red, // Set desired color here
            );
            setState(() {
              farmaray.Plottype = 'AP';
              farmaray.Sensorlatlang =
                  LatLng(location.latitude, location.longitude);
              farmaray.color = Colors.deepPurple.withOpacity(0.5);
              farmaray.polygran = updatefarmerarray;
            });
          }
        });

        final updatedPolygons = polygons.map((polygon) {
          if (polygon.polygonId == closestPolygon.polygonId) {
            return polygon.copyWith(
              fillColorParam: Colors.deepPurple.withOpacity(0.5),
              // Set desired color here
              strokeColorParam: Colors.red, // Set desired color here
            );
          } else {
            return polygon;
          }
        }).toSet();
        final marker = Marker(
          markerId: MarkerId(location.toString()),
          position: location,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
        );

        setState(() {
          polygons = [];
          _markers.add(marker);
          _sensormarker.add(marker);
          polygons.addAll(updatedPolygons);
        });
        print("^^^^^^^^^^^^^^^${closestPolygon.polygonId}");
      } else {
        if (!direct) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                // title: Text('Save Success'),
                content: Text('Sensor is outside Plot Area, cannot continue.'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          final marker = Marker(
            markerId: MarkerId(location.toString()),
            position: location,
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
          );
          farmerarray.add(Farmarraay(
            mapboundrieslat: [],
            marker: [marker],
            Plottype: 'AP',
            Sensorlatlang: location,
            direct: true,
            name: "pLot${location}",
            area: 0,
          ));
          setState(() {
            _markers.add(marker);
            _sensormarker.add(marker);
          });
        }
      }
    }
  }
  // else{
  //   print("ELse ");
  //   final marker = Marker(
  //     markerId: MarkerId(location.toString()),
  //     position: location,
  //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  //   );
  //   _markers.add(marker);
  // }

  // }
  // GoogleMapController? _mapController;
  double _compassDirection = 0.0;
  StreamSubscription<CompassEvent>? _compassSubscription;
  CameraPosition? _currentCameraPosition;

  void _initCompass() {
    _compassSubscription = FlutterCompass.events!.listen((CompassEvent event) {
      setState(() {
        _compassDirection = event.heading ?? 0.0;
      });
      _updateMapBearing();
    });
  }

  void _stopCompass() {
    _compassSubscription?.cancel();
    _compassSubscription = null;
    setState(() {
      _compassDirection = 0.0;
    });
    _updateMapBearing();
  }

  void _updateMapBearing() {
    if (_controller != null && _currentCameraPosition != null) {
      final updatedCameraPosition = CameraPosition(
        target: _currentCameraPosition!.target,
        zoom: _currentCameraPosition!.zoom,
        tilt: _currentCameraPosition!.tilt,
        bearing: _compassDirection,
      );
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(updatedCameraPosition),
      );
    }
  }

  // void _stopCompass() {
  //   if (_isListening) {
  //     FlutterCompass.events!.();
  //     _isListening = false;
  //   }
  // }

  late FlutterGifController gifcontroller;
  bool compase = false;
  void functioncompass() {
    if (compase) {
      _initCompass();
    } else {
      _stopCompass();
    }
  }

  bool loading = false;
  void initState() {
    // _initCompass();

    print("${widget.alreadyprcent}");
    print(widget.polygrondata != []);
    if (widget.alreadyprcent!.isNotEmpty || widget.polygrondata!.isNotEmpty) {
      alldata();
    } else {
      getCurrentLocation();
    }
    super.initState();
    gifcontroller = FlutterGifController(vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      gifcontroller.repeat(
        min: 0,
        max: 5,
        period: const Duration(milliseconds: 200),
      );
      polygrons(context);
    });

    // getCurrentLocation();
  }

  void _onMarkerTapped(Marker tappedMarker) {
    setState(() {
      Edit = true;
      editlatlg = tappedMarker.position;
      _markers = _markers.map((marker) {
        final isTappedMarker = marker == tappedMarker;

        final updatedIcon = isTappedMarker
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
            : BitmapDescriptor.defaultMarker;
        print(updatedIcon);
        return marker.copyWith(
          iconParam: updatedIcon,
        );
      }).toSet();
    });
  }

  void _unselectMarkerTapped(Marker tappedMarker) {
    setState(() {
      // editlatlg = tappedMarker.position;
      _markers = _markers.map((marker) {
        final isTappedMarker = marker == tappedMarker;

        final updatedIcon = isTappedMarker
            ? BitmapDescriptor.defaultMarker
            : BitmapDescriptor.defaultMarker;
        print(updatedIcon);
        return marker.copyWith(
          iconParam: updatedIcon,
        );
      }).toSet();
    });
  }

  // List<Marker> markerList = _markers.toList();

  Future<void> getCurrentLocation() async {
    setState(() {
      loading = true;
    });

    var result = await Permission.locationWhenInUse.request();
    if (result.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        // ,startLongitude:
        // _center =LatLng(11.073572, 78.014167);
        //
        _center = LatLng(position.latitude, position.longitude);
        loading = false;
      });
      print("latlanf${_center}");
    }
  }

  bool showMarkers = true;
  bool edit = false;
  List<String> items = [
    'Farmland',
    'Block',
    'Plot',
    'DSR Sensor',
    'TPR Sensor',
    'AWD Sensor'
  ];
  List<Farmarraay> farmerarray = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      //   appBar:  PreferredSize(
      //      preferredSize: Size.fromHeight(
      //      MediaQuery.of(context).size.height * 0.1, // Set the percentage of screen height for AppBar
      //  ), child:
      //
      //   AppBar(
      //     backgroundColor: Colors.grey.withOpacity(0.3),
      //     title: FractionallySizedBox(
      //
      //         child:
      //         Container(
      //           color: Colors.grey.withOpacity(0.3),
      //           height: 70,
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceAround,
      //             children: [
      //               Container(
      //                 width: MediaQuery.of(context).size.width * 0.25,
      //                   // height: 55,
      //
      //                   decoration: BoxDecoration(
      //                       color:markercolor,
      //                       border: Border.all(
      //                           color: markercolor
      //                       ),
      //                       borderRadius: BorderRadius.all(Radius.circular(10))
      //                   ),
      //                   margin: EdgeInsets.all(10),
      //                   child:  DropdownButtonHideUnderline(
      //                     child: DropdownButton<String>(
      //                       hint: Text(
      //                         'Select Type',
      //                         style: TextStyle(
      //                           fontSize: 14,
      //                           color: Theme.of(context).hintColor,
      //                         ),
      //                       ),
      //                       items: items.map((item) {
      //                         return DropdownMenuItem<String>(
      //                           value: item, // Use the item itself as the value
      //                           child: Text(
      //                             item,
      //                             style: TextStyle(
      //                               fontSize: 14,
      //                             ),
      //                           ),
      //                         );
      //                       }).toList(),
      //                       value: selectedItem,
      //
      //                       onChanged: ( String? value) {
      //                           if(value=='Farmland') {
      //                             if (farmerarray.length == 0) {
      //                               farmerarray.add(Farmarraay(
      //                                 color: Colors.red,
      //                                 name: '${value}',
      //                                 mapboundrieslat: [],
      //                                 marker: []
      //                               ));
      //                               setState(() {
      //                                 previousselectedname='${value}';
      //                                 activearrayname='${value}';
      //                               });
      //                             }
      //                             else {
      //                               int farmlandarray = 0;
      //                               farmerarray.forEach((element) {
      //                                 if (element.name!.startsWith('F')) {
      //                                   setState(() {
      //                                     farmlandarray++;
      //                                   });
      //                                 }
      //                               });
      //                               farmerarray.add(Farmarraay(
      //                                 color: Colors.red,
      //                                 marker: [],
      //                                   name: "${value}${farmlandarray}",
      //                              mapboundrieslat: [],
      //                               ),
      //
      //                               );
      //                               setState(() {
      //                              previousselectedname="${value}${farmlandarray}";
      //                                 activearrayname="${value}${farmlandarray}";
      //                               });
      //                             }
      //
      //                           }
      //                           else if (value=='Block'){
      //                             if(farmerarray.length==0){
      //                               farmerarray.add(Farmarraay(
      //                                   color: Colors.blue,
      //                                 name:'${value}',
      //                                 mapboundrieslat: [],
      //                                 marker: []
      //                               ));
      //                               setState(() {
      //                                 previousselectedname='${value}';
      //                                 activearrayname='${value}';
      //                               });
      //                             }
      //                             else {
      //                               int blockarray = 0;
      //                               farmerarray.forEach((element) {
      //                                 if (element.name!.startsWith('B')) {
      //                                   setState(() {
      //                                     blockarray++;
      //                                   });
      //                                 }
      //                               });
      //                               farmerarray.add(Farmarraay(
      //                                 marker: [],
      //                                   color: Colors.blue,
      //                                   mapboundrieslat: [],
      //                                   name: "${value}${blockarray}"));
      //                               setState(() {
      //                                 previousselectedname="${value}${blockarray}";
      //                                 activearrayname="${value}${blockarray}";
      //                               });
      //                             }
      //                           }
      //                           else if (value=='Plot'){
      //                             if(farmerarray.length==0){
      //                               farmerarray.add(Farmarraay(
      //                                 color: Colors.grey,
      //                                 mapboundrieslat: [],
      //                                 name:'${value}',
      //                                 marker: [],
      //                               ));
      //                               setState(() {
      //                                 previousselectedname="${value}";
      //                                 activearrayname="${value}";
      //                               });
      //                             }
      //                             else {
      //                               int plotsarray = 0;
      //                               farmerarray.forEach((element) {
      //                                 if (element.name!.startsWith('P')) {
      //                                   setState(() {
      //                                     plotsarray++;
      //                                   });
      //                                 }
      //                               });
      //                               farmerarray.add(Farmarraay(
      //                                   mapboundrieslat: [],
      //                                   marker: [],
      //                                   color: Colors.grey,
      //                                   name: "${value}${plotsarray}"));
      //                               setState(() {
      //                                 previousselectedname="${value}${plotsarray}";
      //                                 activearrayname="${value}${plotsarray}";
      //                               });
      //                             }
      //                           }
      //                         //   else if (value=='Sensor'){
      //                         //     if(farmerarray.length==0){
      //                         //       farmerarray.add(Farmarraay(
      //                         //         marker: [],
      //                         //         color: Colors.greenAccent,
      //                         //         mapboundrieslat: [],
      //                         //         name:'${value}',
      //                         //       ));
      //                         //       setState(() {
      //                         //         activearrayname="${value}";
      //                         //       });
      //                         //     }
      //                         //     else {
      //                         //       int Senosr = 0;
      //                         //       farmerarray.forEach((element) {
      //                         //         if (element.name!.startsWith('S')) {
      //                         //           setState(() {
      //                         //             Senosr++;
      //                         //           });
      //                         //         }
      //                         //       });
      //                         //       farmerarray.add(Farmarraay(
      //                         //         marker: [],
      //                         //           color: Colors.greenAccent,
      //                         //           mapboundrieslat: [],
      //                         //           name: "${value}${Senosr}"));
      //                         //       setState(() {
      //                         //         activearrayname="${value}${Senosr}";
      //                         //       });
      //                         //     }
      //                         //   }
      //                         //   else {
      //                         //     if(farmerarray.length==0){
      //                         //       farmerarray.add(Farmarraay(
      //                         //         marker: [],
      //                         //         color: Colors.greenAccent,
      //                         //         mapboundrieslat: [],
      //                         //         name:'${value}',
      //                         //       ));
      //                         //       setState(() {
      //                         //         activearrayname="${value}";
      //                         //       });
      //                         //     }
      //                         //     else {
      //                         //       int VSenosr = 0;
      //                         //       farmerarray.forEach((element) {
      //                         //         if (element.name!.startsWith('V')) {
      //                         //           setState(() {
      //                         //             VSenosr++;
      //                         //           });
      //                         //         }
      //                         //       });
      //                         //       farmerarray.add(Farmarraay(
      //                         //         marker: [],
      //                         //           color: Colors.greenAccent,
      //                         //           mapboundrieslat: [],
      //                         //           name: "${value}${++VSenosr}"));
      //                         //       setState(() {
      //                         //         activearrayname="${value}${++VSenosr}";
      //                         //       });
      //                         //     }
      //                         // }
      //                         setState(() {
      //                           // previousselectedname="${value}";
      //                           // activearrayname="${value}";
      //                           selectedItem = value ;
      //                         });
      //                       },
      //
      //
      //
      //                     ),
      //
      //                   ),
      //
      //               ),
      //
      //               // Column(
      //               //   children: [
      //               Visibility(
      //                 visible: _markers.length>0,
      //                 child:InkWell(
      //                   onTap: (){
      //                     // List<Marker> myList = _markers.toList();
      //                     setState(() {
      //                       print("&&&&&&&&&&${activearrayname}");
      //                       farmerarray.forEach((element) {
      //                         print(element.name);
      //                         if(element.name==activearrayname){
      //
      //                           // setState(() {
      //
      //                            setState(() {
      //                             // var contain= element.mapboundrieslat.contains(_markers.last);
      //                             // if(contain){
      //                              element.marker.removeLast();
      //                               element.mapboundrieslat.removeLast();
      //                             // }
      //                              _markers.remove(_markers.last);
      //
      //                            });
      //                             int lemgth=element!.mapboundrieslat!.length!;
      //
      //                            Set<Polygon>.of(polygons).forEach((polygram){
      //                              if(polygram.polygonId.value==element.name.toString()){
      //                                polygons.remove(polygram);
      //                                element.polygran=null;
      //                              }
      //                            }
      //                            );
      //                             if(lemgth >2) {
      //                               print('inside if ');
      //                               element.polygran = Polygon(
      //                                 polygonId: PolygonId(element.name.toString()),
      //                                 zIndex: markercolor == Colors.red ? 1 : markercolor ==
      //                                     Colors.blue ? 0 : 2,
      //                                 points: element.mapboundrieslat!,
      //                                 strokeWidth: 2,
      //                                 strokeColor: Colors.blue,
      //                                 fillColor: color,
      //
      //                               );
      //
      //
      //
      //                               polygons.add(element!.polygran!);
      //                             }
      //
      //
      //                           // });
      //
      //
      //                         }
      //                       });
      //
      //
      //                     });
      //                   },
      //                   child: Container(
      //                     decoration: BoxDecoration(
      //                         color:markercolor,
      //                         border: Border.all(
      //                             color: markercolor
      //                         ),
      //                         borderRadius: BorderRadius.all(Radius.circular(10))
      //                     ),
      //                     margin: EdgeInsets.all(5),
      //                     height: 40,
      //                     width: 50,
      //
      //                     child: Column(
      //                       children: [
      //                         Icon(Icons.undo,color: Colors.white,size: 15),
      //                        Flexible(child:  Text("Undo",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize:14),))
      //                       ],
      //                     ),
      //                   ),
      //                 ),),
      //               Visibility(
      //                 visible: _markers.length>0,
      //                 child: InkWell(
      //                   onTap: (){
      //                     setState(() {
      //                       _markers.clear();
      //                       farmerarray=[];
      //                       polygons.clear();
      //                     });
      //                   },
      //                   child: Container(
      //                     decoration: BoxDecoration(
      //                         color:Colors.red,
      //                         border: Border.all(
      //                             color: Colors.red
      //                         ),
      //                         borderRadius: BorderRadius.all(Radius.circular(10))
      //                     ),
      //                     margin: EdgeInsets.all(5),
      //                     height: 40,
      //                     width: 50,
      //
      //                     child: Icon(Icons.delete,color: Colors.white,size: 25),
      //                   ),
      //                 ),
      //               ),
      //               Column(
      //                 children: [
      //                   Text("marker"),
      //                   Switch(
      //                       value: showMarkers, onChanged: (value){
      //                     setState(() {
      //                       showMarkers=!showMarkers;
      //                     });
      //                   })
      //                 ],
      //               )
      //
      //
      //             ],
      //           ),
      //         )),
      //   ),
      // // AppBar(
      // //   backgroundColor: Colors.grey.withOpacity(0.3),
      // //    title: FractionallySizedBox(
      // //      child: Container(
      // //        color: Colors.grey.withOpacity(0.3),
      // //        height: 70,
      // //        child: Row(
      // //          mainAxisAlignment: MainAxisAlignment.spaceAround,
      // //          children: [
      // //            Container(
      // //              width: MediaQuery.of(context).size.width * 0.25,
      // //              decoration: BoxDecoration(
      // //                color: markercolor,
      // //                border: Border.all(color: markercolor),
      // //                borderRadius: BorderRadius.all(Radius.circular(10)),
      // //              ),
      // //              margin: EdgeInsets.all(10),
      // //              child: DropdownButtonHideUnderline(
      // //                child: DropdownButton<String>(
      // //                  hint: Text(
      // //                    'Select Type',
      // //                    style: TextStyle(
      // //                      fontSize: MediaQuery.of(context).size.width * 0.035, // Adjust the font size
      // //                      color: Theme.of(context).hintColor,
      // //                    ),
      // //                  ),
      // //                  items: items.map((item) {
      // //                    return DropdownMenuItem<String>(
      // //                      value: item, // Use the item itself as the value
      // //                      child: Text(
      // //                        item,
      // //                        style: TextStyle(
      // //                          fontSize: MediaQuery.of(context).size.width * 0.035, // Adjust the font size
      // //                        ),
      // //                      ),
      // //                    );
      // //                  }).toList(),
      // //                  value: selectedItem,
      // //                  onChanged: (String? value) {
      // //                    // Rest of your code
      // //                  },
      // //                ),
      // //              ),
      // //            ),
      // //            Visibility(
      // //              visible: _markers.length > 0,
      // //              child: InkWell(
      // //                onTap: () {
      // //                  // Rest of your code
      // //                },
      // //                child: Container(
      // //                  decoration: BoxDecoration(
      // //                    color: markercolor,
      // //                    border: Border.all(color: markercolor),
      // //                    borderRadius: BorderRadius.all(Radius.circular(10)),
      // //                  ),
      // //                  margin: EdgeInsets.all(5),
      // //                  height: MediaQuery.of(context).size.height * 0.056, // Adjust the height
      // //                  width: MediaQuery.of(context).size.width * 0.06, // Adjust the width
      // //                  child: Column(
      // //                    children: [
      // //                      Icon(Icons.undo, color: Colors.white, size: MediaQuery.of(context).size.width * 0.03), // Adjust the icon size
      // //                      Text(
      // //                        "Undo",
      // //                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      // //                      )
      // //                    ],
      // //                  ),
      // //                ),
      // //              ),
      // //            ),
      // //            Visibility(
      // //              visible: _markers.length > 0,
      // //              child: InkWell(
      // //                onTap: () {
      // //                  // Rest of your code
      // //                },
      // //                child: Container(
      // //                  decoration: BoxDecoration(
      // //                    color: Colors.red,
      // //                    border: Border.all(color: Colors.red),
      // //                    borderRadius: BorderRadius.all(Radius.circular(10)),
      // //                  ),
      // //                  margin: EdgeInsets.all(5),
      // //                  height: MediaQuery.of(context).size.height * 0.056, // Adjust the height
      // //                  width: MediaQuery.of(context).size.width * 0.06, // Adjust the width
      // //                  child: Icon(Icons.delete, color: Colors.white, size: MediaQuery.of(context).size.width * 0.04), // Adjust the icon size
      // //                ),
      // //              ),
      // //            ),
      // //            Column(
      // //              children: [
      // //                Text("marker"),
      // //                Switch(value: showMarkers, onChanged: (value) {
      // //                  // Rest of your code
      // //                }),
      // //              ],
      // //            ),
      // //          ],
      // //        ),
      // //      ),
      // //    ),
      // //  ),
      //
      //  ),
      drawer: Drawer(
        child: ListView(
          // physics: AlwaysScrollableScrollPhysics(),
          // controller: _scrolcontroller,
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Selected Land Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: farmerarray.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (farmerarray[index].polygran != null) {
                        double acres = 0;
                        if (farmerarray[index].mapboundrieslat.length > 0) {
                          var area =
                              Areacalculate(farmerarray[index].mapboundrieslat);
                          acres = area / 4046.85642;
                        }
                        return Card(
                          child: ListTile(
                            title: Text(
                                farmerarray[index].polygran!.polygonId.value),
                            trailing:
                                Text("acres: ${acres.toStringAsFixed(2)}"),
                          ),
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  GoogleMap(
                    mapType: satilite ? MapType.satellite : MapType.normal,
                    // Set the initial camera position
                    initialCameraPosition: CameraPosition(
                      // bearing: _compassDirection,
                      target: _center,
                      zoom: widget.data.length > 2 ? 18 : 11,
                    ),
                    compassEnabled: false,
                    rotateGesturesEnabled: false,
                    minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                    polygons: Set<Polygon>.of(polygons),

                    // polylines: _polylines,
                    // Set the markers on the map
                    markers:
                        showMarkers ? Set<Marker>.of(_markers) : _sensormarker,

                    // Handle tap events on the map
                    onTap: _onMapTapped,
                    myLocationButtonEnabled: true,

                    onCameraMove: (position) {
                      _currentCameraPosition = position;
                    },
                    padding: EdgeInsets.only(
                      top: 180.0,
                    ),
                    // onCameraMove: _onCameraMove,

                    // Get the map controller
                    onMapCreated: (GoogleMapController controller) {
                      _controller = controller;
                      // _controller!.setMapStyle(
                      //   '[{"stylers":[{"hue":"#ff1a00"},{"invert_lightness":true},{"saturation":-100},{"lightness":33},{"gamma":0.5}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#2D333C"}]}]',
                      // ); // Apply a custom map style (optional)
                      // _initCompass();
                    },
                    myLocationEnabled: true,
                  ),
                  Positioned(
                      top: 80,
                      left: 10,
                      right: 10, // Adjust the top value as needed
                      // left: 5, // Adjust the left value as needed
                      child: Container(
                        height: 70,
                        // margin: EdgeInsets.only(left: 10,right: 40),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.12,
                              child: IconButton(
                                icon: Icon(Icons.menu),
                                onPressed: () {
                                  _scaffoldKey.currentState?.openDrawer();
                                },
                              ),
                            ),
                            widget.alreadyprcent != [] ||
                                    widget.alreadyprcent != null
                                ? Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.30,
                                    // height: 55,

                                    decoration: BoxDecoration(
                                        color: markercolor,
                                        border: Border.all(color: markercolor),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    margin: EdgeInsets.all(10),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        hint: Text(
                                          'Select Type',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Theme.of(context).hintColor,
                                          ),
                                        ),
                                        items: items.map((item) {
                                          return DropdownMenuItem<String>(
                                            value:
                                                item, // Use the item itself as the value
                                            child: Text(
                                              " $item",
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        value: selectedItem,
                                        onChanged: (String? value) {
                                          if (value == 'Farmland') {
                                            if (farmerarray.length == 0) {
                                              farmerarray.add(Farmarraay(
                                                  color: Colors.red,
                                                  name: '${value}',
                                                  mapboundrieslat: [],
                                                  marker: []));
                                              setState(() {
                                                previousselectedname =
                                                    '${value}';
                                                activearrayname = '${value}';
                                              });
                                            } else {
                                              int farmlandarray = 0;
                                              farmerarray.forEach((element) {
                                                if (element.name!
                                                    .startsWith('F')) {
                                                  setState(() {
                                                    farmlandarray++;
                                                  });
                                                }
                                              });
                                              farmerarray.add(
                                                Farmarraay(
                                                  color: Colors.red,
                                                  marker: [],
                                                  name:
                                                      "${value}${farmlandarray}",
                                                  mapboundrieslat: [],
                                                ),
                                              );
                                              setState(() {
                                                previousselectedname =
                                                    "${value}${farmlandarray}";
                                                activearrayname =
                                                    "${value}${farmlandarray}";
                                              });
                                            }
                                          } else if (value == 'Block') {
                                            if (farmerarray.length == 0) {
                                              farmerarray.add(Farmarraay(
                                                  color: Colors.blue,
                                                  name: '${value}',
                                                  mapboundrieslat: [],
                                                  marker: []));
                                              setState(() {
                                                previousselectedname =
                                                    '${value}';
                                                activearrayname = '${value}';
                                              });
                                            } else {
                                              int blockarray = 0;
                                              farmerarray.forEach((element) {
                                                if (element.name!
                                                    .startsWith('B')) {
                                                  setState(() {
                                                    blockarray++;
                                                  });
                                                }
                                              });
                                              farmerarray.add(Farmarraay(
                                                  marker: [],
                                                  color: Colors.blue,
                                                  mapboundrieslat: [],
                                                  name:
                                                      "${value}${blockarray}"));
                                              setState(() {
                                                previousselectedname =
                                                    "${value}${blockarray}";
                                                activearrayname =
                                                    "${value}${blockarray}";
                                              });
                                            }
                                          } else if (value == 'Plot') {
                                            if (farmerarray.length == 0) {
                                              farmerarray.add(Farmarraay(
                                                color: Colors.grey,
                                                mapboundrieslat: [],
                                                name: '${value}',
                                                marker: [],
                                              ));
                                              setState(() {
                                                previousselectedname =
                                                    "${value}";
                                                activearrayname = "${value}";
                                              });
                                            } else {
                                              int plotsarray = 0;
                                              farmerarray.forEach((element) {
                                                if (element.name!
                                                    .startsWith('P')) {
                                                  setState(() {
                                                    plotsarray++;
                                                  });
                                                }
                                              });
                                              farmerarray.add(Farmarraay(
                                                  mapboundrieslat: [],
                                                  marker: [],
                                                  color: Colors.grey,
                                                  name:
                                                      "${value}${plotsarray}"));
                                              setState(() {
                                                previousselectedname =
                                                    "${value}${plotsarray}";
                                                activearrayname =
                                                    "${value}${plotsarray}";
                                              });
                                            }
                                          }
                                          //   else if (value=='Sensor'){
                                          //     if(farmerarray.length==0){
                                          //       farmerarray.add(Farmarraay(
                                          //         marker: [],
                                          //         color: Colors.greenAccent,
                                          //         mapboundrieslat: [],
                                          //         name:'${value}',
                                          //       ));
                                          //       setState(() {
                                          //         activearrayname="${value}";
                                          //       });
                                          //     }
                                          //     else {
                                          //       int Senosr = 0;
                                          //       farmerarray.forEach((element) {
                                          //         if (element.name!.startsWith('S')) {
                                          //           setState(() {
                                          //             Senosr++;
                                          //           });
                                          //         }
                                          //       });
                                          //       farmerarray.add(Farmarraay(
                                          //         marker: [],
                                          //           color: Colors.greenAccent,
                                          //           mapboundrieslat: [],
                                          //           name: "${value}${Senosr}"));
                                          //       setState(() {
                                          //         activearrayname="${value}${Senosr}";
                                          //       });
                                          //     }
                                          //   }
                                          //   else {
                                          //     if(farmerarray.length==0){
                                          //       farmerarray.add(Farmarraay(
                                          //         marker: [],
                                          //         color: Colors.greenAccent,
                                          //         mapboundrieslat: [],
                                          //         name:'${value}',
                                          //       ));
                                          //       setState(() {
                                          //         activearrayname="${value}";
                                          //       });
                                          //     }
                                          //     else {
                                          //       int VSenosr = 0;
                                          //       farmerarray.forEach((element) {
                                          //         if (element.name!.startsWith('V')) {
                                          //           setState(() {
                                          //             VSenosr++;
                                          //           });
                                          //         }
                                          //       });
                                          //       farmerarray.add(Farmarraay(
                                          //         marker: [],
                                          //           color: Colors.greenAccent,
                                          //           mapboundrieslat: [],
                                          //           name: "${value}${++VSenosr}"));
                                          //       setState(() {
                                          //         activearrayname="${value}${++VSenosr}";
                                          //       });
                                          //     }
                                          // }
                                          setState(() {
                                            // previousselectedname="${value}";
                                            // activearrayname="${value}";
                                            selectedItem = value;
                                          });
                                        },
                                      ),
                                    ),
                                  )
                                : SizedBox(),

                            // Column(
                            //   children: [
                            widget.alreadyprcent!.isEmpty
                                ? Visibility(
                                    visible: _markers.length > 0,
                                    child: InkWell(
                                      onTap: () {
                                        // List<Marker> myList = _markers.toList();
                                        setState(() {
                                          print("&&&&&&&&&&${activearrayname}");
                                          farmerarray.forEach((element) {
                                            print(element.name);
                                            if (element.name ==
                                                activearrayname) {
                                              // setState(() {

                                              setState(() {
                                                // var contain= element.mapboundrieslat.contains(_markers.last);
                                                // if(contain){
                                                element.marker.removeLast();
                                                element.mapboundrieslat
                                                    .removeLast();
                                                // }
                                                _markers.remove(_markers.last);
                                              });
                                              int lemgth = element
                                                  .mapboundrieslat.length;

                                              Set<Polygon>.of(polygons)
                                                  .forEach((polygram) {
                                                if (polygram.polygonId.value ==
                                                    element.name.toString()) {
                                                  polygons.remove(polygram);
                                                  element.polygran = null;
                                                }
                                              });
                                              if (lemgth > 2) {
                                                print('inside if ');
                                                element.polygran = Polygon(
                                                  polygonId: PolygonId(
                                                      element.name.toString()),
                                                  zIndex:
                                                      markercolor == Colors.red
                                                          ? 1
                                                          : markercolor ==
                                                                  Colors.blue
                                                              ? 0
                                                              : 2,
                                                  points:
                                                      element.mapboundrieslat,
                                                  strokeWidth: 2,
                                                  strokeColor: Colors.blue,
                                                  fillColor: color,
                                                );

                                                polygons.add(element.polygran!);
                                              }

                                              // });
                                            }
                                          });
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: markercolor,
                                            border:
                                                Border.all(color: markercolor),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        margin: EdgeInsets.all(5),
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.12,
                                        child: Column(
                                          children: [
                                            Icon(Icons.undo,
                                                color: Colors.white, size: 15),
                                            Flexible(
                                                child: Text(
                                              "Undo",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            widget.alreadyprcent != null ||
                                    widget.alreadyprcent != []
                                ? Visibility(
                                    visible: _markers.length > 0,
                                    child: InkWell(
                                      onTap: () {
                                        farmerarray.removeWhere((element) =>
                                            element.name == activearrayname);
                                        setState(() {
                                          _markers.clear();
                                          polygons.clear();
                                        });

                                        farmerarray.forEach((element) {
                                          _markers.addAll(element.marker);
                                          Polygon? poly = element.polygran;
                                          if (poly != null) {
                                            polygons.add(poly);
                                          }
                                        });

                                        // setState(() {
                                        // var iterator = farmerarray.listIterator();

                                        // farmerarray.forEach((element) {
                                        //   print(element.name);
                                        //   if(element.name==activearrayname){
                                        //
                                        //     Set<Polygon>.of(polygons).forEach((polygram) {
                                        //       if (polygram.polygonId.value == element.name.toString()) {
                                        //         polygons.remove(polygram);
                                        //         element.polygran = null;
                                        //       }
                                        //     });
                                        //     // setState(() {
                                        //
                                        //     setState(() {
                                        //       polygons.removeWhere((polgron) => polgron.polygonId== element.polygran?.polygonId);
                                        //       _markers.removeAll(element.marker);
                                        //       farmerarray.removeWhere((elem) => elem.name==element.name,);
                                        //
                                        //       // farmerarray.remove(element);
                                        //
                                        //     });
                                        //     //
                                        //     // int lemgth=element!.mapboundrieslat!.length!;
                                        //     //
                                        //
                                        //     // );
                                        //     // if(lemgth >2) {
                                        //     //   print('inside if ');
                                        //     //   element.polygran = Polygon(
                                        //     //     polygonId: PolygonId(element.name.toString()),
                                        //     //     zIndex: markercolor == Colors.red ? 1 : markercolor ==
                                        //     //         Colors.blue ? 0 : 2,
                                        //     //     points: element.mapboundrieslat!,
                                        //     //     strokeWidth: 2,
                                        //     //     strokeColor: Colors.blue,
                                        //     //     fillColor: color,
                                        //     //
                                        //     //   );
                                        //     //
                                        //     //
                                        //     //
                                        //     //   polygons.add(element!.polygran!);
                                        //     // }
                                        //
                                        //
                                        //     // });
                                        //
                                        //
                                        //   }
                                        // });

                                        //
                                        // _markers.clear();
                                        //
                                        // polygons.clear();
                                        // });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            border:
                                                Border.all(color: Colors.red),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        margin: EdgeInsets.all(5),
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.12,
                                        child: Icon(Icons.delete,
                                            color: Colors.white, size: 25),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            widget.alreadyprcent != null ||
                                    widget.alreadyprcent != []
                                ? Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.12,
                                    child: Column(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "marker",
                                            maxLines: 1,
                                          ),
                                        ),
                                        Switch(
                                            activeColor: Colors.red,
                                            // inactiveTrackColor: Colors.red,
                                            value: showMarkers,
                                            onChanged: (value) {
                                              setState(() {
                                                showMarkers = !showMarkers;
                                              });
                                            })
                                      ],
                                    ),
                                  )
                                : SizedBox()
                          ],
                        ),
                      )),
                  Positioned(
                    right: 10,
                    bottom: 220,
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        // shape: BoxShape.circle,
                        color: HexColor('#3e3e3d'),
                      ),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Image.asset(
                              'assets/images/compassenge.png',
                              height: 30,
                            ),
                            Transform.scale(
                              scale: 0.8,
                              child: Switch(
                                value: compase,
                                inactiveTrackColor: Colors.red,
                                activeColor: Colors.green,
                                onChanged: (bool value1) {
                                  setState(() {
                                    compase = value1;
                                  });
                                  functioncompass();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      right: 8,
                      bottom: 150,
                      child: Container(
                        alignment: Alignment.bottomRight,
                        margin: EdgeInsets.only(right: 8, bottom: 150),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              satilite = !satilite;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            width: 60,
                            height: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: HexColor('#3e3e3d'),
                              border: Border.all(color: Colors.white),
                            ),
                            child: Center(
                              child: Text(
                                satilite ? "Normal" : "Satellite",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )),
                  Visibility(
                    visible: widget.alreadyprcent!.isEmpty,
                    child: Positioned(
                        left: 8,
                        bottom: 150,
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                            ),
                            // shape: BoxShape.circle,
                            color: HexColor('#3e3e3d'),
                          ),
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Direct",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Transform.scale(
                                  scale: 0.8,
                                  child: Switch(
                                    value: direct,
                                    inactiveTrackColor: Colors.red,
                                    activeColor: Colors.green,
                                    onChanged: (bool value1) {
                                      setState(() {
                                        direct = value1;
                                        loading = true;
                                        polygons = [];
                                      });
                                      var id = 0;
                                      if (value1) {
                                        widget.polygrondata!.forEach((element) {
                                          id++;
                                          farmerarray.add(Farmarraay(
                                            color: Colors.red,
                                            marker: [],
                                            name: "plot$id",
                                            mapboundrieslat: element.latlist,
                                          ));
                                        });
                                        // farmerarray.forEach((mapbondries) {
                                        //
                                        //   mapbondries.mapboundrieslat.forEach((markerone) {
                                        //     final marker = Marker(
                                        //       markerId: MarkerId(markerone.toString()),
                                        //       position: markerone,
                                        //       draggable: true,
                                        //       icon: BitmapDescriptor.defaultMarker,
                                        //       onDragEnd: (newPosition) {
                                        //         _updatePolygonMarker(
                                        //             newPosition, markerone);
                                        //       },
                                        //     );
                                        //     final updatedMarker = Marker(
                                        //       markerId: marker.markerId,
                                        //       position: marker.position,
                                        //       draggable: marker.draggable,
                                        //       icon: BitmapDescriptor.defaultMarker,
                                        //       onTap: () {
                                        //         if (Edit) {
                                        //           setState(() {
                                        //             Edit = false;
                                        //             activearrayname =
                                        //                 previousselectedname;
                                        //           });
                                        //           _unselectMarkerTapped(marker);
                                        //         }
                                        //         else {
                                        //           _onMarkerTapped(marker);
                                        //           polygons.forEach((element) {
                                        //             if (element.points.contains(
                                        //                 marker.position)) {
                                        //               setState(() {
                                        //                 // previousselectedname=activearrayname!;
                                        //                 activearrayname =
                                        //                     element.polygonId.value
                                        //                         .toString();
                                        //               });
                                        //             }
                                        //           });
                                        //         }
                                        //       },
                                        //       onDragEnd: (newPosition) {
                                        //         _updatePolygonMarker(
                                        //             newPosition, markerone);
                                        //       },
                                        //     );
                                        //     mapbondries.marker.add(updatedMarker);
                                        //   });
                                        // });

                                        farmerarray.forEach((element) {
                                          _markers.addAll(element.marker);
                                          if (element.mapboundrieslat.length >
                                              2) {
                                            element.polygran = Polygon(
                                              polygonId: PolygonId(
                                                  element.name.toString()),
                                              points: element.mapboundrieslat,
                                              fillColor: element.color!
                                                  .withOpacity(0.5),
                                              strokeColor: Colors.blue,
                                              strokeWidth: 2,
                                            );
                                          }
                                          polygons.add(element.polygran!);
                                        });
                                      } else {
                                        farmerarray = [];
                                        polygrons(context);
                                      }

                                      setState(() {
                                        loading = false;
                                      });

                                      // functioncompass();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                  Visibility(
                    visible: farmerarray.length == 0
                        ? false
                        : hasRecordWithLengthGreaterThan3(farmerarray),
                    child: Positioned(
                        bottom: 10,
                        left: 40,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 4,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: TextButton(
                              onPressed: () async {
                                if (widget.incerpermission ?? false) {
                                  try {
                                    setState(() {
                                      loading = true;
                                    });
                                    if (!direct) {
                                      List<bool> successlistFarmland = [];
                                      List<bool> successlistBlcok = [];
                                      List<bool> successlistPlot = [];
                                      List<Farmlandall> allfarmlandslist = [];
                                      List<Farmarraay> farmlands = [];
                                      List<Farmarraay> blocks = [];
                                      List<Farmarraay> plots = [];

                                      farmerarray.forEach((farm) {
                                        if (farm.name!.startsWith('F')) {
                                          if (farmlands.contains(farm.name)) {
                                          } else {
                                            farm.inrange = true;
                                            if (farm.mapboundrieslat.length >
                                                2) {
                                              farmlands.add(farm);
                                            }
                                          }
                                        } else if (farm.name!.startsWith('B')) {
                                          if (blocks.contains(farm.name)) {
                                          } else {
                                            if (farm.mapboundrieslat.length >
                                                2) {
                                              blocks.add(farm);
                                            }
                                          }
                                        } else if (farm.name!.startsWith('P')) {
                                          if (plots.contains(farm.name)) {
                                          } else {
                                            if (farm.mapboundrieslat.length >
                                                2) {
                                              plots.add(farm);
                                            }
                                          }
                                        }
                                        // }
                                      });

                                      List<Farmarraay> removeDuplicates(
                                          List<Farmarraay> models) {
                                        final uniqueModels =
                                            models.toSet().toList();
                                        return uniqueModels;
                                      }

                                      List<Farmarraay> uniqueList =
                                          removeDuplicates(farmlands);
                                      List<Farmarraay> blockslist =
                                          removeDuplicates(blocks);
                                      List<Farmarraay> plotslist =
                                          removeDuplicates(plots);

                                      var isreturn = await hasreord(
                                          uniqueList, blockslist, plotslist);

                                      if (isreturn) {
                                        for (int i = 0;
                                            i < uniqueList.length;
                                            i++) {
                                          List<Blockdetailsarray> blocksarray =
                                              [];
                                          if (uniqueList[i]
                                                  .mapboundrieslat
                                                  .length >
                                              2) {
                                            var FarmID =
                                                await SaveFarmlandDetails(
                                                    widget.accausation
                                                        ? widget
                                                            .farmeracussationid
                                                        : widget
                                                            .data[0].farmerID,
                                                    uniqueList[i].name,
                                                    Areacalculate(uniqueList[i]
                                                        .mapboundrieslat),
                                                    uniqueList[i]
                                                        .polygran!
                                                        .points
                                                        .toString());
                                            if (i != uniqueList.length - 1) {
                                              if (FarmID != 0) {
                                                successlistFarmland.add(true);
                                              }
                                            } else {
                                              successlistFarmland.add(true);
                                              var valueplots = successlistPlot
                                                  .where((element) => true);
                                              var valueblocks = successlistBlcok
                                                  .where((element) => true);
                                              var valuefarmland =
                                                  successlistFarmland
                                                      .where((element) => true);
                                              if (plots.length ==
                                                      valueplots.length &&
                                                  blocks.length ==
                                                      valueblocks.length &&
                                                  uniqueList.length ==
                                                      valuefarmland.length) {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      // title: Text('Save Success'),
                                                      content: Text(
                                                          'Data saved successfully.'),
                                                      actions: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text('OK'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }
                                            }

                                            if (blocks.length > 0) {
                                              for (int j = 0;
                                                  j < blocks.length;
                                                  j++) {
                                                bool find = false;

                                                for (int v = 0;
                                                    v < uniqueList.length;
                                                    v++) {
                                                  bool isPolygon2Included =
                                                      isPolygonIncluded(
                                                          uniqueList[v]
                                                              .mapboundrieslat,
                                                          blocks[j]
                                                              .mapboundrieslat);
                                                  if (isPolygon2Included) {
                                                    find = true;
                                                    break;
                                                  }
                                                }

                                                if (find) {
                                                  if (blocks[j]
                                                          .mapboundrieslat
                                                          .length >
                                                      2) {
                                                    var BlockID = await SaveBlockDetails(
                                                        widget.accausation
                                                            ? widget
                                                                .farmeracussationid
                                                            : widget.data[0]
                                                                .farmerID,
                                                        blocks[j].name,
                                                        Areacalculate(blocks[j]
                                                            .mapboundrieslat),
                                                        blocks[j]
                                                            .polygran!
                                                            .points
                                                            .toString(),
                                                        FarmID);
                                                    if (j !=
                                                        blocks.length - 1) {
                                                      if (BlockID != 0) {
                                                        successlistBlcok
                                                            .add(true);
                                                      }
                                                    } else {
                                                      successlistBlcok
                                                          .add(true);
                                                      var valueplots =
                                                          successlistPlot
                                                              .where(
                                                                  (element) =>
                                                                      element ==
                                                                      true)
                                                              .toList();
                                                      var valueplotsLength =
                                                          valueplots.length;
                                                      // var valueplots=successlistPlot.where((element) => element==true);
                                                      var valueblocks =
                                                          successlistBlcok
                                                              .where(
                                                                  (element) =>
                                                                      element ==
                                                                      true)
                                                              .toList();
                                                      ;
                                                      var valuefarmland =
                                                          successlistFarmland
                                                              .where(
                                                                  (element) =>
                                                                      element ==
                                                                      true)
                                                              .toList();
                                                      ;
                                                      print(
                                                          "blocks length success ${valueplotsLength}");
                                                      print(valuefarmland);
                                                      if (plots.length ==
                                                              valueplots
                                                                  .length &&
                                                          blocks.length ==
                                                              valueblocks
                                                                  .length &&
                                                          uniqueList.length ==
                                                              valuefarmland
                                                                  .length) {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              // title: Text('Save Success'),
                                                              content: Text(
                                                                  'Data saved successfully.'),
                                                              actions: [
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                      'OK'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      }
                                                    }

                                                    if (plots.length > 0) {
                                                      for (int p = 0;
                                                          p < plots.length;
                                                          p++) {
                                                        bool findplot = false;

                                                        for (int vl = 0;
                                                            vl <
                                                                blockslist
                                                                    .length;
                                                            vl++) {
                                                          bool
                                                              isPolygon2Included =
                                                              isPolygonIncluded(
                                                                  blocks[vl]
                                                                      .mapboundrieslat,
                                                                  plots[p]
                                                                      .mapboundrieslat);
                                                          if (isPolygon2Included) {
                                                            findplot = true;
                                                          }
                                                        }

                                                        if (findplot) {
                                                          LatLng? sensordata =
                                                              LatLng(1.1, 1.1);
                                                          if (plots[p]
                                                                  .Sensorlatlang
                                                                  ?.latitude !=
                                                              null) {
                                                            sensordata = plots[
                                                                    p]
                                                                .Sensorlatlang;
                                                          }
                                                          if (plots[p]
                                                                  .mapboundrieslat
                                                                  .length >
                                                              2) {
                                                            var PlotID = await SavePlotDetails(
                                                                widget.data[0]
                                                                    .farmerID,
                                                                plots[p].name,
                                                                Areacalculate(
                                                                    plots[p]
                                                                        .mapboundrieslat),
                                                                plots[p]
                                                                    .polygran
                                                                    ?.points
                                                                    .toString(),
                                                                BlockID,
                                                                plots[p].Plottype ??
                                                                    "",
                                                                sensordata
                                                                    ?.latitude,
                                                                sensordata
                                                                    ?.longitude,
                                                                widget.accausation
                                                                    ? 'PA'
                                                                    : 'PR');
                                                            if (p !=
                                                                plots.length -
                                                                    1) {
                                                              if (PlotID != 0) {
                                                                successlistPlot
                                                                    .add(true);
                                                              }
                                                            } else {
                                                              successlistPlot
                                                                  .add(true);
                                                              var valueplots =
                                                                  successlistPlot.where(
                                                                      (element) =>
                                                                          true);
                                                              var valueblocks =
                                                                  successlistBlcok.where(
                                                                      (element) =>
                                                                          true);
                                                              var valuefarmland =
                                                                  successlistFarmland.where(
                                                                      (element) =>
                                                                          true);
                                                              if (plots
                                                                          .length ==
                                                                      valueplots
                                                                          .length &&
                                                                  blocks.length ==
                                                                      valueblocks
                                                                          .length &&
                                                                  uniqueList
                                                                          .length ==
                                                                      valuefarmland
                                                                          .length) {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      // title: Text('Save Success'),
                                                                      content: Text(
                                                                          'Data saved successfully.'),
                                                                      actions: [
                                                                        ElevatedButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              Text('OK'),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                );
                                                              }
                                                            }
                                                          }
                                                        } else {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                // title: Text('Save Success'),
                                                                content: Text(
                                                                    'Plot is outside Block area, cannot continue.'),
                                                                actions: [
                                                                  ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      // Navigator.of(context).pop();
                                                                    },
                                                                    child: Text(
                                                                        'OK'),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        }
                                                      }
                                                    }
                                                  } else {}
                                                } else {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        // title: Text('Save Success'),
                                                        content: Text(
                                                            'Block is outside Farmland area, cannot continue.'),
                                                        actions: [
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              // Navigator.of(context).pop();
                                                            },
                                                            child: Text('OK'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                }
                                              }
                                              // print('Is polygon2 included in polygon1? $isPolygon2Included');
                                            } else {
                                              if (plots.length > 0) {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      // title: Text('Save Success'),
                                                      content: Text(
                                                          'Block not found, cannot continue.'),
                                                      actions: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            // Navigator.of(context).pop();
                                                          },
                                                          child: Text('OK'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }
                                            }
                                          } else {}
                                        }
                                      } //// });
                                    } else {
                                      List<Farmarraay> newArray = farmerarray
                                          .where((farm) =>
                                              farm.Plottype != null &&
                                              farm.Sensorlatlang != null)
                                          .toList();
                                      newArray
                                          .where((farm) =>
                                              farm.Plottype != null &&
                                              farm.Sensorlatlang != null)
                                          .forEach(
                                              (element) => print(element.name));
                                      List<bool> plotarraysucsess = [];

                                      for (int r = 0;
                                          r < newArray.length;
                                          r++) {
                                        var PlotID = await SavePlotDetails(
                                            widget.accausation
                                                ? widget.farmeracussationid
                                                : widget.data[0].farmerID,
                                            newArray[r].name,
                                            Areacalculate(
                                                newArray[r].mapboundrieslat),
                                            newArray[r]
                                                    .polygran
                                                    ?.points
                                                    .toString() ??
                                                LatLng(0.0, 0.0),
                                            0,
                                            newArray[r].Plottype ?? "",
                                            newArray[r].Sensorlatlang?.latitude,
                                            newArray[r]
                                                .Sensorlatlang
                                                ?.longitude,
                                            widget.accausation ? 'PA' : 'PR');
                                        if (PlotID != 0) {
                                          plotarraysucsess.add(true);
                                        } else {}
                                      }
                                      if (plotarraysucsess.length ==
                                          newArray.length) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              // title: Text('Save Success'),
                                              content: Text(
                                                  'Data saved successfully.'),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    }
                                  } catch (e) {
                                  } finally {
                                    setState(() {
                                      loading = false;
                                    });
                                  }
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        MyAlertDialogNamed(parametter: 'add'),
                                  );
                                }
                                // if(saved){
                              },
                              child: Text(
                                "Save",
                                style: TextStyle(color: Colors.white),
                              )),
                        )),
                  ),
                ],
              ),
            ),
    );
  }

  bool hasreord(List<Farmarraay> Farmlannds, List<Farmarraay> blocks,
      List<Farmarraay> plots) {
    print("inside data");
    List<bool> blockstrue = [];
    List<bool> plotstrue = [];
    for (int i = 0; i < Farmlannds.length; i++) {
      if (blocks.length > 0) {
        for (int b = 0; b < blocks.length; b++) {
          bool isPolygon2Included = isPolygonIncluded(
              Farmlannds[i].mapboundrieslat, blocks[b].mapboundrieslat);
          print("is in range ${isPolygon2Included}");
          if (isPolygon2Included) {
            blocks[b].inrange = true;
            blockstrue.add(true);
            break;
          } else {}
        }
      } else {
        return true;
      }
    }
    if (blocks.length == blockstrue.length) {
      for (int b = 0; b < blocks.length; b++) {
        for (int p = 0; p < plots.length; p++) {
          bool isPolygon2Included = isPolygonIncluded(
              blocks[b].mapboundrieslat, plots[p].mapboundrieslat);
          if (isPolygon2Included) {
            plots[p].inrange = true;
            plotstrue.add(true);
            break;
          } else {}
        }
      }
    } else {
      List<Farmarraay> data =
          blocks.where((element) => element.inrange != true).toList();
      if (data.isNotEmpty)
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              // title: Text('Save Success'),
              content: Text('Block is outside Farmland area, cannot continue.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
    }

    if (plots.length == plotstrue.length) {
      return true;
    } else {
      List<Farmarraay> data =
          plots.where((element) => element.inrange != true).toList();
      if (data.isNotEmpty)
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              // title: Text('Save Success'),
              content: Text('Plot is outside Block area, cannot continue.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
    }

    return false;
  }

  bool hasRecordWithLengthGreaterThan3(List<Farmarraay> farmerarray) {
    for (int i = 0; i < farmerarray.length; i++) {
      if (farmerarray[i].mapboundrieslat.length > 2) {
        return true;
      }
    }
    return false;
  }

  Future<int> SavePlotDetails(farmerID, Farmlandname, Totalarea, Polygron,
      farmlandid, type, lat, long, sectiontype) async {
    Map<String, String> header = {
      "content-type": "application/json",
      "API_KEY": "12345678"
    };
    var body = {
      "FarmerID": farmerID,
      "FarmLandName": Farmlandname,
      "FarmlandID": farmlandid,
      "PlotType": type,
      "Latitude": lat,
      "Longitude": long,
      "TotalAreaInSqMeter": Totalarea,
      "PolygonBoundaryes": Polygron,
      "SectionType": sectiontype
    };
    print("body ${body}");
    final dio = Dio();
    final response = await dio.post(
        'http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/farmermap/plotpolygronsave',
        options: Options(headers: header),
        data: body,
        queryParameters: {});

    if (response.statusCode == 200) {
      if (response.data['susess']) {
        print(response.data['data']);
        final responcedata = response.data['data'];
        print("data ${responcedata}");
        return responcedata;
      }
      return 0;
    } else {
      return 0;
      // print('Error sending array. Status code: ${response.statusCode}');
    }
  }

  Future<int> SaveBlockDetails(
      farmerID, Farmlandname, Totalarea, Polygron, farmlandid) async {
    Map<String, String> header = {
      "content-type": "application/json",
      "API_KEY": "12345678"
    };
    var body = {
      "FarmerID": farmerID,
      "FarmLandName": Farmlandname,
      "FarmlandID": farmlandid,
      "TotalAreaInSqMeter": Totalarea,
      "PolygonBoundaryes": Polygron,
      "SectionType": widget.accausation ? 'PA' : 'PR'
    };
    final dio = Dio();
    final response = await dio.post(
        'http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/farmermap/blockpolygronsave',
        options: Options(headers: header),
        data: body,
        queryParameters: {});

    if (response.statusCode == 200) {
      if (response.data['susess']) {
        print(response.data['data']);
        final responcedata = response.data['data'];
        print("data ${responcedata}");
        return responcedata;
      }
      return 0;
    } else {
      return 0;
      // print('Error sending array. Status code: ${response.statusCode}');
    }
  }

  Future<int> SaveFarmlandDetails(
      farmerID, Farmlandname, Totalarea, Polygron) async {
    Map<String, String> header = {
      "content-type": "application/json",
      "API_KEY": "12345678"
    };
    var body = {
      "FarmerID": farmerID,
      "FarmLandName": Farmlandname,
      "TotalAreaInSqMeter": Totalarea,
      "PolygonBoundaryes": Polygron,
      "SectionType": widget.accausation ? 'PA' : 'PR'
    };
    final dio = Dio();
    final response = await dio.post(
        'http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/farmermap/farmlandpolygronsave',
        options: Options(headers: header),
        data: body,
        queryParameters: {});

    if (response.statusCode == 200) {
      if (response.data['susess']) {
        print(response.data['data']);
        final responcedata = response.data['data'];
        print("data ${responcedata}");
        return responcedata;
      }
      return 0;
    } else {
      return 0;
      // print('Error sending array. Status code: ${response.statusCode}');
    }
  }

  bool isPolygonIncluded(List<LatLng> outerPolygon, List<LatLng> innerPolygon) {
    for (LatLng point in innerPolygon) {
      if (!isPointInsidePolygon(point, outerPolygon)) {
        return false;
      }
    }
    return true;
  }

  bool isPointInsidePolygon(LatLng point, List<LatLng> polygon) {
    int intersections = 0;
    int polygonLength = polygon.length;

    for (int i = 0; i < polygonLength; i++) {
      LatLng vertex1 = polygon[i];
      LatLng vertex2 = polygon[(i + 1) % polygonLength];

      if (vertex1.longitude == vertex2.longitude &&
          vertex1.longitude == point.longitude) {
        if (point.latitude > vertex1.latitude &&
                point.latitude < vertex2.latitude ||
            point.latitude > vertex2.latitude &&
                point.latitude < vertex1.latitude) {
          return true;
        }
      }

      if (point.longitude > vertex1.longitude &&
              point.longitude > vertex2.longitude ||
          point.longitude < vertex1.longitude &&
              point.longitude < vertex2.longitude) {
        continue;
      }

      double vertex1ToY = point.longitude - vertex1.longitude;
      double vertex1ToX = point.latitude - vertex1.latitude;
      double vertex2ToY = vertex2.longitude - vertex1.longitude;
      double vertex2ToX = vertex2.latitude - vertex1.latitude;

      double k = vertex1ToY / vertex2ToY;
      if (k == vertex1ToX / vertex2ToX) {
        continue;
      }

      double x = k * vertex2ToX + vertex1.latitude;
      if (x > point.latitude) {
        intersections++;
      }
    }

    return intersections % 2 == 1;
  }

  bool isPolygonIncludedre(
      List<LatLng> outerPolygon, List<LatLng> innerPolygon) {
    for (LatLng point in innerPolygon) {
      if (!isPointInsidePolygons(point, outerPolygon)) {
        return false;
      }
    }
    return true;
  }

  bool isPointInsidePolygons(LatLng point, List<LatLng> polygon) {
    int intersections = 0;
    int polygonLength = polygon.length;

    for (int i = 0; i < polygonLength; i++) {
      LatLng vertex1 = polygon[i];
      LatLng vertex2 = polygon[(i + 1) % polygonLength];

      if (_isPointOnSegment(point, vertex1, vertex2)) {
        return true;
      }

      if (point.latitude > min(vertex1.latitude, vertex2.latitude) &&
          point.latitude <= max(vertex1.latitude, vertex2.latitude) &&
          point.longitude <= max(vertex1.longitude, vertex2.longitude) &&
          vertex1.latitude != vertex2.latitude) {
        double xIntercept = (point.latitude - vertex1.latitude) *
                (vertex2.longitude - vertex1.longitude) /
                (vertex2.latitude - vertex1.latitude) +
            vertex1.longitude;
        if (vertex1.longitude == vertex2.longitude ||
            point.longitude <= xIntercept) {
          intersections++;
        }
      }
    }

    return intersections % 2 == 1;
  }

  bool _isPointOnSegment(LatLng point, LatLng vertex1, LatLng vertex2) {
    return point.latitude <= max(vertex1.latitude, vertex2.latitude) &&
        point.latitude >= min(vertex1.latitude, vertex2.latitude) &&
        point.longitude <= max(vertex1.longitude, vertex2.longitude) &&
        point.longitude >= min(vertex1.longitude, vertex2.longitude);
  }

  // findLatLngInsidePolygon(List<LatLng> polygonPoints, List<LatLng> searchPoints) {
  //   for (final point in searchPoints) {
  //     if (isPointInPolygone(point, polygonPoints)) {
  //       return point;
  //     }
  //   }
  //
  //   return null; // Return null if no point is inside the polygon
  // }

  dynamic _findClosestPolygon(LatLng tappedLatLng) {
    Polygon? polygonsContainingPoint;
    List<Polygon> filteredPolygons = polygons
        .where((polygon) =>
            polygon.polygonId.value.startsWith('p') ||
            polygon.polygonId.value.startsWith('P'))
        .toList();

    for (final polygon in filteredPolygons) {
      if (isPointInPolygone(tappedLatLng, polygon.points)) {
        print(polygon.polygonId.value);
        polygonsContainingPoint = polygon;
        // break; // Exit the loop if a polygon is found
      }
    }

    return polygonsContainingPoint;
  }

  bool isPointInPolygon(LatLng point, List<LatLng> polygonPoints) {
    // Implementation of point-in-polygon algorithm
    // You can use any algorithm that checks if a point is inside a polygon

    // Assuming a simple algorithm here that checks if the point is inside
    // the bounding box of the polygon

    double minX = double.infinity;
    double maxX = double.negativeInfinity;
    double minY = double.infinity;
    double maxY = double.negativeInfinity;

    for (final p in polygonPoints) {
      if (p.latitude < minY) minY = p.latitude;
      if (p.latitude > maxY) maxY = p.latitude;
      if (p.longitude < minX) minX = p.longitude;
      if (p.longitude > maxX) maxX = p.longitude;
    }

    if (point.latitude < minY ||
        point.latitude > maxY ||
        point.longitude < minX ||
        point.longitude > maxX) {
      return false;
    }

    // Ray-casting algorithm to check if the point is inside the polygon
    bool inside = false;
    for (int i = 0, j = polygonPoints.length - 1;
        i < polygonPoints.length;
        j = i++) {
      if ((polygonPoints[i].longitude > point.longitude) !=
              (polygonPoints[j].longitude > point.longitude) &&
          point.latitude <
              (polygonPoints[j].latitude - polygonPoints[i].latitude) *
                      (point.longitude - polygonPoints[i].longitude) /
                      (polygonPoints[j].longitude -
                          polygonPoints[i].longitude) +
                  polygonPoints[i].latitude) {
        inside = !inside;
      }
    }

    return inside;
  }

  bool isPointInPolygone(LatLng point, List<LatLng> polygonPoints) {
    // Implementation of point-in-polygon algorithm

    // Assuming a simple algorithm here that checks if the point is inside
    // the bounding box of the polygon

    double minX = double.infinity;
    double maxX = double.negativeInfinity;
    double minY = double.infinity;
    double maxY = double.negativeInfinity;

    for (final p in polygonPoints) {
      if (p.latitude < minY) minY = p.latitude;
      if (p.latitude > maxY) maxY = p.latitude;
      if (p.longitude < minX) minX = p.longitude;
      if (p.longitude > maxX) maxX = p.longitude;
    }

    if (point.latitude < minY ||
        point.latitude > maxY ||
        point.longitude < minX ||
        point.longitude > maxX) {
      return false;
    }

    // Ray-casting algorithm to check if the point is inside the polygon
    bool inside = false;
    for (int i = 0, j = polygonPoints.length - 1;
        i < polygonPoints.length;
        j = i++) {
      if ((polygonPoints[i].longitude > point.longitude) !=
              (polygonPoints[j].longitude > point.longitude) &&
          point.latitude <
              (polygonPoints[j].latitude - polygonPoints[i].latitude) *
                      (point.longitude - polygonPoints[i].longitude) /
                      (polygonPoints[j].longitude -
                          polygonPoints[i].longitude) +
                  polygonPoints[i].latitude) {
        inside = !inside;
      }
    }

    return inside;
  }

  bool checkPolygons(List<Polygon> a, List<Polygon> b, List<Polygon> c) {
    for (final polygonB in b) {
      bool isWithinA = false;
      for (final polygonA in a) {
        if (isPolygonWithin(polygonB, polygonA)) {
          isWithinA = true;
          break;
        }
      }
      if (!isWithinA) {
        return false;
      }
      print("A with in $isWithinA");
    }

    for (final polygonC in c) {
      bool isWithinB = false;
      for (final polygonB in b) {
        if (isPolygonWithin(polygonC, polygonB)) {
          isWithinB = true;
          break;
        }
      }
      if (!isWithinB) {
        return false;
      }
    }

    return true;
  }

  bool isPolygonWithin(Polygon polygon1, Polygon polygon2) {
    List<LatLng> points1 = polygon1.points;
    List<LatLng> points2 = polygon2.points;
    if (!isPolygonIncludedre(points1, points2)) {
      return false;
    }
    // // Check if all points of polygon1 are within polygon2
    // for (LatLng point in points1) {
    //   if (!isPointInsidePolygon(point, points2)) {
    //     return false;
    //   }
    // }

    return true;
  }
}

class Farmlandall {
  Farmarraay? farmearray;
  List<Blockdetailsarray>? Farmland = [];
  Farmlandall({this.farmearray, this.Farmland});
}

class Blockdetailsarray {
  Farmarraay? farmearray;
  List<plotsdata>? Farmland = [];
  Blockdetailsarray({this.farmearray, this.Farmland});
}

class plotsdata {
  Farmarraay? PLOTDATA;
  plotsdata({this.PLOTDATA});
}








// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_compass/flutter_compass.dart';
//
// class RotatingMap extends StatefulWidget {
//   @override
//   _RotatingMapState createState() => _RotatingMapState();
// }
//
// class _RotatingMapState extends State<RotatingMap> {
//   GoogleMapController? _mapController;
//   double _compassDirection = 0.0;
//   StreamSubscription<CompassEvent>? _compassSubscription;
//   CameraPosition? _currentCameraPosition;
//
//   @override
//   void initState() {
//     super.initState();
//     _initCompass();
//   }
//
//   @override
//   void dispose() {
//     _stopCompass();
//     super.dispose();
//   }
//
//   void _initCompass() {
//     _compassSubscription = FlutterCompass.events!.listen((CompassEvent event) {
//       setState(() {
//         _compassDirection = event.heading ?? 0.0;
//       });
//       _updateMapBearing();
//     });
//   }
//
//   void _stopCompass() {
//     _compassSubscription?.cancel();
//     _compassSubscription = null;
//   }
//
//   void _updateMapBearing() {
//     if (_mapController != null && _currentCameraPosition != null) {
//       final updatedCameraPosition = CameraPosition(
//         target: _currentCameraPosition!.target,
//         zoom: _currentCameraPosition!.zoom,
//         tilt: _currentCameraPosition!.tilt,
//         bearing: _compassDirection,
//       );
//       _mapController!.animateCamera(
//         CameraUpdate.newCameraPosition(updatedCameraPosition),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         onMapCreated: (GoogleMapController controller) {
//           _mapController = controller;
//           _mapController!.setMapStyle(
//             '[{"stylers":[{"hue":"#ff1a00"},{"invert_lightness":true},{"saturation":-100},{"lightness":33},{"gamma":0.5}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#2D333C"}]}]',
//           ); // Apply a custom map style (optional)
//           _initCompass();
//         },
//         initialCameraPosition: CameraPosition(
//           target: LatLng(37.42796133580664, -122.085749655962),
//           zoom: 14.0,
//         ),
//         compassEnabled: false, // Disable the built-in compass control
//         markers: _buildMarkers(),
//         onCameraMove: (position) {
//           _currentCameraPosition = position;
//         },
//       ),
//     );
//   }
//
//   Set<Marker> _buildMarkers() {
//     // Add your custom markers to the map
//     return {};
//   }
// }





