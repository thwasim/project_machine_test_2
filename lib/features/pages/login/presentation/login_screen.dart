import 'package:flutter/material.dart';
import 'package:project_machine_test_2/features/constant/snack_bar.dart';
import 'package:project_machine_test_2/features/pages/home/presentation/home_screen.dart';
import 'package:project_machine_test_2/features/pages/login/controller/login_controller.dart';
import 'package:project_machine_test_2/features/resources/color_resources.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logincontroller = Provider.of<LoginController>(context);
    return Consumer<LoginController>(builder: (context, loginProvider, child) {
      void userHave() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (loginProvider.user != null) {
          loginProvider.user?.status == true ? userHave() : null;
        }
      });

      return Scaffold(
        backgroundColor: ColorResources.blackColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Text("Enter Your \nMobile Number", style: TextStyle(fontSize: 23, color: ColorResources.whiteColor)),
                const SizedBox(height: 10),
                Text(
                  "Lorem ipsum dolor sit amet consectetur. Porta at id hac vitae. Et tortor at vehicula euismod mi viverra.",
                  style: TextStyle(fontSize: 13, color: ColorResources.whiteColor.withOpacity(0.6)),
                ),
                const SizedBox(height: 35),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: ColorResources.blackColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1, color: ColorResources.whiteColor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Text("+91 ", style: TextStyle(color: ColorResources.whiteColor)),
                            Icon(Icons.arrow_drop_down, size: 20, color: ColorResources.whiteColor),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 270,
                      height: 55,
                      decoration: BoxDecoration(
                        color: ColorResources.blackColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1, color: ColorResources.whiteColor),
                      ),
                      child: TextFormField(
                        controller: logincontroller.phoneController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: ColorResources.whiteColor),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Mobile Number",
                          hintStyle: TextStyle(color: ColorResources.whiteColor.withOpacity(0.6)),
                          contentPadding: const EdgeInsets.only(left: 20, bottom: 0, top: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                if (loginProvider.isLoading)
                  const Align(alignment: Alignment.bottomCenter, child: CircularProgressIndicator())
                else
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        final phone = loginProvider.phoneController.text;
                        if (phone.isNotEmpty) {
                          loginProvider.login();
                        } else {
                          showSnackBar(context, "Enter valid credentials");
                        }
                      },
                      child: Container(
                        height: 60,
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0xFF1F1F1F),
                          border: Border.all(
                            color: ColorResources.whiteColor.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Continue", style: TextStyle(color: ColorResources.whiteColor.withOpacity(0.4), fontSize: 16)),
                            const SizedBox(width: 20),
                            CircleAvatar(
                              backgroundColor: ColorResources.redColor,
                              radius: 25,
                              child: Center(
                                child: Icon(Icons.keyboard_arrow_right_rounded, color: ColorResources.whiteColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (loginProvider.error != null)
                  Text(
                    loginProvider.error.toString(),
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 20),
                const SizedBox(height: 40)
              ],
            ),
          ),
        ),
      );
    });
  }
}
