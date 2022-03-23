import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnam_travel_app/Providers/user_provider.dart';
import 'package:vietnam_travel_app/Views/LoginRegister/register_page.dart';
import 'package:vietnam_travel_app/Views/ResetPassword/check_email.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:vietnam_travel_app/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  bool check = true;
  bool checkPass = true;
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  _bindingUser() async {
    SharedPreferences pres = await SharedPreferences.getInstance();
    setState(() {});

    txtEmail.text = (pres.getString('email') ?? '');
    txtPassword.text = (pres.getString('password') ?? '');
  }

  @override
  void initState() {
    super.initState();
    _bindingUser();
  }

  void _login() async {
    if (formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Vui lòng đợi...');
      bool isSuccess =
          await UserProvider.login(txtEmail.text, txtPassword.text);
      EasyLoading.showSuccess('Đăng nhập thành công!');
      if (isSuccess) {
        if (check) {
          SharedPreferences pres = await SharedPreferences.getInstance();
          pres.setString('email', txtEmail.text);
          pres.setString('password', txtPassword.text);
        }
        EasyLoading.dismiss();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyApp(),
          ),
        );
      } else {
        EasyLoading.showError('Đăng nhập thất bại!');
        EasyLoading.dismiss();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFFFFFF),
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 50,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: Color(0XFF0066FF),
            size: 20,
          ),
        ),
        backgroundColor: const Color(0XFFFFFFFF),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15, top: 15, bottom: 10),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Đăng nhập",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Roboto',
                    height: 1.2,
                    color: Color(0XFF0066FF),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(
                    top: 20, left: 15, right: 15, bottom: 10),
                child: const Text(
                  "Email",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0XFF242A37)),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, bottom: 10, right: 15),
                child: TextFormField(
                  controller: txtEmail,
                  decoration: InputDecoration(
                    hintText: "Nhập email",
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
                      return "Email không được bỏ trống";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                child: const Text(
                  "Mật khẩu",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0XFF242A37)),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, bottom: 5, right: 15),
                child: TextFormField(
                  controller: txtPassword,
                  obscureText: checkPass ? true : false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Mật khẩu không được bỏ trống";
                    } else {
                      return null;
                    }
                  },
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
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {});
                        checkPass = !checkPass;
                      },
                      icon: checkPass
                          ? const FaIcon(
                              FontAwesomeIcons.eyeSlash,
                              color: Color(0XFF65676B),
                              size: 18,
                            )
                          : const FaIcon(
                              FontAwesomeIcons.eye,
                              color: Color(0XFF65676B),
                              size: 18,
                            ),
                    ),
                    hintText: "Nhập mật khẩu",
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: const Text(
                      "Nhớ mật khẩu",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0XFF242A37)),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {});
                        check = !check;
                      },
                      icon: check
                          ? const FaIcon(
                              FontAwesomeIcons.solidCheckSquare,
                              color: Color(0XFF0066FF),
                              size: 20,
                            )
                          : const FaIcon(
                              FontAwesomeIcons.square,
                              color: Color(0XFF0066FF),
                              size: 20,
                            )),
                  Expanded(child: Container()),
                  Container(
                    margin: const EdgeInsets.only(right: 15),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CheckEmailPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Quên tài khoản ?",
                        style: TextStyle(
                            color: Color(0XFF0066FF),
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                width: 374,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0XFF0066FF)),
                child: TextButton(
                  onPressed: () {
                    _login();
                  },
                  child: const Text(
                    "Đăng nhập",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Bạn chưa có tài khoản?",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()));
                      },
                      child: const Text(
                        "Đăng ký ngay",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0XFF0066FF),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
