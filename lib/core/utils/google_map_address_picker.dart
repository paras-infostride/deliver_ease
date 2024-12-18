import 'dart:convert';
import 'dart:math';

import 'package:deliver_ease/core/routes/app_router.dart';
import 'package:deliver_ease/core/routes/app_routes_name.dart';
import 'package:deliver_ease/core/utils/get_current_lat_long.dart';
import 'package:deliver_ease/core/utils/utils.dart';
import 'package:deliver_ease/domain/goole_places/google_places_res_model.dart';
import 'package:deliver_ease/domain/user_profile/user_profile.dart';
import 'package:deliver_ease/presentation/common_components/common_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;


class AddressPickerScreen extends StatefulWidget {
  final UserProfile userProfile;


  const AddressPickerScreen({super.key, required this.userProfile});

  @override
  State<AddressPickerScreen> createState() => _AddressPickerScreenState();
}

class _AddressPickerScreenState extends State<AddressPickerScreen> {
  late GoogleMapController mapController;

  late LatLng _latLong =  const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  bool _showLoader = false;
 late  Position  position;

  late TextEditingController _controller ;
  var uuid =  const Uuid();
  String _sessionToken = '1234567890';
  List<dynamic> _placeList = [];



  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() {
      // _onChanged();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async{
     await  _callApi();
    });

  }

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

   getSuggestion(String input) async {

    const String placesApiKey = "";

    try{
      String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request = '$baseURL?input=$input&key=$placesApiKey&sessiontoken=$_sessionToken';
      var response = await http.get(Uri.parse(request));
      // var data = json.decode(response.body);
      debuggerAdvance(tag: "statusCode ", value: response.statusCode);
      if (response.statusCode == 200) {


      // var receivedData = json.decode(response.body);

      //['predictions']
      debuggerAdvance(tag: "received data", value: "/////////");
      PlacesResponseModel placesResponseModel = PlacesResponseModel.fromJson(json.decode(response.body));
      prettyPrintJson(tag: "received data", response: json.decode(response.body));
        // _placeList = receivedData;

        return placesResponseModel.predictions ?? <Predictions>[];
      } else {
        debuggerAdvance(tag: "error at loading suggestion", value: "list is empty");
        throw 'Failed to load predictions';
      }
    }catch(e){
     debuggerAdvance(tag: "error at loading suggestion", value: e.toString());
    }

  }

  String address = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Pick Location", onBackPressed: ()
      {
              context.pushNamed(
                AppRoutesName.profileScreen,
                extra: {
                  'userProfile': widget.userProfile,
                },
              );
            }),
      body: Builder(builder: (context)
      {
        if(_showLoader )
          {
            return const Center(child: CircularProgressIndicator());
          }
        else
          {
            return Stack(
              alignment: Alignment.center,
              children: [
                GoogleMap(
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
                    target: _latLong,
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
                    address = value ?? '';
                    setState(() {});

                    debuggerAdvance(tag: "lat long when on camera Idle", value: " ${lat}  and ${lon}");
                  },
                  onCameraMove: (cameraPosition) async {
                    _latLong =  LatLng(cameraPosition.target.latitude, cameraPosition.target.longitude);

                    // debuggerAdvance(tag: "lat long when on camera move", value: " ${_latLong.latitude}  and ${_latLong.longitude}");
                   //gets the center lattitude
                  },
                ),

                const Icon(Icons.pin_drop,
                  color: Colors.red,
                  size: 36,
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   const SizedBox(
                     height: 40,
                     width: double.infinity,
                    ),

                    SizedBox(
                       width: Responsive.setWidthByPercentage(80),
                      child: TypeAheadField<Predictions>(
                        suggestionsCallback: (search)
                        async {

                        var list =  await getSuggestion(search);
                         debuggerAdvance(tag: "received list ", value: list);
                          return  list;
                        },
                        controller: _controller,
                        loadingBuilder: (BuildContext context)
                        {
                          return const Center(child: CircularProgressIndicator());
                        },
                        errorBuilder: (BuildContext context, obj) {
                          return const Center
                          (child: Text("No data Found!"));
                        },
                        builder: (context, controller, focusNode) {
                          return AppTextField(
                            hint: "Address..",
                            focusNode: focusNode,
                            context: context,
                            onChanged: (String? value)
                            {

                            },
                            onSubmitted: (String? value)
                            {

                            },
                            headingText: "",
                            controller: controller,
                            width: Responsive.setWidthByPercentage(AppDimesnions.textFieldWidth),
                          );
                        },
                        itemBuilder: (context, prediction) {
                          return ListTile(
                            title: Text(prediction.description ?? ''),
                          );
                        },
                        onSelected: (prediction) async {
                          // String? value =    await  GetCurrentLatLongUtil.getAddressFromLatLong(prediction., _latLong.longitude);
                          // address = value ?? '';
                          // setState(() {});
                        },
                      ),
                    ),
                   const  Spacer(),


                    if(stringHasValue(address))
                      ...{
                      TextView(title: address , fontSize: 22,
                      textColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 12,horizontal:  12),
                        backgroundColor: Colors.white,
                        borderRadius: BorderRadius.circular(12),

                      )
                    },

                    const SizedBox(
                      height: 40,
                      width: double.infinity,
                    ),


                  ],
                )
              ],
            );
          }

      })
    );
  }

   _callApi() async{

     try {
       _showLoader = true;
       setState(() {});
       position = await  GetCurrentLatLongUtil.getCurrentPosition();
       debuggerAdvance(tag: "lat long", value: "${position.latitude} and ${position.longitude}");
       _latLong =  LatLng(position.latitude, position.longitude);

       // mapController.animateCamera(
       //   CameraUpdate.newCameraPosition(
       //     CameraPosition(target: LatLng(_latLong.latitude, _latLong.longitude), zoom: 15),
       //   ),
       // );

       String? value =    await  GetCurrentLatLongUtil.getAddressFromLatLong(_latLong.latitude, _latLong.longitude);
       address = value ?? '';
       _showLoader = false;
       setState(() {});
     }  catch (e) {
       debuggerAdvance(tag: "error at fetching current position", value: e.toString() , type: DebugType.error);
       _showLoader = false;
       setState(() {});
     }
   }
}