import 'package:kobin/config.dart';
import 'package:kobin/plugin_list.dart';
import 'package:kobin/screens/app_pages_screen/category_screen/layout/category_sublayout.dart';

class CategoryScreen extends StatefulWidget {
  final int? department_id;
  const CategoryScreen({super.key, this.department_id});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  ScrollController controller = ScrollController();
  
  @override
  Widget build(BuildContext context) {
    return Consumer4<CategoryProvider, ThemeService, DashboardProvider,
        LanguageProvider>(
      builder: (context1, category, theme, dashboard, child, lang) {
        //page load
        return StatefulWrapper(
          onInit: () {
            //on ready function
            category.onCategoryReady(context, widget.department_id);

            //getting more categories when user is at the end of the scroll
            
          },

          //device back press
          child: WillPopScope(
            onWillPop: () async{
              Navigator.pop(context);
              return false;

            },
            
            //direction layout
            child: DirectionLayout(
              dChild: Scaffold(
                backgroundColor: appColor(context).appTheme.backGroundColorMain,
                body: SafeArea(
                  child: SingleChildScrollView(
                    controller: controller,
                    physics: ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            //appbar layout
                            CommonAppBar(
                              appName: language(context, appFonts.categories),
                              isIcon: true,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            //notification button layout
                            // CommonWidget().topAlign(
                            //     context,
                            //     //appbar button notification
                            //     CommonAppbarButton(
                            //         imagePath: isTheme(context)
                            //             ? svgAssets.iconTopNotificationWhite
                            //             : svgAssets.iconTopNotification,
                            //         onPressed: () => route.pushNamed(
                            //             context, routeName.notification)))
                          ],
                        ).paddingOnly(
                          top: Insets.i15,
                          left: Insets.i20,
                          right: Insets.i20,
                        ),
                        //search layout
                        SizedBox(
                          height: Sizes.s48,
                          //text filed
                          child: SearchTextFieldCommon(
                              controller: category.searchCtrl),
                        ).paddingSymmetric(
                            horizontal: Insets.i20, vertical: Insets.i25),
                        //category list layout
                        Builder(
                          builder: (context) {
                            if (appArray.categories.isEmpty) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (appArray.categories[0]["error"] !=
                                null) {
                              return Text(appArray.categories[0]["error"]);
                            } else {
                              return Column(
                                children: [
                                  GridView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount: appArray.categories.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                      childAspectRatio: 0.78,
                                      crossAxisSpacing: 12.0,
                                      mainAxisSpacing: 10.0,
                                      maxCrossAxisExtent: 200,
                                    ),
                                    itemBuilder: (context, index) {
                                      final category =
                                          appArray.categories[index];
                                      return CategorySubLayout(
                                        index: index,
                                        data: category,
                                      );
                                    },
                                  ),
                                ],
                              ).paddingOnly(
                                right: Insets.i20,
                                left: Insets.i20,
                                bottom: Insets.i20,
                              );

                              
                            }
                          },
                        ),
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
