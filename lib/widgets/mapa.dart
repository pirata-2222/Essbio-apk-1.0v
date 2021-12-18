import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Mapa extends StatelessWidget {
  final double lat;
  final double lon;
  Mapa({Key? key, required this.lat, required this.lon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return lat == 0.0
        ? Container(
            alignment: Alignment.center,
            height: screenHeight/3,
            width: screenWidth,
            child: Text(
              "No hay información de ubicación",
              textAlign: TextAlign.center,
            ))
        : Container(
            height: screenHeight/3,
            width: screenWidth,
            child: Stack(
              children: [
                FlutterMap(
                    options: MapOptions(center: LatLng(lat, lon), zoom: 17.0),
                    layers: [
                      TileLayerOptions(
                          urlTemplate:
                              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                          subdomains: ['a', 'b', 'c']),
                      MarkerLayerOptions(markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(lat, lon),
                          builder: (ctx) => Container(
                            child: Icon(Icons.location_on),
                          ),
                        ),
                      ])
                    ])
              ],
            ),
          );
  }
}
