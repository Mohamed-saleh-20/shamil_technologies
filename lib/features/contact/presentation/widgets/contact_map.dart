// import 'package:flutter/material.dart';
// // Correct import for the google_maps_flutter package
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:shamil_technologies/app/constants/app_colors.dart';

// class ContactMap extends StatefulWidget {
//   const ContactMap({super.key});

//   @override
//   State<ContactMap> createState() => _ContactMapState();
// }

// class _ContactMapState extends State<ContactMap> {
//   // Coordinates for Dubai Silicon Oasis
//   static const LatLng _dsoLocation = LatLng(25.1213, 55.3953);

//   // Custom dark theme for the map to match the website's aesthetic
//   // Sourced from: https://mapstyle.withgoogle.com/
//   static const String _darkMapStyle = '''
//   [
//     {"elementType": "geometry", "stylers": [{"color": "#242f3e"}]},
//     {"elementType": "labels.text.fill", "stylers": [{"color": "#746855"}]},
//     {"elementType": "labels.text.stroke", "stylers": [{"color": "#242f3e"}]},
//     {"featureType": "administrative.locality", "elementType": "labels.text.fill", "stylers": [{"color": "#d59563"}]},
//     {"featureType": "poi", "elementType": "labels.text.fill", "stylers": [{"color": "#d59563"}]},
//     {"featureType": "poi.park", "elementType": "geometry", "stylers": [{"color": "#263c3f"}]},
//     {"featureType": "poi.park", "elementType": "labels.text.fill", "stylers": [{"color": "#6b9a76"}]},
//     {"featureType": "road", "elementType": "geometry", "stylers": [{"color": "#38414e"}]},
//     {"featureType": "road", "elementType": "geometry.stroke", "stylers": [{"color": "#212a37"}]},
//     {"featureType": "road", "elementType": "labels.text.fill", "stylers": [{"color": "#9ca5b3"}]},
//     {"featureType": "road.highway", "elementType": "geometry", "stylers": [{"color": "#746855"}]},
//     {"featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [{"color": "#1f2835"}]},
//     {"featureType": "road.highway", "elementType": "labels.text.fill", "stylers": [{"color": "#f3d19c"}]},
//     {"featureType": "transit", "elementType": "geometry", "stylers": [{"color": "#2f3948"}]},
//     {"featureType": "transit.station", "elementType": "labels.text.fill", "stylers": [{"color": "#d59563"}]},
//     {"featureType": "water", "elementType": "geometry", "stylers": [{"color": "#17263c"}]},
//     {"featureType": "water", "elementType": "labels.text.fill", "stylers": [{"color": "#515c6d"}]},
//     {"featureType": "water", "elementType": "labels.text.stroke", "stylers": [{"color": "#17263c"}]}
//   ]
//   ''';

//   // A set to hold the map markers
//   final Set<Marker> _markers = {
//     const Marker(
//       markerId: MarkerId('shamil_technologies_hq'),
//       position: _dsoLocation,
//       infoWindow: InfoWindow(
//         title: 'Shamil Technologies',
//         snippet: 'Dubai Silicon Oasis, UAE',
//       ),
//     ),
//   };

//   // This function is called when the map is created, and it applies the custom dark style.
//   void _onMapCreated(GoogleMapController controller) {
//     controller.setMapStyle(_darkMapStyle);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // ClipRRect gives the map container rounded corners, matching the site's design.
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(16),
//       child: SizedBox(
//         height: 300, // Define a fixed height for the map container
//         child: GoogleMap(
//           initialCameraPosition: const CameraPosition(
//             target: _dsoLocation,
//             zoom: 14.0,
//           ),
//           onMapCreated: _onMapCreated,
//           markers: _markers,
//           // Enable gestures for a better user experience
//           scrollGesturesEnabled: true,
//           zoomControlsEnabled: true,
//           zoomGesturesEnabled: true,
//         ),
//       ),
//     );
//   }
// }
