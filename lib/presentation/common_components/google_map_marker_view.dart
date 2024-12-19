import 'package:deliver_ease/core/utils/debug_logger.dart';
import 'package:deliver_ease/core/utils/get_current_lat_long.dart';
import 'package:deliver_ease/presentation/features/dashboard/controllers/customer_dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapMarkerView extends ConsumerStatefulWidget {
  const GoogleMapMarkerView({super.key});

  @override
  ConsumerState createState() => _GoogleMapMarkerViewState();
}

class _GoogleMapMarkerViewState extends ConsumerState<GoogleMapMarkerView> {

  @override
  void initState() {
    super.initState();

  }

  late GoogleMapController mapController;

  late LatLng _latLong =  const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  @override
  Widget build(BuildContext context) {

    CustomerDashboardState customerDashboardState = ref.watch(customerDashboardProvider);

    return  GoogleMap(
      myLocationEnabled: true,
      onMapCreated: _onMapCreated,

      markers: const <Marker>{
        // Marker(
        //   draggable: true,
        //   markerId: const MarkerId("1"),
        //   position: LatLng(_latLong.latitude, _latLong.longitude),
        //   icon: BitmapDescriptor.defaultMarker,
        //
        //   // infoWindow: const InfoWindow(
        //   //   title: 'Location',
        //   // ),
        // )
      },

      initialCameraPosition: CameraPosition(
        target: customerDashboardState.latLng!,
        zoom: 17.0,
      ),
      onTap: (LatLng? value)
      {

      },
      onCameraIdle: ()
      async {
        LatLngBounds bounds = await mapController.getVisibleRegion();
        final lon = (bounds.northeast.longitude + bounds.southwest.longitude) / 2;
        final lat = (bounds.northeast.latitude + bounds.southwest.latitude) / 2;
        // String value =    await  GetCurrentLatLongUtil.getAddressFromLatLong(lat, lon);
        // address = value;
        // setState(() {});
        String? value =    await  GetCurrentLatLongUtil.getAddressFromLatLong(_latLong.latitude, _latLong.longitude);

        setState(() {});

        debuggerAdvance(tag: "lat long when on camera Idle", value: " ${lat}  and ${lon}");
      },
      onCameraMove: (cameraPosition) async {
        _latLong =  LatLng(cameraPosition.target.latitude, cameraPosition.target.longitude);

        // debuggerAdvance(tag: "lat long when on camera move", value: " ${_latLong.latitude}  and ${_latLong.longitude}");
        //gets the center lattitude
      },
    );
  }
}
