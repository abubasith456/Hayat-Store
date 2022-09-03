import 'dart:async';
import 'dart:io';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:shop_app/bloc/about_us/bloc/about_us_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/services/Location/location.dart';
import 'package:shop_app/util/map_style.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatefulWidget {
  AboutUsScreen({Key? key}) : super(key: key);

  static String routeName = "/about_us";

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  Marker? _marker;
  var _latLng = LatLng(10.882605, 79.679260);

  @override
  void initState() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    }
  }

  late CameraPosition _kGooglePlex = Location.cameraPosition();
  late CameraPosition _kShop = Location.shopPosition();
  Maptheme maptheme = Maptheme();

  Set<Marker> _setMarkers = {};

  GoogleMapController? _controller;

  Map<String, Marker> _markers = {};

  CircleId? selectedCircle;
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  //Animator
  _goToTheLake() async {
    final GoogleMapController? controller = _controller;
    controller?.animateCamera(CameraUpdate.newCameraPosition(_kShop));
    _customInfoWindowController.hideInfoWindow!();
  }

  Uri url_launch() {
    if (Platform.isAndroid) {
      // add the [https]
      return Uri.parse(
          "https://api.whatsapp.com/send/?phone=%2B919585909514&text&type=phone_number&app_absent=0"); // new line
    } else {
      // add the [https]
      return Uri.parse(
          "https://api.whatsapp.com/send/?phone=%2B919585909514&text&type=phone_number&app_absent=0"); // new line
    }
  }

  final Email email = Email(
    body: 'Hello!, \n\n\n[Enter your message here]\n\n\nThank you.',
    subject: 'Request|Complaint|Update',
    recipients: ['hayatstore200@gmail.com'],
    cc: ['abubasith143@gmail.com'],
    isHTML: false,
  );

  // _launchUri() async {
  //   // https://wa.me/9585909514?text=Hello
  //   var url = Uri.parse("sms:+919585909514");
  //   if (await canLaunchUrl(url_launch())) {
  //     await launchUrl(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
  // String wpUrl = url();
  // final Uri _url = Uri.parse(url_launch());
  Future<void> _launchWhatsappUrl() async {
    if (!await launchUrl(url_launch(), mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url_launch()';
    }
  }

  Future<void> launchMail() async {
    await FlutterEmailSender.send(email);
  }

  _callNumber() async {
    const number = '+919585909514'; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
    _customInfoWindowController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _setMarkers.add(
      Marker(
        markerId: MarkerId("id"),
        position: _latLng,
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                fit: StackFit.loose,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Container(
                            height: 100,
                            width: 100,
                            child: CircleAvatar(
                              backgroundColor: kPrimaryColor,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Image.asset(
                                  "assets/images/logo.png",
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                              // backgroundImage:
                              //     AssetImage("assets/images/logo.png"),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          child: Text(
                            "Hayat Store",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: 300,
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            primary: Colors.white,
                            backgroundColor: kPrimaryColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.directions),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Get Direction"),
                            ],
                          ),
                          onPressed: () {
                            _customInfoWindowController.hideInfoWindow!();
                            MapsLauncher.launchCoordinates(
                                10.882605, 79.679260);
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
              width: double.infinity,
              height: double.infinity,
            ),
            _latLng,
          );
        },
      ),
    );
    return BlocProvider(
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
                        markers: _setMarkers,
                        onTap: (position) {
                          _customInfoWindowController.hideInfoWindow!();
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
                      CustomInfoWindow(
                        controller: _customInfoWindowController,
                        height: 200,
                        width: 300,
                        offset: 50,
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
                            color: Colors.black,
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
                      Positioned(
                        bottom: 20,
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
                      // Positioned(
                      //   bottom: 160,
                      //   right: 15,
                      //   child: Container(
                      //       width: 35,
                      //       height: 50,
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(10),
                      //           color: Colors.white),
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         children: [
                      //           MaterialButton(
                      //             onPressed: () {
                      //               showModalBottomSheet(
                      //                 context: context,
                      //                 builder: (context) => Container(
                      //                     padding: EdgeInsets.all(20),
                      //                     color: Colors.white,
                      //                     height: MediaQuery.of(context)
                      //                             .size
                      //                             .height *
                      //                         0.3,
                      //                     child: Column(
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.start,
                      //                       children: [
                      //                         Text(
                      //                           "Select Theme",
                      //                           style: TextStyle(
                      //                               color: Colors.black,
                      //                               fontWeight: FontWeight.w600,
                      //                               fontSize: 18),
                      //                         ),
                      //                         SizedBox(
                      //                           height: 20,
                      //                         ),
                      //                         Container(
                      //                           width: double.infinity,
                      //                           height: 100,
                      //                           child: ListView.builder(
                      //                             scrollDirection:
                      //                                 Axis.horizontal,
                      //                             itemCount:
                      //                                 maptheme.mapThemes.length,
                      //                             itemBuilder:
                      //                                 (context, index) {
                      //                               return GestureDetector(
                      //                                 onTap: () {
                      //                                   _controller?.setMapStyle(
                      //                                       maptheme.mapThemes[
                      //                                               index]
                      //                                           ['style']);
                      //                                   Navigator.pop(context);
                      //                                 },
                      //                                 child: Container(
                      //                                   width: 100,
                      //                                   margin: EdgeInsets.only(
                      //                                       right: 10),
                      //                                   decoration:
                      //                                       BoxDecoration(
                      //                                     borderRadius:
                      //                                         BorderRadius
                      //                                             .circular(10),
                      //                                     image:
                      //                                         DecorationImage(
                      //                                       fit: BoxFit.cover,
                      //                                       image: NetworkImage(
                      //                                           maptheme.mapThemes[
                      //                                                   index]
                      //                                               ['image']),
                      //                                     ),
                      //                                   ),
                      //                                 ),
                      //                               );
                      //                             },
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     )),
                      //               );
                      //             },
                      //             padding: EdgeInsets.all(0),
                      //             shape: RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(10),
                      //             ),
                      //             child: Icon(Icons.layers_rounded, size: 25),
                      //           ),
                      //         ],
                      //       )),
                      // )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "About us",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Address: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "1/97 A valayalkara street,\nEnangudi,\nNagapattinam District,\nPin: 609701",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Contact us: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextButton.icon(
                                      onPressed: _callNumber,
                                      icon: Icon(
                                        Icons.call,
                                        size: 18,
                                      ),
                                      label: Text(
                                        '+91 9585909514',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    TextButton.icon(
                                      onPressed: _launchWhatsappUrl,
                                      icon: SvgPicture.asset(
                                        "assets/icons/whatsapp.svg",
                                        color: kPrimaryColor,
                                      ),
                                      label: Text(
                                        '+91 9585909514',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
          );
        },
      ),
    );
  }
}
