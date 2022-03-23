import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vietnam_travel_app/Models/tinhthanh_object.dart';
import 'package:vietnam_travel_app/Providers/tinhthanh_provider.dart';
import 'package:vietnam_travel_app/search_page_result.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SearchPageState();
  }
}

class SearchPageState extends State<SearchPage> {
  TextEditingController txtSearch = TextEditingController();
  List<TinhThanhObject> lstTinhThanh = [];
  List<TinhThanhObject> lstTinhThanhTemp = [];
  ScrollController _scrollController = ScrollController();
  int _currentMax = 11;

  _loadTinhThanh() async {
    final data = await TinhThanhProvider.getAllTinhThanh();
    setState(() {
      lstTinhThanhTemp = data;
      _currentMax = lstTinhThanhTemp.length;
    });
    for (int i = 0; i < _currentMax; i++) {
      lstTinhThanh.add(lstTinhThanhTemp[i]);
    }
  }

  void _SearchTinhThanh() async {
    setState(() {});
    if (txtSearch.text.isEmpty) {
      lstTinhThanh = lstTinhThanhTemp;
    } else {
      lstTinhThanh = [];
      for (var item in lstTinhThanhTemp) {
        if (item.tenTinhThanh
            .toUpperCase()
            .contains(txtSearch.text.toUpperCase())) {
          lstTinhThanh.add(item);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadTinhThanh();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getData();
      }
    });
  }

  _getData() {
    if (_currentMax + 1 <= lstTinhThanhTemp.length) {
      for (int i = _currentMax; i < _currentMax + 1; i++) {
        // if (_currentMax < lstTinhThanhTemp.length) {
        lstTinhThanh.add(lstTinhThanhTemp[i]);
        // }
      }
      _currentMax += 1;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF0F2F5),
      appBar: AppBar(
        leading: null,
        leadingWidth: 0,
        titleSpacing: 0,
        elevation: 1.0,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0XFFFFFFFF),
        title: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextField(
                  textInputAction: TextInputAction.go,
                  controller: txtSearch,
                  onChanged: (String value) {
                    _SearchTinhThanh();
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Nhập địa điểm cần đến...",
                    hintStyle: TextStyle(
                      color: Color(0XFF242A37),
                    ),
                  ),
                ),
              ),
              // FaIcon(
              //   FontAwesomeIcons.search,
              //   color: Color(0XFF242A37),
              //   size: 20,
              // ),
            ],
          ),
        ),
      ),
      // Padding(
      //   padding: const EdgeInsets.only(left: 10, right: 10),
      //   child: TextButton(
      //     onPressed: () {},
      //     child: Row(
      //       children: [
      //         const FaIcon(
      //           FontAwesomeIcons.locationArrow,
      //           size: 20,
      //         ),
      //         Container(
      //           margin: const EdgeInsets.only(left: 10),
      //           child: const Text(
      //             "Sử dụng vị trí của bạn ngay bây giờ",
      //             style: TextStyle(
      //               color: Color(0XFF65676B),
      //               fontSize: 16,
      //               fontFamily: 'Roboto',
      //             ),
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        child: FutureBuilder(
          future: TinhThanhProvider.getAllTinhThanh(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Có lỗi xảy ra!!!'),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: lstTinhThanh.length,
                itemBuilder: (context, index) {
                  if (index == lstTinhThanh.length - 1 &&
                      lstTinhThanh.length > 9) {
                    if (index != lstTinhThanhTemp.length - 1 &&
                        lstTinhThanh.length > 9) {
                      // return CupertinoActivityIndicator();
                      return Shimmer.fromColors(
                          child: const Card(
                            child: ListTile(
                              title: Text(
                                "",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          baseColor: const Color(0X1A242A37),
                          highlightColor: const Color(0X33050505));
                    }
                  }
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SearchResult(tinhthanh: lstTinhThanh[index]),
                          ),
                        );
                      },
                      title: Text(
                        lstTinhThanh[index].tenTinhThanh,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(
              child: SpinKitFadingCircle(
                color: Color(0XFF0066FF),
                size: 50.0,
              ),
            );
          },
        ),
      ),
      // body:

      //     // List<TinhThanhObject> lstTinhThanh = snapshot.data!;
      //     ListView.builder(
      //   controller: _scrollController,
      //   scrollDirection: Axis.vertical,
      //   shrinkWrap: true,
      //   itemCount: lstTinhThanh.length + 1,
      //   itemBuilder: (context, index) {
      //     if (index == lstTinhThanh.length) {
      //       return CupertinoActivityIndicator();
      //     }
      //     return Card(
      //       child: ListTile(
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) =>
      //                   SearchResult(tinhthanh: lstTinhThanh[index]),
      //             ),
      //           );
      //         },
      //         title: Text(
      //           lstTinhThanh[index].tenTinhThanh,
      //           textAlign: TextAlign.left,
      //           style: const TextStyle(
      //             fontFamily: 'Roboto',
      //             fontSize: 16,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
