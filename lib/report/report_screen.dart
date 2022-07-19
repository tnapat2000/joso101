import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// import 'package:vector_math/vector_math.dart';
import 'package:joso101/utils/colors.dart';


class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
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

  // Initial Selected Value
  String dropdownvalue = 'Out of gas';

  // List of items in our dropdown menu
  var items = [
    'Out of gas',
    'Crashing',
    'Tyres bursting',
    'Overturning',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text("REPORT"),
      ),
      body: SlidingUpPanel(
        panel: Center(
          // child: Text("This is the sliding Widget"),
          child: Column(
            children: [
              Container(
                child: Center(
                  child: Column(
                    children: const [
                      Text("Location:"),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter a location here',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Column(
                    children: [
                      Text("Causes:"),
                      DropdownButton(
                        // Initial Value
                        value: dropdownvalue,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: const [
                    Text("Details:"),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Explain here',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Column(
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: light_green,
                        primary: Colors.black54,
                        // side: BorderSide(color: Colors.red, width: 5), //<-- SEE HERE
                      ),
                      onPressed: () {},
                      child: const Text(
                        'SUBMIT',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        color: background_green,
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
                            // Provider.of<LocData>(context, listen: false).changePos(point);
                            return Column(
                              children: [
                                Expanded(
                                  child: FlutterMap(
                                    mapController: mapController,
                                    options: MapOptions(
                                        center: currentPoint,
                                        zoom: 18.0,
                                        minZoom: 11.0,
                                        maxZoom: 18.0,
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
                                                        return IconButton(
                                                            onPressed: () {},
                                                            icon: const Icon(
                                                              Icons.location_on,
                                                              color: Colors.red,
                                                              size: 50,
                                                            ));
                                                      })) +
                                              [
                                                Marker(
                                                    width: 150.0,
                                                    height: 150.0,
                                                    point: currentPoint,
                                                    builder: (context) =>
                                                        IconButton(
                                                            color: Colors.red,
                                                            onPressed: () {},
                                                            icon: Image.asset(
                                                                "assets/images/pin_accident.png")))
                                              ]),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          });
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
