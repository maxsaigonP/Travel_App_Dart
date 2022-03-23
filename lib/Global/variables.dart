import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vietnam_travel_app/Models/direction_object.dart';

const urlAPI = "https://shielded-lowlands-87962.herokuapp.com/api/";
const urlImage = "https://shielded-lowlands-87962.herokuapp.com/";
const apiKeyMap = "EGAzhmbOrycEXAWPWtOspStQSZKW2CACMtGM7cvm";
const apiKeyMaHoa = "0NLaBSB8R9DiF2hWdldRmcRM86X1h4mrNA8VX2oN";

SizedBox slideShimmer() {
  return SizedBox(
    height: 215,
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: 2,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => Container(
        padding: const EdgeInsets.only(left: 10),
        width: 271,
        height: 215,
        child: GestureDetector(
          onTap: () {},
          child: SizedBox(
            height: 215,
            child: Card(
              elevation: 1.0,
              color: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(16.0),
                  topEnd: Radius.circular(16.0),
                  bottomStart: Radius.circular(16.0),
                  bottomEnd: Radius.circular(16.0),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "images/j.jpg",
                    width: 271,
                    height: 132,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Check-in điểm du lịch ",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        color: Color(0XFF242A37),
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 0),
                              child: const Icon(
                                Icons.thumb_up,
                                color: Color(0XFF0066FF),
                                size: 18,
                              ),
                            ),
                            const Text(
                              " 5.6k",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                color: Color(0XFF242A37),
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: const FaIcon(
                                FontAwesomeIcons.solidEye,
                                color: Color(0XFF3EFF7F),
                                size: 18,
                              ),
                            ),
                            const Text(
                              " 6.1k",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                color: Color(0XFF242A37),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: const FaIcon(
                                FontAwesomeIcons.mapMarkerAlt,
                                color: Color(0XFFFF2D55),
                                size: 18,
                              ),
                            ),
                            const Text(
                              " Nha Trang",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                color: Color(0XFF242A37),
                                fontWeight: FontWeight.normal,
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
        ),
      ),
    ),
  );
}

SizedBox slideNhuCauShimmer() {
  return SizedBox(
    height: 35,
    child: ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {},
        child: Container(
          width: 100,
          padding: const EdgeInsets.only(left: 15, right: 15),
          margin: const EdgeInsets.only(right: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0X33B1BCD0),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    ),
  );
}

Widget shimmerBaiViet(BuildContext context) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
    ),
    child: Column(
      children: [
        Container(
          height: 10,
          width: double.infinity,
          decoration: const BoxDecoration(color: Color(0XFFF0F2F5)),
        ),
        ListTile(
          leading: GestureDetector(
            onTap: () {},
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              child: Shimmer.fromColors(
                  child: const CircleAvatar(
                    backgroundImage: AssetImage("images/no-image.jpg"),
                  ),
                  baseColor: const Color(0X1AC5B5D4),
                  highlightColor: const Color(0X1A050505)),
            ),
          ),
          title: GestureDetector(
            onTap: () {},
            child: Shimmer.fromColors(
                child: Container(
                  width: 60,
                  height: 15,
                  color: const Color(0XFFF0F2F5),
                ),
                baseColor: const Color(0X1AC5B5D4),
                highlightColor: const Color(0X1A050505)),
          ),
          subtitle: Align(
            alignment: Alignment.centerLeft,
            child: Shimmer.fromColors(
                child: Container(
                  width: 40,
                  height: 10,
                  color: const Color(0XFFF0F2F5),
                ),
                baseColor: const Color(0X1AC5B5D4),
                highlightColor: const Color(0X1A050505)),
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Shimmer.fromColors(
                child: const FaIcon(
                  FontAwesomeIcons.ellipsisV,
                  size: 16,
                  color: Color(0XFFB1BCD0),
                ),
                baseColor: const Color(0X1AC5B5D4),
                highlightColor: const Color(0X1A050505)),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Shimmer.fromColors(
              child: Container(
                width: MediaQuery.of(context).size.width - 20,
                height: 300,
                color: const Color(0XFFF0F2F5),
              ),
              baseColor: const Color(0X1AC5B5D4),
              highlightColor: const Color(0X1A050505)),
        ),
        GestureDetector(
          onTap: () {},
          child: Shimmer.fromColors(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width - 20,
                height: 30,
                color: const Color(0XFFF0F2F5),
              ),
              baseColor: const Color(0X1AC5B5D4),
              highlightColor: const Color(0X1A050505)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0),
          child: TextButton(
            onPressed: () {},
            child: Align(
              alignment: Alignment.centerLeft,
              child: Shimmer.fromColors(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 20,
                    color: const Color(0XFFF0F2F5),
                  ),
                  baseColor: const Color(0X1AC5B5D4),
                  highlightColor: const Color(0X1A050505)),
            ),
          ),
        ),
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 5),
              decoration: const BoxDecoration(
                border: Border.fromBorderSide(
                  BorderSide(
                    width: 0.5,
                    color: Color(0XFFe4e6eb),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.thumb_up_alt,
                        size: 16,
                        color: Color(0XFFB1BCD0),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Icon(
                        Icons.thumb_down_alt,
                        size: 16,
                        color: Color(0XFFB1BCD0),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.solidEye,
                        color: Color(0XFFB1BCD0),
                        size: 18,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5, right: 10),
                        child: const Text(
                          "",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0XFFB1BCD0),
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
      ],
    ),
  );
}

