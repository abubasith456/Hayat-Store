import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:shop_app/bloc/about_us/bloc/about_us_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/services/Location/location.dart';
import 'package:shop_app/util/map_style.dart';

class AboutUsScreen extends StatefulWidget {
  AboutUsScreen({Key? key}) : super(key: key);

  static String routeName = "/about_us";

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  Marker? _marker;

  @override
  void initState() {
    super.initState();
    getMarker();
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    }
  }

  late CameraPosition _kGooglePlex = Location.cameraPosition();
  late CameraPosition _kShop = Location.shopPosition();
  Maptheme maptheme = Maptheme();

  getMarker() async {
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/images/logo.png', 300);
    _marker = Marker(
      markerId: const MarkerId('Hayat Store'),
      infoWindow: InfoWindow(
          onTap: () {
            MapsLauncher.launchCoordinates(10.882605, 79.679260);
          },
          title: 'Hayat Store'),
      icon:
          // BitmapDescriptor.fromBytes(
          //     (await NetworkAssetBundle(Uri.parse(imgurl)).load(imgurl))
          //         .buffer
          //         .asUint8List()),
          // BitmapDescriptor.fromBytes(markerIcon),
          // BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),

          await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(size: Size(10, 5)), 'assets/images/logo.png'),
      position: LatLng(10.882605, 79.679260),
    );
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

// //Set on Bloc
//   Completer<GoogleMapController> _controller = Completer();
//   late GoogleMapController _googleMapController;

  Set<Marker> _setMarkers = {};

  GoogleMapController? _controller;

