import 'dart:math';

import 'package:deliver_ease/core/utils/debug_logger.dart';
import 'package:deliver_ease/core/utils/get_current_lat_long.dart';
import 'package:deliver_ease/domain/user_profile/user_profile.dart';
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


  final List<Marker> _markers = <Marker>[];


  @override
  void initState() {
    super.initState();

  }

  void _add() {

    CustomerDashboardState customerDashboardState = ref.watch(customerDashboardProvider);


    for(int i =0 ; i < customerDashboardState.listOfUserProfile.length  ; i++)
      {
      UserProfile userProfile =  customerDashboardState.listOfUserProfile[i];
        final MarkerId markerId = MarkerId(userProfile.userId.toString());

        // creating a new MARKER
        final Marker marker = Marker(
          markerId: markerId,
          position: LatLng(
            userProfile.latitude!.toDouble(),
            userProfile.longitude!.toDouble(),
          ),
          infoWindow: InfoWindow(title: userProfile.name, snippet: '*'),
          onTap: () {
            // _onMarkerTapped(markerId);
          },
        );

      _markers.add(marker);
      }

    setState(() {});

    // setState(() {
    //   // adding a new marker to map
    //   markers[markerId] = marker;
    // });

  }

  late GoogleMapController mapController;

  late final LatLng _latLong =  const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  @override
  Widget build(BuildContext context) {

    CustomerDashboardState customerDashboardState = ref.watch(customerDashboardProvider);
    _add();

    return  GoogleMap(
      myLocationEnabled: true,
      onMapCreated: _onMapCreated,
      myLocationButtonEnabled: true,
      compassEnabled: true,
      markers: Set.of(_markers),
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

    );
  }
}
