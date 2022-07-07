// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong/latlong.dart';
// // import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
// // import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
//
// class MapScreen extends StatefulWidget {
//   const MapScreen({Key? key}) : super(key: key);
//
//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen>{
//
//   LatLng point = LatLng(49.5, -0.09);
//   // LocationData? current;
//
//   @override
//   Widget build(BuildContext context) {
//     return  Stack(
//       children: [
//         FlutterMap(
//           options: MapOptions(
//             center: LatLng(49.5, -0.09),
//             zoom: 10.0,
//           ),
//           layers: [
//             TileLayerOptions(
//               urlTemplate: "http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//               subdomains: ['a','b','c']
//             ),
//             MarkerLayerOptions(markers: [
//               Marker(
//                 width: 100.0,
//                 height: 100.0,
//                 point:
//                   point,
//                 builder: (context) => Icon(
//                   Icons.location_on,
//                   color: Colors.red,
//                 )
//               )
//             ])
//           ],
//         )
//       ],
//     );
//   }
//
//   // MapController mapController = MapController(
//   //   initMapWithUserPosition: false,
//   //   initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
//   // );
//   //
//   // @override
//   // Widget build(BuildContext context) {
//   //   return OSMFlutter(
//   //     controller:mapController,
//   //     trackMyPosition: false,
//   //     initZoom: 12,
//   //     minZoomLevel: 8,
//   //     maxZoomLevel: 14,
//   //     stepZoom: 1.0,
//   //     userLocationMarker: UserLocationMaker(
//   //       personMarker: MarkerIcon(
//   //         icon: Icon(
//   //           Icons.location_history_rounded,
//   //           color: Colors.red,
//   //           size: 48,
//   //         ),
//   //       ),
//   //       directionArrowMarker: MarkerIcon(
//   //         icon: Icon(
//   //           Icons.double_arrow,
//   //           size: 48,
//   //         ),
//   //       ),
//   //     ),
//   //     roadConfiguration: RoadConfiguration(
//   //       startIcon: MarkerIcon(
//   //         icon: Icon(
//   //           Icons.person,
//   //           size: 64,
//   //           color: Colors.brown,
//   //         ),
//   //       ),
//   //       roadColor: Colors.yellowAccent,
//   //     ),
//   //     markerOption: MarkerOption(
//   //         defaultMarker: MarkerIcon(
//   //           icon: Icon(
//   //             Icons.person_pin_circle,
//   //             color: Colors.blue,
//   //             size: 56,
//   //           ),
//   //         )
//   //     ),
//   //   );
//   // }
// }

