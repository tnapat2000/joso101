import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// import 'package:joso101/LocData.dart';
import 'package:latlong/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String location = 'Null, Press Button';
  String Address = 'search';
  late Position currentLocation;
  LatLng point = LatLng(37.421871, -122.084122);
  late final MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
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
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
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
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void _gotoLocation(double lat, double long) {
    mapController.move(LatLng(lat, long), mapController.zoom);
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
                  point = LatLng(
                      currentLocation.latitude, currentLocation.longitude);
                  // Provider.of<LocData>(context, listen: false).changePos(point);
                  _gotoLocation(
                      currentLocation.latitude, currentLocation.longitude);
                  // print(point);
                });
              },
              icon: Icon(Icons.refresh))
        ],
        title: Text("TITLE"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            StreamBuilder<Position>(
                stream: getCurrentLocation(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  point =
                      LatLng(snapshot.data?.latitude, snapshot.data?.longitude);
                  // Provider.of<LocData>(context, listen: false).changePos(point);
                  return Column(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            // Provider.of<LocData>(context, listen: false).changePosWidget(point),
                            Text(
                              "LAT :" + point.latitude.toString(),
                              style:
                              TextStyle(color: Colors.pinkAccent, fontSize: 25),
                            ),
                            Text(
                              "LNG :" + point.longitude.toString(),
                              style: TextStyle(color: Colors.purple, fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: FlutterMap(
                          mapController: mapController,
                          options: MapOptions(
                            center: point,
                            zoom: 18.0,
                            minZoom: 11.0,
                            maxZoom: 17.0,
                            interactiveFlags:
                            InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                          ),
                          layers: [
                            TileLayerOptions(
                                urlTemplate:
                                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                subdomains: ['a', 'b', 'c']),
                            MarkerLayerOptions(markers: [
                              Marker(
                                  width: 100.0,
                                  height: 100.0,
                                  point: point,
                                  builder: (context) => const Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 50,
                                  ))
                            ])
                          ],
                        ),
                      ),
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }
}
