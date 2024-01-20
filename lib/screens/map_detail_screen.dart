import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_stories_app/screens/map_screen.dart';

class MapDetailScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  const MapDetailScreen({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<MapDetailScreen> createState() => _MapDetailScreenState();
}

class _MapDetailScreenState extends State<MapDetailScreen> {
  late LatLng userLocation;
  late GoogleMapController mapController;
  late final Set<Marker> markers = {};
  LatLng? selectedLocation;
  geo.Placemark? placemark;

  @override
  void initState() {
    super.initState();
    userLocation = LatLng(widget.latitude, widget.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Lokasi'),
      ),
      body: Center(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                zoom: 18,
                target: userLocation,
              ),
              onMapCreated: (controller) async {
                final info = await geo.placemarkFromCoordinates(
                    widget.latitude, widget.longitude);
                final place = info[0];
                final street = place.street!;
                final address =
                    '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
                setState(() {
                  placemark = place;
                });
                defineMarker(userLocation, street, address);

                final marker = Marker(
                  markerId: const MarkerId('source'),
                  position: userLocation,
                  infoWindow: InfoWindow(
                    title: street,
                    snippet: address,
                  ),
                );
                setState(() {
                  mapController = controller;
                  markers.add(marker);
                });
              },
              markers: markers,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
            ),
            if (placemark == null)
              const SizedBox()
            else
              Positioned(
                bottom: 16,
                right: 16,
                left: 16,
                child: PlacemarkWidget(
                  placemark: placemark!,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void defineMarker(
    LatLng latLng,
    String street,
    String address,
  ) {
    final marker = Marker(
      markerId: const MarkerId('source'),
      position: latLng,
      infoWindow: InfoWindow(
        title: street,
        snippet: address,
      ),
    );

    setState(() {
      markers.clear();
      markers.add(marker);
    });
  }
}