Container sliderTitle(String title) {
  return Container(
    margin: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
    child: Text(
      title,
      style: const TextStyle(
        color: Color(0XE6242A37),
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      ),
    ),
  );
}

Future<LatLng> acquireCurrentLocation() async {
  // Initializes the plugin and starts listening for potential platform events
  Location location = Location();

  // Whether or not the location service is enabled
  bool serviceEnabled;

  // Status of a permission request to use location services
  PermissionStatus permissionGranted;

  // Check if the location service is enabled, and if not, then request it. In
  // case the user refuses to do it, return immediately with a null result
  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {}
  }

  // Check for location permissions; similar to the workflow in Android apps,
  // so check whether the permissions is granted, if not, first you need to
  // request it, and then read the result of the request, and only proceed if
  // the permission was granted by the user
  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {}
  }

  // Gets the current location of the user
  final locationData = await location.getLocation();
  return LatLng(locationData.latitude!, locationData.longitude!);
}

Widget noData() {
  return Container(
    margin: const EdgeInsets.only(left: 10),
    child: const Text(
      "Chưa có dữ liệu",
      style: TextStyle(
        fontSize: 16,
        color: Color(0XFFB1BCD0),
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}

Widget showModalDirection(DirectionObject direction) {
  return Column(
    children: [
      Align(
        alignment: Alignment.center,
        child: Container(
          margin: const EdgeInsets.only(top: 7),
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: const Color(0X1A242A37),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
      Row(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin:
                const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 10),
            child: Text(
              direction.legs.duration.text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Color(0XFF0066FF),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 10, bottom: 10, right: 15),
            child: Text(
              "(" + direction.legs.distance.text + ")",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Color(0XFFB1BCD0),
              ),
            ),
          ),
        ],
      ),
      Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
        child: const Text(
          "Do tình trạng giao thông, hiện đây là tuyến đường nhanh nhất",
          softWrap: true,
          overflow: TextOverflow.clip,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Color(0XFFB1BCD0),
            fontSize: 16,
          ),
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
        child: const Text(
          "Các chặng",
          softWrap: true,
          overflow: TextOverflow.clip,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Color(0XE6242A37),
            fontSize: 18,
          ),
        ),
      ),
      const Divider(
        color: Color(0X99B1BCD0),
        height: 0.5,
      ),
      Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: direction.legs.steps.length,
            itemBuilder: (context, index) {
              if (index == direction.legs.steps.length - 1) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 100, left: 0, right: 0),
                  elevation: 0,
                  child: ListTile(
                    onTap: () {},
                    title: Text(
                      direction.legs.steps[index].instructions,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0XFF242A37)),
                    ),
                    subtitle: Text(
                      direction.legs.steps[index].distance.text,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0X99242A37)),
                    ),
                    trailing: Text(
                      direction.legs.steps[index].duration.text,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0X99242A37)),
                    ),
                  ),
                );
              }
              return ListTile(
                onTap: () {},
                title: Text(
                  direction.legs.steps[index].instructions,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0XFF242A37)),
                ),
                subtitle: Text(
                  direction.legs.steps[index].distance.text,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0X99242A37)),
                ),
                trailing: Text(
                  direction.legs.steps[index].duration.text,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0X99242A37)),
                ),
              );
            }),
      )
    ],
  );
}
