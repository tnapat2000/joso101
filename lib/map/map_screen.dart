import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late FirebaseAuth _auth;
  late FirebaseFirestore _fstore;
  String location = 'Null, Press Button';
  String address = 'search';
  late String currentUser;
  late Position currentLocation;
  LatLng currentPoint = LatLng(37.421871, -122.084122);
  late final MapController mapController;
  late List<Marker> accidents;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    currentUser = "tester1@gmail.com";
    initFirebase();
  }

  void initFirebase() async {
    _auth = FirebaseAuth.instance;
    _fstore = FirebaseFirestore.instance;
    //  for testing
    await _auth.signInWithEmailAndPassword(
        email: "tester1@gmail.com", password: "peepoo");

    currentUser = _auth.currentUser?.email ?? "none";
    print(currentUser);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                currentLocation = await _getGeoLocationPosition();
                setState(() {
                  currentPoint = LatLng(
                      currentLocation.latitude, currentLocation.longitude);
                  _gotoLocation(
                      currentLocation.latitude, currentLocation.longitude);
                });
              },
              icon: Icon(Icons.refresh))
        ],
        title: Text("TITLE"),
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
                    return
                        // ListView.builder(
                        //   shrinkWrap: true,
                        //   primary: false,
                        //   itemCount: snap.length,
                        //   itemBuilder: (context, index) {
                        //     return Text(snap[index]['lat'].toString() +
                        //         ' : ' +
                        //         snap[index]['lng'].toString());
                        //   },
                        // );
                        StreamBuilder<Position>(
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
                                  // Center(
                                  //   child: Column(
                                  //     children: [
                                  //       // Provider.of<LocData>(context, listen: false).changePosWidget(point),
                                  //       Text(
                                  //         "LAT :" +
                                  //             currentPoint.latitude.toString(),
                                  //         style: TextStyle(
                                  //             color: Colors.pinkAccent,
                                  //             fontSize: 25),
                                  //       ),
                                  //       Text(
                                  //         "LNG :" +
                                  //             currentPoint.longitude.toString(),
                                  //         style: TextStyle(
                                  //             color: Colors.purple,
                                  //             fontSize: 25),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
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
                                                        builder: (context) =>
                                                            const Icon(
                                                              Icons.location_on,
                                                              color:
                                                                  Colors.blue,
                                                              size: 50,
                                                            ))) +
                                                [
                                                  Marker(
                                                      width: 100.0,
                                                      height: 100.0,
                                                      point: currentPoint,
                                                      builder: (context) =>
                                                          const Icon(
                                                            Icons.location_on,
                                                            color: Colors
                                                                .redAccent,
                                                            size: 50,
                                                          ))
                                                ]),
                                      ],
                                    ),
                                  ),
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
                                  children: [
                                    // Provider.of<LocData>(context, listen: false).changePosWidget(point),
                                    Text(
                                      "LAT :" +
                                          currentPoint.latitude.toString(),
                                      style: TextStyle(
                                          color: Colors.pinkAccent,
                                          fontSize: 25),
                                    ),
                                    Text(
                                      "LNG :" +
                                          currentPoint.longitude.toString(),
                                      style: TextStyle(
                                          color: Colors.purple, fontSize: 25),
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
