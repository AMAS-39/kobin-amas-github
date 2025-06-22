import 'dart:convert';
import 'dart:ui';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:kobin/config.dart';
import 'package:kobin/plugin_list.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDialog extends StatelessWidget {
  var methodname;
  var number;
  final List? phoneNumbers;
  final List? whatsAppNumbers;
  ContactDialog(this.methodname, this.phoneNumbers, this.whatsAppNumbers);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 250,
          child: Container(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  child: AlertDialog(
                    backgroundColor: appColor(context).appTheme.primaryColor,
                    content: Builder(builder: (context) {
                      if (methodname == "phoneNumber") {
                        return phoneNumbers!.isNotEmpty
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 150,
                                  child: ListView.builder(
                                    itemCount: phoneNumbers?.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: InkWell(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 150,
                                                child: CommonTextLayout(
                                                  text: phoneNumbers?[index],
                                                  isStyle: true,
                                                ),
                                              ),
                                              DetailsWidget().divider(
                                                  context), // Text representing the item
                                              CommonWidget()
                                                  .svgAssetsOne(context,
                                                      svgAssets.iconPhone)
                                                  .paddingOnly(
                                                      left: Insets.i5,
                                                      right: Insets.i8)
                                                  .width(35) // Example icon
                                            ],
                                          ),
                                          onTap: () async {
                                            //set the number here
                                            bool? res =
                                                await FlutterPhoneDirectCaller
                                                    .callNumber(
                                                        phoneNumbers![index]
                                                            .toString());
                                            print(res);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : CommonTextLayout(
                                text: "No phone numbers found",
                                isStyle: true,
                              );
                      } else {
                        return whatsAppNumbers!.isNotEmpty
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                child: SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                    itemCount: whatsAppNumbers?.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: InkWell(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 150,
                                                child: CommonTextLayout(
                                                  text: whatsAppNumbers?[index],
                                                  isStyle: true,
                                                ),
                                              ), // Text representing the item
                                              CommonWidget()
                                                  .svgAssetsOne(context,
                                                      svgAssets.whatsAppIcon)
                                                  .paddingOnly(
                                                      left: Insets.i5,
                                                      right: Insets.i8)
                                                  .width(35) // Example icon
                                            ],
                                          ),
                                          onTap: () async {
                                            await launchUrl(
                                              Uri.parse(
                                                  "https://wa.me/${whatsAppNumbers?[index]}"),
                                              mode: LaunchMode
                                                  .externalNonBrowserApplication,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : CommonTextLayout(
                                text: "No WhatsApp numbers found",
                                isStyle: true,
                              );
                      }
                    }),
                    actions: <Widget>[
                      ButtonCommon(
                        title: language(context, appFonts.cancle),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  )))),
    );
  }
}

// if (methodName == "phoneNumber") {
//           // const number = 'XXXXXXXXXX'; //set the number here
//           // bool? res = await FlutterPhoneDirectCaller.callNumber(number);
//           // print(res);
//         } else if (methodName == "whatsappNumber") {
//           // await launchUrl(
//           //   Uri.parse("https://wa.me/+9647504444444"),
//           //   mode: LaunchMode.externalNonBrowserApplication,
//           // );
//         }