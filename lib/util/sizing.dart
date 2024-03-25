import 'package:flutter/material.dart';

double sizingWidthByMQ(BuildContext context, double percent) {
  return MediaQuery.of(context).size.width * percent;
}

double sizingHeightByMQ(BuildContext context, double percent) {
  return MediaQuery.of(context).size.height * percent;
}
