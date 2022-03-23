import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vietnam_travel_app/Global/variables.dart';
import 'package:vietnam_travel_app/Models/diadanh_object.dart';
import 'package:vietnam_travel_app/Providers/diadanh_provider.dart';
import 'package:vietnam_travel_app/Providers/quanan_provider.dart';
import 'package:vietnam_travel_app/Views/diadanh/chitiet_quan_an.dart';

import '../../Models/quanan_object.dart';

class DanhSachQuanAn extends StatefulWidget {
  final DiaDanhObject? diadanh;
  const DanhSachQuanAn({Key? key, required this.diadanh}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return DanhSachQuanAnState(diadanh: diadanh);
  }
}

class DanhSachQuanAnState extends State<DanhSachQuanAn> {
  final DiaDanhObject? diadanh;

  List<QuanAnObject> lstQuanAn = [];

  DanhSachQuanAnState({required this.diadanh});

  void _loadDiaDanh() async {
    final data = await QuanAnProvider.getAllQuanAnByDiaDanh(diadanh!.id);
    setState(() {});
    lstQuanAn = data;
  }

  @override
  void initState() {
    super.initState();
    _loadDiaDanh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF0F2F5),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: Color(0XFF242A37),
            size: 20,
          ),
        ),
        title: Text(
          "Quán ăn - ${diadanh?.tinhthanh?.tenTinhThanh}",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            fontFamily: 'Roboto',
            color: Color(0XFF242A37),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0XFFFFFFFF),
      ),
      body: FutureBuilder(
        future: DiaDanhProvider.getAllDiaDanh(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (lstQuanAn.length == 0) {
            EasyLoading.showError("Không có dữ liệu");
            EasyLoading.dismiss();
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Có lỗi xảy ra!!!'),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: lstQuanAn.length,
              itemBuilder: (context, index) => Container(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                width: MediaQuery.of(context).size.width,
                height: 210,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RestaurantDetail(lstQuanAn[index].id),
                      ),
                    );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Card(
                        elevation: 1.0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.all(
                            Radius.circular(16),
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.network(
                          urlImage + lstQuanAn[index].hinhAnh,
                          /*a.image*/
                          width: double.maxFinite,
                          height: 210,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 106,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 27,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          height: 90,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadiusDirectional.only(
                                  bottomEnd: Radius.circular(16),
                                  bottomStart: Radius.circular(16)),
                              color: Color(0XFFFFFFFF),
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0X0D5E9EFF),
                                    Color(0XB30066FF)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  tileMode: TileMode.clamp)),
                        ),
                      ),
                      Positioned(
                        top: 140,
                        left: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                lstQuanAn[index].tenQuan,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 5.0,
                                      color: Color(0XFF0066FF),
                                      offset: Offset(1.5, 0.5),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0XFF0066FF),
                                          offset: Offset(1.5, 0.5),
                                          blurRadius: 5.0,
                                        ),
                                      ]),
                                  child: const FaIcon(
                                    FontAwesomeIcons.clock,
                                    color: Color(0XFFFFFFFF),
                                    size: 18,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    lstQuanAn[index].thoiGianHoatDong ?? "",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 5.0,
                                          color: Color(0XFF0066FF),
                                          offset: Offset(1.5, 0.5),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/plane.png",
                  width: 300,
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 30, bottom: 20, left: 15, right: 15),
                  child: const Text(
                    "Đang lấy dữ liệu quán ăn...",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0XFF242A37),
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(bottom: 50, left: 50, right: 50),
                  alignment: Alignment.center,
                  child: const Text(
                    "Những địa món ăn hấp dẫn đang chờ bạn thưởng thức.",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                      color: Color(0XFFB1BCD0),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: 7,
                  child: const LinearProgressIndicator(
                    color: Color(0XFF0066FF),
                    backgroundColor: Color(0XFFB1BCD0),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
