import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/util/map_style.dart';

class AboutUsScreen extends StatefulWidget {
  AboutUsScreen({Key? key}) : super(key: key);

  static String routeName = "/about_us";

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  LatLng pos = LatLng(10.882605, 79.679260);
  Marker? _marker;

  @override
  void initState() {
    super.initState();
    getMarker();
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    }
  }

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
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),

      // await BitmapDescriptor.fromAssetImage(
      //     ImageConfiguration(), 'assets/images/logo.png'),
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

  Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController _googleMapController;

  LatLng pinPosition = LatLng(37.3797536, -122.1017334);

//Normal view camera
  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(10.882605, 79.679260),
    zoom: 9.4746,
  );

//position moving camera with animation
  final CameraPosition _kShop = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(10.882605, 79.679260),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

//Animator
  _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kShop));
  }

  @override
  void dispose() {
    super.dispose();
    if (_googleMapController != null) {
      _googleMapController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    getMarker();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Stack(fit: StackFit.loose, children: [
              GoogleMap(
                mapType: MapType.hybrid,
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                zoomGesturesEnabled: true,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  // controller
                  // .animateCamera(CameraUpdate.newCameraPosition(_kShop));

                  controller.setMapStyle(mapStyles);
                  _controller.complete(controller);
                  setState(() {
                    _googleMapController = controller;
                    getMarker();
                  });
                },
                markers: {if (_marker != null) _marker!},
              ),
              Positioned(
                top: 50,
                left: 5,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    if (_googleMapController != null) {
                      _googleMapController.dispose();
                    }
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
            ]),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    height: 140,
                    child: Image.asset(
                      "assets/images/logo.png",
                      alignment: Alignment.center,
                    ),
                  ),
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
