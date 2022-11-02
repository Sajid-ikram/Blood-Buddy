import 'package:blood_buddy/providers/profile_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  CameraPosition? userCameraPosition;

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      body: GoogleMap(
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true,
          onCameraMove: (CameraPosition cameraPosition) {
            userCameraPosition = cameraPosition;
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(pro.latitude, pro.longitude),
            zoom: 15,
          ),
          mapType: MapType.normal,
          markers: [
            Marker(
              position: LatLng(pro.latitude, pro.longitude),
              markerId: MarkerId("marker id"),
              icon: BitmapDescriptor.defaultMarker,
            ),
          ].toSet()),
    );
  }
}
