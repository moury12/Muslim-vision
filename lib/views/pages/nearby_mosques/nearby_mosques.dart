import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:muslim_vision/views/pages/home_screen/home_widgets/home_screen_top_section.dart';

class MosqueLocator extends StatefulWidget {
  const MosqueLocator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MosqueLocatorState createState() => _MosqueLocatorState();
}

class _MosqueLocatorState extends State<MosqueLocator> {
  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
      });
    }
  }

  void _openGoogleMaps() {
    if (latitude != null && longitude != null) {
      final String url = 'https://www.google.com/maps/search/?api=1&query=mosque@$latitude,$longitude';
      launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Mosques'),
      ),
      body: Center(
        child: latitude != null && longitude != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Your Location:',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Latitude: $latitude',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Longitude: $longitude',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _openGoogleMaps,
                    child: const Text('Find Nearby Mosques'),
                  ),
                ],
              )
            : const DefaultCircularProgressIndicator(),
      ),
    );
  }
}
