import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:joso101/map/accident_class.dart';
import 'package:joso101/map/accident_detail.dart';
import 'package:joso101/report/report_screen.dart';
import 'package:joso101/utils/basecard.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'MapData.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late FirebaseAuth _auth;
  late FirebaseFirestore _fstore;
  late String currentUser;
  late Position currentLocation;
  LatLng currentPoint = LatLng(37.421871, -122.084122);
  late final MapController mapController;
  late List<Marker> accidents;
  // Color statusColor = Colors.greenAccent;
  bool activeStatus = false;
  double defaultPrecision = 0.0001;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    // currentUser = "tester1@gmail.com";
    initFirebase();
  }

  void initFirebase() async {
    _auth = FirebaseAuth.instance;
    _fstore = FirebaseFirestore.instance;
    //  for testing
    // await _auth.signInWithEmailAndPassword(
    //     email: "tester1@gmail.com", password: "peepoo");

    currentUser = _auth.currentUser?.email ?? "none";
    // print(currentUser);
  }

  Stream<Position> getCurrentLocation() {
    return Geolocator.getPositionStream();
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void _gotoLocation(double lat, double long) {
    mapController.move(LatLng(lat, long), 17.0);
  }

  bool isInDangerZone(LatLng dangerPoint, double precision) {
    double dangerLatUpper = dangerPoint.latitude + precision;
    double dangerLatLower = dangerPoint.latitude - precision;
    double dangerLngUpper = dangerPoint.longitude + precision;
    double dangerLngLower = dangerPoint.longitude - precision;

    return (currentPoint.latitude <= dangerLatUpper) &&
        (currentPoint.latitude >= dangerLatLower) &&
        (currentPoint.longitude <= dangerLngUpper) &&
        (currentPoint.longitude >= dangerLngLower);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Provider.of<MapData>(context).statusColor,
        actions: [
          IconButton(
              onPressed: () async {
                currentLocation = await _getGeoLocationPosition();
                setState(() {
                  print("REPORT");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ReportScreen()));
                });
              },
              iconSize: 35,
              icon: Icon(Icons.sms_failed_outlined))
        ],
        title: Text(currentUser),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: _fstore.collection('accidentsFromUser').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    final snap = snapshot.data!.docs;
                    return StreamBuilder<Position>(
                        stream: getCurrentLocation(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          currentPoint = LatLng(snapshot.data?.latitude,
                              snapshot.data?.longitude);
                          return Column(
                            children: [
                              Expanded(
                                child: FlutterMap(
                                  mapController: mapController,
                                  options: MapOptions(
                                      center: currentPoint,
                                      zoom: 18.0,
                                      minZoom: 11.0,
                                      maxZoom: 17.0,
                                      interactiveFlags:
                                          InteractiveFlag.pinchZoom |
                                              InteractiveFlag.drag,
                                      plugins: [
                                        MarkerClusterPlugin(),
                                      ]),
                                  layers: [
                                    TileLayerOptions(
                                        urlTemplate:
                                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                        subdomains: ['a', 'b', 'c']),
                                    MarkerLayerOptions(
                                        markers: List.generate(
                                                snap.length,
                                                (index) => Marker(
                                                    width: 50,
                                                    height: 50,
                                                    point: LatLng(
                                                        snap[index]['lat'],
                                                        snap[index]['lng']),
                                                    builder: (context) {
                                                      // if (isInDangerZone(LatLng(snap[index]['lat'], snap[index]['lng']), defaultPrecision)){
                                                      //   print("DANGER");
                                                      // }
                                                      return
                                                        IconButton(
                                                          onPressed: () {
                                                            Accident acc = Accident(
                                                                email: snap[index]
                                                                    ["email"],
                                                                accDate: snap[index][
                                                                    "acc_date_time"],
                                                                lat: snap[index]
                                                                    ["lat"],
                                                                lng: snap[index]
                                                                    ["lng"],
                                                                expwStep: snap[
                                                                        index][
                                                                    "expw_step"],
                                                                injured: snap[
                                                                        index]
                                                                    ["injured"],
                                                                death: snap[index]
                                                                    ["death"],
                                                                cause: snap[index]
                                                                    ["cause"]);
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        AccidentDetailScreen(
                                                                            accident:
                                                                                acc)));
                                                          },
                                                          icon: Icon(
                                                            Icons.location_on,
                                                            color: Colors.red,
                                                            size: 50,
                                                          )
                                                        );
                                                    })) +
                                            [
                                              Marker(
                                                  width: 100.0,
                                                  height: 100.0,
                                                  point: currentPoint,
                                                  builder: (context) => IconButton(
                                                      color: Colors.red,
                                                      onPressed: () {},
                                                      icon: Image.asset(
                                                          "assets/images/current_location.png")))
                                            ]),
                                  ],
                                ),
                              ),
                              Center(
                                  child: Container(
                                color: Colors.purple,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: BaseCard(
                                          color: Provider.of<MapData>(context)
                                              .statusColor,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: IconButton(
                                              icon:
                                                  Icon(Icons.refresh_outlined),
                                              onPressed: () async {
                                                currentLocation =
                                                    await _getGeoLocationPosition();
                                                setState(() {
                                                  currentPoint = LatLng(
                                                      currentLocation.latitude,
                                                      currentLocation
                                                          .longitude);
                                                });
                                                print("REFRESH APP");
                                              },
                                              iconSize: 40,
                                            ),
                                          )),
                                    ),
                                    Expanded(child: SizedBox()),
                                    Expanded(
                                      child: BaseCard(
                                          color: Provider.of<MapData>(context)
                                              .statusColor,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: IconButton(
                                              icon: Icon(Icons
                                                  .power_settings_new_rounded),
                                              onPressed: () {
                                                if (activeStatus) {
                                                  Provider.of<MapData>(context,
                                                          listen: false)
                                                      .setInactive();
                                                  print("ACTIVE");
                                                } else {
                                                  Provider.of<MapData>(context,
                                                          listen: false)
                                                      .setActive();
                                                  print("INACTIVE");
                                                }
                                                setState(() {
                                                  activeStatus =
                                                      Provider.of<MapData>(
                                                              context,
                                                              listen: false)
                                                          .activeStatus;
                                                });
                                              },
                                              iconSize: 40,
                                            ),
                                          )),
                                    ),
                                    Expanded(child: SizedBox()),
                                    Expanded(
                                      child: BaseCard(
                                          color: Provider.of<MapData>(context)
                                              .statusColor,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: IconButton(
                                              icon: Icon(Icons.my_location),
                                              onPressed: () {
                                                print("RECENTER");
                                                _gotoLocation(
                                                    currentPoint.latitude,
                                                    currentPoint.longitude);
                                              },
                                              iconSize: 40,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              )),
                            ],
                          );
                        });
                  } else {
                    return StreamBuilder<Position>(
                        stream: getCurrentLocation(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          currentPoint = LatLng(snapshot.data?.latitude,
                              snapshot.data?.longitude);
                          // Provider.of<LocData>(context, listen: false).changePos(point);
                          return Column(
                            children: [
                              Center(
                                child: Column(
                                  children: const [
                                    Text(
                                      "DB NOT AVAILABLE",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 25),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: FlutterMap(
                                  mapController: mapController,
                                  options: MapOptions(
                                      center: currentPoint,
                                      zoom: 18.0,
                                      minZoom: 11.0,
                                      maxZoom: 17.0,
                                      interactiveFlags:
                                          InteractiveFlag.pinchZoom |
                                              InteractiveFlag.drag,
                                      plugins: [
                                        MarkerClusterPlugin(),
                                      ]),
                                  layers: [
                                    TileLayerOptions(
                                        urlTemplate:
                                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                        subdomains: ['a', 'b', 'c']),
                                    MarkerLayerOptions(markers: [
                                      Marker(
                                          width: 100.0,
                                          height: 100.0,
                                          point: currentPoint,
                                          builder: (context) => const Icon(
                                                Icons.location_on,
                                                color: Colors.redAccent,
                                                size: 50,
                                              ))
                                    ]),
                                  ],
                                ),
                              ),
                            ],
                          );
                        });
                  }
                }),
          ],
        ),
      ),
    );
  }
}
