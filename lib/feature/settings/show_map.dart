import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; 
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart'; 

import '../../model/city_model.dart';

class ShowMapPage extends StatelessWidget {
  final City city;
  const ShowMapPage({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    final mapController = MapController();
    return Scaffold(
        appBar: AppBar(
          title: Text(city.name),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Flexible(
              child: FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  center: LatLng(city.latitude, city.longitude),
                  zoom: 10,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
