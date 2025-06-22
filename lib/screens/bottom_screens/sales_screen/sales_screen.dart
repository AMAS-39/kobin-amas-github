import 'package:flutter/material.dart';
import 'package:kobin/config.dart';
import 'package:kobin/plugin_list.dart';
import 'package:kobin/provider/bottom_provider/sales_provider.dart';
import 'package:kobin/screens/bottom_screens/sales_screen/layout/SalesWidgets.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SalesProvider>(
      builder: (context, sales, child) {
        return StatefulWrapper(
          onInit: () => sales.onReady(),
          onDispose: () => sales.salesObjects = [],
          child: PopScope(
            canPop: true,

            //direction layout
            child: DirectionLayout(
              dChild: Scaffold(
                backgroundColor: appColor(context).appTheme.backGroundColorMain,
                body: SafeArea(
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            //appbar layout
                            CommonAppBar(
                              appName: language(context, "Companies"),
                            ),
                          ],
                        ).paddingOnly(
                          top: Insets.i15,
                          left: Insets.i20,
                          right: Insets.i20,
                        ),
                        Column(
                          children: sales.salesObjects.isEmpty
                              ? [
                                  Container(
                                    height: MediaQuery.of(context).size.height /
                                        1.5,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ]
                              : sales.salesObjects[0]["error"] != null
                                  ? [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.5,
                                        child: Center(
                                          child: Text(
                                            language(
                                              context,
                                              sales.salesObjects[0]["error"],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]
                                  : [
                                      Column(
                                        children: [
                                          GridView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            itemCount:
                                                sales.salesObjects.length,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                              childAspectRatio: 0.72,
                                              crossAxisSpacing: 12.0,
                                              mainAxisSpacing: 10.0,
                                              maxCrossAxisExtent: 200,
                                            ),
                                            itemBuilder: (context, index) {
                                              final element =
                                                  sales.salesObjects[index];
                                              return SalesWidgets()
                                                  .banner(
                                                    context,
                                                    element["logo"],
                                                    // imageAssets.bannerOne,
                                                    element["title"],
                                                    element["id"],
                                                  )
                                                  .paddingOnly(bottom: 20);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                        ).paddingAll(20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
