

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:joso101/map/accident_class.dart';
import 'package:joso101/map/accident_locs.dart';
import 'package:joso101/map/api_svc.dart';
import 'package:joso101/report/report_screen.dart';
import 'package:joso101/utils/basecard.dart';
import 'package:joso101/utils/popicon.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'map_data.dart';

class MapScreen extends StatefulWidget {
  const MapScreen(
      {
      // required this.currentUsername, required this.currentPassword
      Key? key})
      : super(key: key);

  // final currentUsername;
  // final currentPassword;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late FirebaseAuth _auth;
  late FirebaseFirestore _fstore;
  late String currentUser;
  late String currentPassword;
  late Position currentLocation;
  LatLng currentPoint = LatLng(37.421871, -122.084122);
  late final MapController mapController;
  late List<Marker> accidents;
  bool activeStatus = false;
  double defaultPrecision = 0.0001;
  late List<AccidentMod>? _accList = [];
  late List<Accident> accList = [];

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    currentUser = "tester1@gmail.com";
    // currentUser = widget.currentUsername;
    currentPassword = "peepoo";
    // currentPassword = widget.currentPassword;
    print("map screen: $currentUser ,$currentPassword");
    initFirebase();
  }

  void initFirebase() async {
    // await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
    _fstore = FirebaseFirestore.instance;
    //  for testing
    // print("sign in with: $currentUser ,$currentPassword");
    await _auth.signInWithEmailAndPassword(
        email: "tester1@gmail.com", password: "peepoo");

    currentUser = _auth.currentUser?.email ?? "none";
    print(currentUser);
  }

  void _getDataFromApi() async {
    AccidentModels? temp = await ApiService().getAccidents();
    Future.delayed(const Duration(seconds: 5)).then((value) => setState(() {}));
    _accList = temp?.result;

    for (int index = 0; index < _accList!.length; index++) {
      String express = _accList![index].expwStep;
      DateTime accidentDateTime = _accList![index].accidentDate;
      if (DateTime.now().day - 3 > accidentDateTime.day) {
        List<LatLng> expressLatLng = [];
        switch (express) {
          case "ศรีรัช":
            {
              expressLatLng = [
                LatLng(13.89706, 100.542052),
                LatLng(13.882336, 100.537974),
                LatLng(13.81717, 100.55003),
                LatLng(13.85794, 100.53330),
                LatLng(13.79393, 100.43461)
              ];
            }
            break;
          case "บางพลี-สุขสวัสดิ์":
            {
              expressLatLng = [
                LatLng(13.64252, 100.68150),
                LatLng(13.65378, 100.68928),
                LatLng(13.65514, 100.69034),
                LatLng(13.64098, 100.68019),
                LatLng(13.64766, 100.68496)
              ];
            }
            break;
          case "ฉลองรัช":
            {
              expressLatLng = [
                LatLng(13.71758, 100.60206),
                LatLng(13.75214, 100.60049),
                LatLng(13.80805, 100.61842),
                LatLng(13.89745, 100.68518),
                LatLng(13.88464, 100.64974)
              ];
            }
            break;
          case "บูรพาวิถี":
            {
              expressLatLng = [
                LatLng(13.45962, 100.99637),
                LatLng(13.49504, 101.00604),
                LatLng(13.51767, 100.97721),
                LatLng(13.56335, 100.95085),
                LatLng(13.67158, 100.61486)
              ];
            }
            break;
          case "S1":
            {}
            break;
          case "อุดรรัถยา":
            {}
            break;
          case "เฉลิมมหานคร":
            {}
            break;
          case "ทางหลวงพิเศษหมายเลข 37":
            {}
            break;
          case "ศรีรัช-วงแหวนรอบนอก":
            {}
            break;
        }
        expressLatLng.isEmpty
            ? accList += []
            : accList += List.generate(
                expressLatLng.length,
                (lIndex) => Accident(
                    accDate: Timestamp.fromDate(_accList![index].accidentDate),
                    lat: expressLatLng[lIndex].latitude,
                    lng: expressLatLng[lIndex].longitude,
                    injured:
                        _accList![index].injurMan + _accList![index].injurFemel,
                    death:
                        _accList![index].deadMan + _accList![index].deadFemel,
                    cause: _accList![index].cause));
      }
    }
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

  void setDangerStatus(LatLng latLng) {
    if (isInDangerZone(latLng, defaultPrecision)) {
      Future.delayed(Duration.zero, () {
        Provider.of<MapData>(context, listen: false).inDanger();
      });
    } else {
      Future.delayed(Duration.zero, () {
        Provider.of<MapData>(context, listen: false).inSafe();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Provider.of<MapData>(context).statusColor,
        actions: [
          IconButton(
              onPressed: () async {
                setState(() {
                  print("REPORT");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                                create: (context) => MapData(),
                                child: ReportScreen(),
                              )));
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
                                      zoom: 17.0,
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
                                                      setDangerStatus(LatLng(
                                                          snap[index]['lat'],
                                                          snap[index]['lng']));
                                                      Accident acc = Accident(
                                                          email: snap[index]
                                                              ["email"],
                                                          accDate: snap[index]
                                                              ["acc_date_time"],
                                                          lat: snap[index]
                                                              ["lat"],
                                                          lng: snap[index]
                                                              ["lng"],
                                                          injured: snap[index]
                                                              ["injured"],
                                                          death: snap[index]
                                                              ["death"],
                                                          cause: snap[index]
                                                              ["cause"]);
                                                      // print(acc.email);
                                                      return PopUpIcon(
                                                        accident: acc,
                                                        herotag: acc.email! +
                                                            acc.accDate
                                                                .toString(),
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
                                                _getDataFromApi();
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
                                              onPressed: () {},
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
                    return const Center(child: CircularProgressIndicator());
                  }
                })
          ],
        ),
      ),
    );
  }
}
