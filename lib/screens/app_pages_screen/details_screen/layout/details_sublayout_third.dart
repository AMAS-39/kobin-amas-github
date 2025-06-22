import 'package:flutter_map/flutter_map.dart';
import 'package:kobin/plugin_list.dart';
import 'package:kobin/screens/app_pages_screen/details_screen/layout/details_second_layout/contact_dialog.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../config.dart';

class DetailsSubLayoutThird extends StatelessWidget {
  final dynamic product;
  const DetailsSubLayoutThird({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Consumer2<DetailsProvider, ThemeService>(
      builder: (context1, details, theme, child) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    //amount
                    Text(
                      language(
                        context,
                        '${language(context, product["price"])}',
                      ),
                      overflow: TextOverflow.ellipsis,
                      style: appCss.dmPoppinsSemiBold20.textColor(
                        isThemeColorReturn(context),
                      ),
                    ),

                    // const HSpace(Sizes.s4),
                    //amount discount
                    // Text(
                    //     language(context,
                    //         '${getSymbol(context)}${(currency(context).currencyVal * double.parse(language(context, appFonts.detailsPrice))).toStringAsFixed(1)}'),
                    //     overflow: TextOverflow.ellipsis,
                    //     style: appCss.dmPoppinsRegular14
                    //         .textColor(appColor(context).appTheme.lightText)
                    //         .textDecoration(TextDecoration.lineThrough,
                    //             color: appColor(context).appTheme.lightText,
                    //             thickness: Sizes.s2))
                  ],
                ),
                //increment and decrement layout
                // const CommonStepperContainer(),
              ],
            ),
            const VSpace(Sizes.s24),
            //details description
            Text(
              language(context, product["description"]),
              style: appCss.dmPoppinsRegular14
                  .textColor(appColor(context).appTheme.lightText),
            ).marginOnly(bottom: 20),

            //text display layout and click event
            CommonListHeader(
              text: language(context, appFonts.dimensions),
              onTap: () => details.isClickDown(appFonts.dimensions),
              isClick: details.isDimensions,
            ),
            //dimension layout

            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  ),
                  child: child,
                );
              },
              child: product["dimensions"].isNotEmpty &&
                      details.isDimensions == true
                  ? CommonContainer(
                      key: ValueKey("details"),
                      widget: DetailsDimensionTableLayout(
                        product: product["dimensions"],
                      ),
                    )
                  : Container(
                      key: ValueKey("empty"),
                    ),
            ),

            CommonListHeader(
              text: language(context, appFonts.overview),
              onTap: () => details.isClickDown(appFonts.overview),
              isClick: details.isOverview,
            ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  ),
                  child: child,
                );
              },
              child:
                  product["overview"].isNotEmpty && details.isOverview == true
                      ? CommonContainer(
                          key: ValueKey("overview"),
                          widget: DetailsDimensionTableLayout(
                            product: product["overview"],
                          ),
                        )
                      : Container(
                          key: ValueKey("empty"),
                        ),
            ),

            CommonListHeader(
              text: language(context, appFonts.specification),
              onTap: () => details.isClickDown(appFonts.specification),
              isClick: details.isSpecification,
            ),

            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  ),
                  child: child,
                );
              },
              child: product["spesifications"].isNotEmpty &&
                      details.isSpecification == true
                  ? CommonContainer(
                      key: ValueKey("spesifications"),
                      widget: DetailsDimensionTableLayout(
                        product: product["spesifications"],
                      ),
                    )
                  : Container(
                      key: ValueKey("empty"),
                    ),
            ),

            //company information
            CommonListHeader(
              text: language(context, appFonts.company),
              onTap: () => details.isClickDown(appFonts.company),
              isClick: details.isCompany,
            ),

            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  ),
                  child: child,
                );
              },
              child: details.isCompany == true
                  ? CommonContainer(
                      key: ValueKey("company"),
                      widget: Column(
                        children: [
                          Text(
                            language(
                              context,
                              '${product["showroom"]["title"]}',
                            ),
                            style: appCss.dmPoppinsBold14.textColor(
                                appColor(context).appTheme.textColor),
                          ).marginOnly(bottom: 15),
                          Text(
                            language(
                              context,
                              '${product["showroom"]["description"]}',
                            ),
                            style: appCss.dmPoppinsRegular14.textColor(
                                appColor(context).appTheme.lightText),
                          ).marginOnly(bottom: 20),
                          Container(
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: Sizes.s1,
                                color: appColor(context).appTheme.shadowColor,
                              ),
                              borderRadius:
                                  BorderRadius.circular(AppRadius.r12),
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(AppRadius.r12),
                              child: FlutterMap(
                                options: MapOptions(
                                  initialCenter: LatLng(
                                      product["map"]["center"]["lat"],
                                      product["map"]["center"]["long"]),
                                  initialZoom: 9.1,
                                ),
                                children: [
                                  TileLayer(
                                    urlTemplate:
                                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                    userAgentPackageName:
                                        'dev.fleaflet.flutter_map.example',
                                  ),
                                  MarkerLayer(
                                    markers: [
                                      ...product["map"]["markers"]
                                          .map<Marker>(
                                            (e) => Marker(
                                              point:
                                                  LatLng(e["lat"], e["long"]),
                                              width: 80,
                                              height: 80,
                                              child: InkWell(
                                                onTap: () async {
                                                  String googleUrl =
                                                      "https://www.google.com/maps/search/?api=1&query=${e["lat"]},${e["long"]}";

                                                  await launchUrl(
                                                      Uri.parse(googleUrl),
                                                      mode: LaunchMode
                                                          .externalApplication);
                                                },
                                                child: Icon(
                                                  Icons.location_on,
                                                  color: Colors.red,
                                                  size: 50,
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList()
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.85,
                                  height: Sizes.s52,
                                  //decoration
                                  decoration:
                                      DetailsWidget().decorationButton(context),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        language(context, appFonts.callToOrder),
                                        style:
                                            appCss.dmPoppinsRegular16.textColor(
                                          theme.isDarkMode
                                              ? appColor(context)
                                                  .appTheme
                                                  .primaryColor
                                              : appColor(context)
                                                  .appTheme
                                                  .whiteColor,
                                        ),
                                      ).paddingOnly(left: Sizes.s7),
                                      DetailsWidget().divider(context),
                                      const HSpace(Sizes.s20),
                                      CommonWidget()
                                          .svgAssetsOne(
                                              context, svgAssets.iconPhone)
                                          .paddingAll(5)
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => ContactDialog(
                                      'phoneNumber',
                                      product["phone"] != null
                                          ? product!["phone"] as List
                                          : [],
                                      null,
                                    ),
                                  );
                                },
                              ),
                              InkWell(
                                child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 5,
                                    height: Sizes.s52,
                                    //decoration
                                    decoration: DetailsWidget()
                                        .decorationButton(context),
                                    child: CommonWidget()
                                        .svgAssetsOne(
                                            context, svgAssets.whatsAppIcon)
                                        .paddingAll(12)
                                    // DetailsSecondBottomLayout(
                                    //   methodName: 'whatsappNumber',
                                    //   whatsAppNumbers: product["whatsapp"] != null
                                    //       ? product!["whatsapp"] as List
                                    //       : [],
                                    // ),

                                    ),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => ContactDialog(
                                      'whatsappNumber',
                                      null,
                                      product["whatsapp"] != null
                                          ? product!["whatsapp"] as List
                                          : [],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ).paddingAll(20),
                    )
                  : Container(
                      key: ValueKey("empty"),
                    ),
            ),
          ],
        );
      },
    );
  }
}
