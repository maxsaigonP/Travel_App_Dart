import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnam_travel_app/Models/user_object.dart';
import 'package:vietnam_travel_app/Providers/user_provider.dart';

class EditInforPage extends StatefulWidget {
  const EditInforPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EditInforPageState();
  }
}

class EditInforPageState extends State<EditInforPage> {
  late int stateHoTen;
  late int stateEmail;
  late int stateSDT;
  String dropdownValueHoTen = 'Công khai';
  String dropdownValueEmail = 'Chỉ mình tôi';
  String dropdownValueSDT = 'Công khai';
  late final UserObject user;

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtHoTen = TextEditingController();
  TextEditingController txtSoDienThoai = TextEditingController();
  final formKey = GlobalKey<FormState>();
  _loadData() async {
    SharedPreferences pres = await SharedPreferences.getInstance();
    String us = pres.getString("user") ?? '';
    user = UserObject.fromJson(jsonDecode(us));
    setState(() {});
    txtEmail.text = user.email;
    txtHoTen.text = user.hoTen;
    txtSoDienThoai.text = user.soDienThoai;

    stateHoTen = user.trangThaiHoTen;
    stateEmail = user.trangThaiEmail;
    stateSDT = user.trangThaiSDT;

    stateHoTen == 1
        ? dropdownValueHoTen = 'Công khai'
        : dropdownValueHoTen = 'Chỉ mình tôi';
    stateEmail == 1
        ? dropdownValueEmail = 'Công khai'
        : dropdownValueEmail = 'Chỉ mình tôi';
    stateSDT == 1
        ? dropdownValueSDT = 'Công khai'
        : dropdownValueSDT = 'Chỉ mình tôi';
  }

  void _updateInfor() async {
    if (formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Vui lòng đợi...');
      bool isSuccess = await UserProvider.updateInfor(txtHoTen.text,
          txtEmail.text, txtSoDienThoai.text, stateHoTen, stateSDT, stateEmail);
      if (isSuccess) {
        txtEmail.text = txtEmail.text;
        txtHoTen.text = txtHoTen.text;
        txtSoDienThoai.text = txtSoDienThoai.text;
        stateHoTen = stateHoTen;
        stateSDT = stateSDT;
        stateEmail = stateEmail;
        SharedPreferences pres = await SharedPreferences.getInstance();
        UserObject newUser = await UserProvider.getUser();
        String user = jsonEncode(newUser.toJson());
        pres.setString('user', user);
        EasyLoading.showSuccess('Cập nhật thành công');
        EasyLoading.dismiss();
      } else {
        EasyLoading.showError('Cập nhật thất bại');
        EasyLoading.dismiss();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: const FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: Color(0XFF242A37),
            size: 20,
          ),
        ),
        backgroundColor: const Color(0XFFFFFFFF),
        shadowColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Thông tin tài khoản",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            fontFamily: 'Roboto',
            color: Color(0XFF242A37),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(
                    top: 20, left: 15, right: 15, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Họ tên",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0XFF242A37),
                      ),
                    ),
                    Container(
                      height: 35,
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: const Color(0XFFE4E6EB),
                      ),
                      child: DropdownButton<String>(
                        value: dropdownValueHoTen,
                        icon: const FaIcon(
                          FontAwesomeIcons.chevronDown,
                          color: Color(0XFF242A37),
                          size: 14,
                        ),
                        elevation: 1,
                        borderRadius: BorderRadius.circular(10),
                        underline: const SizedBox(),
                        style: const TextStyle(
                          color: Color(0XFF242A37),
                          fontFamily: 'Roboto',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValueHoTen = newValue!;
                            if (newValue == 'Công khai') {
                              stateHoTen = 1;
                            } else {
                              stateHoTen = 0;
                            }
                          });
                        },
                        items: <String>['Công khai', 'Chỉ mình tôi']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, bottom: 10, right: 15),
                child: TextFormField(
                  controller: txtHoTen,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Color(0XFFB1BCD0)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Color(0XFF0066FF)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Họ tên không được bỏ trống";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Email",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0XFF242A37),
                      ),
                    ),
                    Container(
                      height: 35,
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: const Color(0XFFE4E6EB),
                      ),
                      child: DropdownButton<String>(
                        value: dropdownValueEmail,
                        icon: const FaIcon(
                          FontAwesomeIcons.chevronDown,
                          color: Color(0XFF242A37),
                          size: 14,
                        ),
                        elevation: 1,
                        borderRadius: BorderRadius.circular(10),
                        underline: const SizedBox(),
                        style: const TextStyle(
                          color: Color(0XFF242A37),
                          fontFamily: 'Roboto',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValueEmail = newValue!;
                          });
                          if (newValue == 'Công khai') {
                            stateEmail = 1;
                          } else {
                            stateEmail = 0;
                          }
                        },
                        items: <String>['Công khai', 'Chỉ mình tôi']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, bottom: 10, right: 15),
                child: TextFormField(
                  readOnly: true,
                  controller: txtEmail,
                  decoration: InputDecoration(
                    fillColor: const Color(0X1A242A37),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Color(0XFFF1F2F6)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Color(0XFF0066FF)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Số điện thoại",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0XFF242A37),
                      ),
                    ),
                    Container(
                      height: 35,
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: const Color(0XFFE4E6EB),
                      ),
                      child: DropdownButton<String>(
                        value: dropdownValueSDT,
                        icon: const FaIcon(
                          FontAwesomeIcons.chevronDown,
                          color: Color(0XFF242A37),
                          size: 14,
                        ),
                        elevation: 1,
                        borderRadius: BorderRadius.circular(10),
                        underline: const SizedBox(),
                        style: const TextStyle(
                          color: Color(0XFF242A37),
                          fontFamily: 'Roboto',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValueSDT = newValue!;
                          });
                          if (newValue == 'Công khai') {
                            stateSDT = 1;
                          } else {
                            stateSDT = 0;
                          }
                        },
                        items: <String>['Công khai', 'Chỉ mình tôi']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextFormField(
                  controller: txtSoDienThoai,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Color(0XFFB1BCD0)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Color(0XFF0066FF)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Số điện thoại không được bỏ trống";
                    } else if (value.length < 10) {
                      return "Số điện thoại không hợp lệ";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                width: 374,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0XFF0066FF)),
                child: TextButton(
                  onPressed: () {
                    _updateInfor();
                  },
                  child: const Text(
                    "Cập nhật thông tin cá nhân",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                width: 374,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0XFFE4E6EB)),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Huỷ",
                    style: TextStyle(
                        color: Color(0XFF242A37),
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
