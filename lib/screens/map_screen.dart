import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:near_laundry/https/directions_handler.dart';
import 'package:near_laundry/models/directions.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(37.773972, -122.431297),
    zoom: 11.5,
  );

  GoogleMapController? _googleMapController;
  Marker? _origin;
  Marker? _destination;
  Directions? _infor;
  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        GoogleMap(
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: _initialCameraPosition,
          onMapCreated: (controller) => _googleMapController = controller,
          markers: {
            if (_origin != null) _origin as Marker,
            if (_destination != null) _destination as Marker,
          },
          polylines: {
            if (_infor != null)
              Polyline(
                polylineId: const PolylineId('overview_poyline'),
                color: Colors.red,
                width: 5,
                points: _infor!.polylinePoints!
                    .map((e) => LatLng(e.latitude, e.longitude))
                    .toList(),
              )
          },
          onLongPress: addMarker,
        ),
        if (_infor != null)
          Positioned(
            top: 20.0,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
              decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    ),
                  ]),
              child: Text(
                '${_infor?.totalDistance}, ${_infor?.totalDuration}',
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
            ),
          )
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController?.animateCamera(
          _infor != null
              ? CameraUpdate.newLatLngBounds(
                  _infor?.bounds as LatLngBounds, 100.0)
              : CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  void addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        _destination = null;
      });
    } else {
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: pos,
        );
        //Reset destination
        _destination = null;

        //Reset info
        _infor = null;
      });

      // Get directions
      final directions = await DirectionHandler().getDirections(
          origin: _origin?.position, destination: _destination?.position);
      setState(() {
        _infor = directions;
      });
    }
  }
}
