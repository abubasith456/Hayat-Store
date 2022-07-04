import 'package:flutter/material.dart';

import '../constants.dart';

NetworkImage getImage(String imageName) {
  String url = imageLoadUrl + imageName;
  return NetworkImage(url);
}
