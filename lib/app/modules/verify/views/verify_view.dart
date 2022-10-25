import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ud_grosir/app/modules/register/controllers/register_controller.dart';
import 'package:ud_grosir/app/routes/app_pages.dart';
import 'package:pinput/pinput.dart';

import '../controllers/verify_controller.dart';

class VerifyView extends GetView<VerifyController> {
  RegisterController registerC = Get.put(RegisterController());
  VerifyView({Key? key}) : super(key: key);
  final focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    const borderColor = Color.fromRGBO(30, 60, 87, 1);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: GoogleFonts.poppins(
        fontSize: 22,
        color: const Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: const BoxDecoration(),
    );

    final cursor = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56,
          height: 3,
          decoration: BoxDecoration(
            color: borderColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
    final preFilledWidget = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56,
          height: 3,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: const EdgeInsets.all(30),
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/sammy-38.png',
                fit: BoxFit.cover,
                width: 280,
              ),
              const SizedBox(height: 30),
              Text(
                'Verifikasi',
                style: GoogleFonts.poppins(
                    fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Text(
                'Masukkan kode yang dikirim',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    if (controller.resend) {
                      Get.toNamed(Routes.REGISTER);
                    } else {
                      return;
                    }
                  },
                  child: Text(
                    controller.resend
                        ? 'Edit Nomor'
                        : Get.arguments['phoneNumber'],
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Pinput(
                length: 6,
                pinAnimationType: PinAnimationType.slide,
                controller: controller.smsCode,
                focusNode: focusNode,
                defaultPinTheme: defaultPinTheme,
                showCursor: true,
                cursor: cursor,
                preFilledWidget: preFilledWidget,
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsRetrieverApi,
                autofocus: true,
                onChanged: (pin) {},
              ),
              // SizedBox(
              //   height: 50,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       "Kode tidak dikirim?",
              //       style: GoogleFonts.poppins(fontSize: 16),
              //     ),
              //     const SizedBox(
              //       width: 5,
              //     ),
              //     Obx(() => Text(
              //         controller.start.toString() == '30'
              //             ? ''
              //             : controller.start.toString(),
              //         style: GoogleFonts.poppins(fontWeight: FontWeight.w600)))
              //   ],
              // ),
              const SizedBox(height: 30),
              MaterialButton(
                onPressed: () async {
                  await controller.verify(Get.arguments['verificationId']);
                },
                child: Text(
                  'verifikasi',
                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