//Animator
  _goToTheLake() async {
    final GoogleMapController? controller = _controller;
    controller?.animateCamera(CameraUpdate.newCameraPosition(_kShop));
  }

  Map<String, Marker> _markers = {};
  Map<CircleId, Circle> circles = <CircleId, Circle>{};

  CircleId? selectedCircle;
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  @override
  void dispose() {
    super.dispose();
    // if (_googleMapController != null) {
    //   _googleMapController.dispose();
    // }
    _customInfoWindowController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _setMarkers.add(
      Marker(
        draggable: true,
        markerId: MarkerId("id"),
        position: LatLng(10.882605, 79.679260),
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container(
                      //   width: double.infinity,
                      //   height: 130,
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(10.0),
                      //     child: Image.network(
                      //       'https://images.unsplash.com/photo-1606089397043-89c1758008e0?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDEyMHw2c01WalRMU2tlUXx8ZW58MHx8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      // ),
                      Container(
                        width: double.infinity,
                        height: 140,
                        child: Image.asset(
                          "assets/images/logo.png",
                          alignment: Alignment.center,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Grand Teton National Park",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Grand Teton National Park on the east side of the Teton Range is renowned for great hiking trails with stunning views of the Teton Range.",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 12),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      MaterialButton(
                        onPressed: () {},
                        elevation: 0,
                        height: 40,
                        minWidth: double.infinity,
                        color: Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          "See details",
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 5.0,
                  left: 5.0,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _customInfoWindowController.hideInfoWindow!();
                    },
                  ),
                ),
              ],
            ),
            LatLng(10.882605, 79.679260),
          );
        },
      ),
    );

    // getMarker();
    return

        // Scaffold(
        //   body: Stack(
        //     children: [
        //       GoogleMap(
        //         myLocationButtonEnabled: false,
        //         mapType: MapType.normal,
        //         initialCameraPosition: _kGooglePlex,
        //         zoomControlsEnabled: true,
        //         markers: {if (_marker != null) _marker!},
        //         circles: circles.values.toSet(),
        //         onTap: (LatLng latLng) {
        //           _customInfoWindowController.hideInfoWindow!();
        //           Marker marker = Marker(
        //             draggable: true,
        //             markerId: MarkerId(latLng.toString()),
        //             position: latLng,
        //             onTap: () {
        //               _customInfoWindowController.addInfoWindow!(
        //                 Stack(
        //                   children: [
        //                     Container(
        //                       padding: EdgeInsets.all(15.0),
        //                       decoration: BoxDecoration(
        //                         borderRadius: BorderRadius.circular(15.0),
        //                         color: Colors.white,
        //                       ),
        //                       child: Column(
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           // Container(
        //                           //   width: double.infinity,
        //                           //   height: 130,
        //                           //   child: ClipRRect(
        //                           //     borderRadius: BorderRadius.circular(10.0),
        //                           //     child: Image.network(
        //                           //       'https://images.unsplash.com/photo-1606089397043-89c1758008e0?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDEyMHw2c01WalRMU2tlUXx8ZW58MHx8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
        //                           //       fit: BoxFit.cover,
        //                           //     ),
        //                           //   ),
        //                           // ),
        //                           Container(
        //                             width: double.infinity,
        //                             height: 140,
        //                             child: Image.asset(
        //                               "assets/images/logo.png",
        //                               alignment: Alignment.center,
        //                             ),
        //                           ),
        //                           SizedBox(
        //                             height: 15,
        //                           ),
        //                           Text(
        //                             "Grand Teton National Park",
        //                             style: TextStyle(
        //                                 color: Colors.black,
        //                                 fontWeight: FontWeight.bold,
        //                                 fontSize: 14),
        //                           ),
        //                           SizedBox(
        //                             height: 5,
        //                           ),
        //                           Text(
        //                             "Grand Teton National Park on the east side of the Teton Range is renowned for great hiking trails with stunning views of the Teton Range.",
        //                             style: TextStyle(
        //                                 color: Colors.grey.shade600, fontSize: 12),
        //                           ),
        //                           SizedBox(
        //                             height: 8,
        //                           ),
        //                           MaterialButton(
        //                             onPressed: () {},
        //                             elevation: 0,
        //                             height: 40,
        //                             minWidth: double.infinity,
        //                             color: Colors.grey.shade200,
        //                             shape: RoundedRectangleBorder(
        //                               borderRadius: BorderRadius.circular(10.0),
        //                             ),
        //                             child: Text(
        //                               "See details",
        //                               style: TextStyle(color: Colors.black),
        //                             ),
        //                           )
        //                         ],
        //                       ),
        //                     ),
        //                     Positioned(
        //                       top: 5.0,
        //                       left: 5.0,
        //                       child: IconButton(
        //                         icon: Icon(
        //                           Icons.close,
        //                           color: Colors.white,
        //                         ),
        //                         onPressed: () {
        //                           _customInfoWindowController.hideInfoWindow!();
        //                         },
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //                 latLng,
        //               );
        //             },
        //           );
        //         },
        //         onCameraMove: (position) {
        //           _customInfoWindowController.onCameraMove!();
        //         },
        //         onMapCreated: (GoogleMapController controller) {
        //           _controller = controller;
        //           _customInfoWindowController.googleMapController = controller;
        //         },
        //       ),
        //       CustomInfoWindow(
        //         controller: _customInfoWindowController,
        //         height: MediaQuery.of(context).size.height * 0.35,
        //         width: MediaQuery.of(context).size.width * 0.10,
        //         offset: 60.0,
        //       ),
        //       Positioned(
        //         bottom: 40,
        //         right: 15,
        //         child: Container(
        //             width: 35,
        //             height: 105,
        //             decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(10),
        //                 color: Colors.white),
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.start,
        //               children: [
        //                 MaterialButton(
        //                   onPressed: () {
        //                     _controller?.animateCamera(CameraUpdate.zoomIn());
        //                   },
        //                   padding: EdgeInsets.all(0),
        //                   shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(10),
        //                   ),
        //                   child: Icon(Icons.add, size: 25),
        //                 ),
        //                 Divider(height: 5),
        //                 MaterialButton(
        //                   onPressed: () {
        //                     _controller?.animateCamera(CameraUpdate.zoomOut());
        //                   },
        //                   padding: EdgeInsets.all(0),
        //                   shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(10),
        //                   ),
        //                   child: Icon(Icons.remove, size: 25),
        //                 )
        //               ],
        //             )),
        //       ),
        //       Positioned(
        //         bottom: 160,
        //         right: 15,
        //         child: Container(
        //             width: 35,
        //             height: 50,
        //             decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(10),
        //                 color: Colors.white),
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.start,
        //               children: [
        //                 MaterialButton(
        //                   onPressed: () {
        //                     showModalBottomSheet(
        //                       context: context,
        //                       builder: (context) => Container(
        //                           padding: EdgeInsets.all(20),
        //                           color: Colors.white,
        //                           height: MediaQuery.of(context).size.height * 0.3,
        //                           child: Column(
        //                             crossAxisAlignment: CrossAxisAlignment.start,
        //                             children: [
        //                               Text(
        //                                 "Select Theme",
        //                                 style: TextStyle(
        //                                     color: Colors.black,
        //                                     fontWeight: FontWeight.w600,
        //                                     fontSize: 18),
        //                               ),
        //                               SizedBox(
        //                                 height: 20,
        //                               ),
        //                               Container(
        //                                 width: double.infinity,
        //                                 height: 100,
        //                                 child: ListView.builder(
        //                                   scrollDirection: Axis.horizontal,
        //                                   itemCount: maptheme.mapThemes.length,
        //                                   itemBuilder: (context, index) {
        //                                     return GestureDetector(
        //                                       onTap: () {
        //                                         _controller?.setMapStyle(maptheme
        //                                             .mapThemes[index]['style']);
        //                                         Navigator.pop(context);
        //                                       },
        //                                       child: Container(
        //                                         width: 100,
        //                                         margin: EdgeInsets.only(right: 10),
        //                                         decoration: BoxDecoration(
        //                                           borderRadius:
        //                                               BorderRadius.circular(10),
        //                                           image: DecorationImage(
        //                                             fit: BoxFit.cover,
        //                                             image: NetworkImage(maptheme
        //                                                 .mapThemes[index]['image']),
        //                                           ),
        //                                         ),
        //                                       ),
        //                                     );
        //                                   },
        //                                 ),
        //                               ),
        //                             ],
        //                           )),
        //                     );
        //                   },
        //                   padding: EdgeInsets.all(0),
        //                   shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(10),
        //                   ),
        //                   child: Icon(Icons.layers_rounded, size: 25),
        //                 ),
        //               ],
        //             )),
        //       )
        //     ],
        //   ),
        // );

        BlocProvider(
      create: (context) => AboutUsBloc(),
      child: BlocConsumer<AboutUsBloc, AboutUsState>(
        listener: (context, state) {
          if (state is AboutUsInitial) {
            _kGooglePlex = state.cameraPosition;
            _kShop = state.shopLocation;
          } else if (state is OnMapCreatedState) {
            _controller = state.controller;
            _customInfoWindowController.googleMapController = state.controller;
          }
        },
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                body: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Stack(
                    fit: StackFit.loose,
                    children: [
                      GoogleMap(
                        myLocationButtonEnabled: false,
                        mapType: MapType.normal,
                        initialCameraPosition: _kGooglePlex,
                        zoomControlsEnabled: true,
                        markers: {if (_marker != null) _marker!},
                        circles: circles.values.toSet(),
                        onTap: (LatLng latLng) {
                          _customInfoWindowController.hideInfoWindow!();
                          Marker marker = Marker(
                            draggable: true,
                            markerId: MarkerId(latLng.toString()),
                            position: latLng,
                            onTap: () {
                              _customInfoWindowController.addInfoWindow!(
                                Stack(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(15.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Container(
                                          //   width: double.infinity,
                                          //   height: 130,
                                          //   child: ClipRRect(
                                          //     borderRadius: BorderRadius.circular(10.0),
                                          //     child: Image.network(
                                          //       'https://images.unsplash.com/photo-1606089397043-89c1758008e0?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDEyMHw2c01WalRMU2tlUXx8ZW58MHx8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
                                          //       fit: BoxFit.cover,
                                          //     ),
                                          //   ),
                                          // ),
                                          Container(
                                            width: double.infinity,
                                            height: 140,
                                            child: Image.asset(
                                              "assets/images/logo.png",
                                              alignment: Alignment.center,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            "Grand Teton National Park",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Grand Teton National Park on the east side of the Teton Range is renowned for great hiking trails with stunning views of the Teton Range.",
                                            style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 12),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          MaterialButton(
                                            onPressed: () {},
                                            elevation: 0,
                                            height: 40,
                                            minWidth: double.infinity,
                                            color: Colors.grey.shade200,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Text(
                                              "See details",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 5.0,
                                      left: 5.0,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          _customInfoWindowController
                                              .hideInfoWindow!();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                latLng,
                              );
                            },
                          );
                        },
                        onCameraMove: (position) {
                          _customInfoWindowController.onCameraMove!();
                        },
                        onMapCreated: (GoogleMapController controller) {
                          _controller = controller;
                          BlocProvider.of<AboutUsBloc>(context)
                              .add(OnMapCreatedEvent(
                            controller: controller,
                          ));
                        },
                      ),
                      Positioned(
                        top: 50,
                        left: 5,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _controller?.dispose();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 30,
                        left: 10,
                        child: FloatingActionButton.extended(
                          onPressed: _goToTheLake,
                          label: Text('To the shop!'),
                          icon: Icon(Icons.shopping_bag_outlined),
                        ),
                      ),
                      CustomInfoWindow(
                        controller: _customInfoWindowController,
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: MediaQuery.of(context).size.width * 0.10,
                        offset: 60.0,
                      ),
                      Positioned(
                        bottom: 40,
                        right: 15,
                        child: Container(
                            width: 35,
                            height: 105,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    _controller
                                        ?.animateCamera(CameraUpdate.zoomIn());
                                  },
                                  padding: EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(Icons.add, size: 25),
                                ),
                                Divider(height: 5),
                                MaterialButton(
                                  onPressed: () {
                                    _controller
                                        ?.animateCamera(CameraUpdate.zoomOut());
                                  },
                                  padding: EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(Icons.remove, size: 25),
                                )
                              ],
                            )),
                      ),
                      Positioned(
                        bottom: 160,
                        right: 15,
                        child: Container(
                            width: 35,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => Container(
                                          padding: EdgeInsets.all(20),
                                          color: Colors.white,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Select Theme",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 100,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      maptheme.mapThemes.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        _controller?.setMapStyle(
                                                            maptheme.mapThemes[
                                                                    index]
                                                                ['style']);
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        width: 100,
                                                        margin: EdgeInsets.only(
                                                            right: 10),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                maptheme.mapThemes[
                                                                        index]
                                                                    ['image']),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          )),
                                    );
                                  },
                                  padding: EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(Icons.layers_rounded, size: 25),
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(height: 140, child: Text("About us")),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 10, right: 10),
                        //   child: MaterialButton(
                        //     onPressed: () {},
                        //     color: kPrimaryColor,
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.all(Radius.circular(10))),
                        //     height: MediaQuery.of(context).size.height / 20,
                        //     minWidth: MediaQuery.of(context).size.width - 100,
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Icon(Icons.call, color: Colors.white),
                        //         SizedBox(
                        //           width: 10,
                        //         ),
                        //         Text(
                        //           'Pone number',
                        //           style: TextStyle(color: Colors.white),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 10, right: 10),
                        //   child: MaterialButton(
                        //     onPressed: () {},
                        //     color: kPrimaryColor,
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.all(Radius.circular(10))),
                        //     height: MediaQuery.of(context).size.height / 20,
                        //     minWidth: MediaQuery.of(context).size.width - 100,
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Icon(Icons.email_rounded, color: Colors.white),
                        //         SizedBox(
                        //           width: 10,
                        //         ),
                        //         Text(
                        //           'Email',
                        //           style: TextStyle(color: Colors.white),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                      ],
                    ),
                  ),
                )
              ],
            )),
          );
        },
      ),
    );

    //     Stack(
    //   children: [
    //     Positioned(
    //       bottom: 0,
    //       child: Stack(
    //         children: [
    //           Container(
    //             width: MediaQuery.of(context).size.width,
    //             height: MediaQuery.of(context).size.height,
    //             padding: const EdgeInsets.all(20),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.only(
    //                 topLeft: Radius.circular(30),
    //                 topRight: Radius.circular(30),
    //               ),
    //             ),
    //             child: SingleChildScrollView(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     'Product:',
    //                     style: TextStyle(
    //                         color: Colors.black45,
    //                         fontSize: 13,
    //                         fontWeight: FontWeight.bold),
    //                   ),
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Text(
    //                         'Nmae',
    //                         style: TextStyle(
    //                             color: Colors.black,
    //                             fontSize: 25,
    //                             fontWeight: FontWeight.bold),
    //                       ),
    //                       Text(
    //                         '\Rs',
    //                         style: TextStyle(
    //                             color: Colors.black,
    //                             fontSize: 20,
    //                             fontWeight: FontWeight.bold),
    //                       ),
    //                     ],
    //                   ),
    //                   const SizedBox(height: 25),
    //                   Text(
    //                     'DS',
    //                     style: TextStyle(
    //                         color: Colors.black54,
    //                         fontSize: 15,
    //                         fontWeight: FontWeight.bold),
    //                     // style: GoogleFonts.poppins(
    //                     //   fontSize: 15,
    //                     //   color: Colors.grey,
    //                     // ),
    //                   ),
    //                   const SizedBox(height: 15),

    //                   // SizedBox(
    //                   //   height: 110,
    //                   //   child: ListView.builder(
    //                   //     scrollDirection: Axis.horizontal,
    //                   //     itemCount: ,
    //                   //     itemBuilder: (context, index) => Container(
    //                   //       margin: const EdgeInsets.only(right: 6),
    //                   //       width: 110,
    //                   //       height: 110,
    //                   //       decoration: BoxDecoration(
    //                   //         color: AppColors.kSmProductBgColor,
    //                   //         borderRadius: BorderRadius.circular(20),
    //                   //       ),
    //                   //       child: Center(
    //                   //         child: Image(
    //                   //           height: 70,
    //                   //           image: AssetImage(smProducts[index].image),
    //                   //         ),
    //                   //       ),
    //                   //     ),
    //                   //   ),
    //                   // ),
    //                   const SizedBox(height: 20),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           Align(
    //             alignment: Alignment.topCenter,
    //             child: Container(
    //               margin: const EdgeInsets.only(top: 10),
    //               width: 50,
    //               height: 5,
    //               decoration: BoxDecoration(
    //                 color: Colors.black54,
    //                 borderRadius: BorderRadius.circular(50),
    //               ),
    //             ),
    //           ),
    //           // Positioned(
    //           //   bottom: 5,
    //           //   child: Container(
    //           //     padding: EdgeInsets.all(10),
    //           //     width: MediaQuery.of(context).size.width,
    //           //     child: _shoppingItem(context),
    //           //   ),
    //           // ),
    //         ],
    //       ),
    //     ),
    //     Column(
    //       children: [
    //         Container(
    //           height: MediaQuery.of(context).size.height * .55,
    //           padding: const EdgeInsets.only(bottom: 30),
    //           width: double.infinity,
    //           child: GoogleMap(
    //             mapType: MapType.hybrid,
    //             zoomControlsEnabled: false,
    //             myLocationButtonEnabled: false,
    //             zoomGesturesEnabled: true,
    //             initialCameraPosition: _kGooglePlex,
    //             onMapCreated: (GoogleMapController controller) {
    //               setState(() {
    //                 getMarker();
    //               });
    //               // controller
    //               // .animateCamera(CameraUpdate.newCameraPosition(_kShop));
    //               controller.setMapStyle(mapStyles);
    //               _controller.complete(controller);
    //             },
    //             markers: {if (_marker != null) _marker!},
    //           ),
    //         ),
    //       ],
    //     ),
    //   ],
    // ));

    //  Scaffold(
    //     backgroundColor: Colors.white,
    //     body: Stack(
    //       children: [
    //         Container(
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.only(
    //               bottomLeft: Radius.circular(50),
    //               bottomRight: Radius.circular(50),
    //             ),
    //           ),
    //           width: MediaQuery.of(context).size.width,
    //           height: MediaQuery.of(context).size.height / 1.5,
    //           child: GoogleMap(
    //             mapType: MapType.hybrid,
    //             zoomControlsEnabled: false,
    //             myLocationButtonEnabled: false,
    //             zoomGesturesEnabled: true,
    //             initialCameraPosition: _kGooglePlex,
    //             onMapCreated: (GoogleMapController controller) {
    //               setState(() {
    //                 getMarker();
    //               });
    //               // controller
    //               // .animateCamera(CameraUpdate.newCameraPosition(_kShop));
    //               controller.setMapStyle(mapStyles);
    //               _controller.complete(controller);
    //             },
    //             markers: {if (_marker != null) _marker!},
    //           ),
    //         ),
    //         Positioned(
    //           bottom: 0,
    //           child: Container(
    //             decoration: BoxDecoration(
    //               color: Colors.white,
    //               borderRadius: BorderRadius.only(
    //                 topLeft: Radius.circular(50),
    //                 topRight: Radius.circular(50),
    //               ),
    //             ),
    //             width: MediaQuery.of(context).size.width,
    //             height: MediaQuery.of(context).size.height / 15,
    //             child: Stack(children: [
    //               // Image.asset(
    //               //   "assets/images/logo.png",
    //               //   width: 400,
    //               // ),
    //               Positioned(
    //                 top: 50,
    //                 child: Column(
    //                   children: [
    //                     Container(
    //                         width: MediaQuery.of(context).size.width,
    //                         height: 40,
    //                         decoration: BoxDecoration(
    //                           color: Color.fromARGB(255, 186, 186, 186),
    //                           borderRadius: BorderRadius.only(
    //                             topLeft: Radius.circular(50),
    //                             topRight: Radius.circular(50),
    //                           ),
    //                         ))
    //                   ],
    //                 ),
    //               )
    //             ]),
    //           ),
    //         ),
    //         Positioned(
    //           bottom: 80,
    //           left: 10,
    //           child: FloatingActionButton.extended(
    //             onPressed: _goToTheLake,
    //             label: Text('To the shop!'),
    //             icon: Icon(Icons.shopping_bag_outlined),
    //           ),
    //         ),
    //         Positioned(
    //           top: 50,
    //           left: 5,
    //           child: IconButton(
    //             onPressed: () {
    //               Navigator.pop(context);
    //             },
    //             icon: Icon(Icons.arrow_back_ios_new),
    //           ),
    //         ),
    //       ],
    //     )

    //     //  Column(
    //     //   children: [
    //     //     Expanded(
    //     //       flex: 1,
    //     //       child: Stack(
    //     //         children: [
    //     //           GoogleMap(
    //     //             markers: {if (_marker != null) _marker!},
    //     //             mapType: MapType.terrain,
    //     //             zoomControlsEnabled: false,
    //     //             zoomGesturesEnabled: true,
    //     //             initialCameraPosition: _kGooglePlex,
    //     //             onMapCreated: (GoogleMapController controller) {
    //     //               controller.setMapStyle(mapStyles);
    //     //               _controller.complete(controller);
    //     //             },
    //     //           ),
    //     //           Positioned(
    //     //             bottom: 30,
    //     //             left: 10,
    //     //             child: FloatingActionButton.extended(
    //     //               onPressed: _goToTheLake,
    //     //               label: Text('To the shop!'),
    //     //               icon: Icon(Icons.shopify_sharp),
    //     //             ),
    //     //           ),
    //     //           Positioned(
    //     //               top: 50,
    //     //               left: 5,
    //     //               child: IconButton(
    //     //                 onPressed: () {
    //     //                   Navigator.pop(context);
    //     //                 },
    //     //                 icon: Icon(Icons.arrow_back_ios_new),
    //     //               ))
    //     //         ],
    //     //       ),
    //     //     ),
    //     //     Expanded(
    //     //       flex: 1,
    //     //       child: Container(
    //     //           decoration: BoxDecoration(
    //     //         color: Colors.white,
    //     //         borderRadius: BorderRadius.only(
    //     //           topLeft: Radius.circular(30),
    //     //           topRight: Radius.circular(30),
    //     //         ),
    //     //       )),
    //     //     )
    //     //   ],
    //     // ),
    //     // floatingActionButton: FloatingActionButton.extended(
    //     //   onPressed: _goToTheLake,
    //     //   label: Text('To the lake!'),
    //     //   icon: Icon(Icons.directions_boat),
    //     // ),
    //     );
  }
}
