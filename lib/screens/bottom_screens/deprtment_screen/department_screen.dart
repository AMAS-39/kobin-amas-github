import 'package:kobin/config.dart';
import 'package:kobin/plugin_list.dart';

class DepartmentScreen extends StatefulWidget {
  const DepartmentScreen({super.key});

  @override
  State<DepartmentScreen> createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
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
          category.onDepartmentReady(context);

          //getting more categories when user is at the end of the scroll
          
        },

        //device back press
        child: PopScope(
          canPop: true,
          onPopInvoked: (canPop) =>
              category.onBackPress(context, category.isBack),
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
                            appName: language(context, appFonts.departments),
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
                          controller: category.searchCtrl,
                          onSubmited: (e) => {category.searchDepartments()},
                        ),
                      ).paddingSymmetric(
                        horizontal: Insets.i20,
                        vertical: Insets.i25,
                      ),
                      //category list layout
                      Builder(
                        builder: (context) {
                          if (category.departments.isEmpty) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (category.departments[0] == "Not Found") {
                            return Center(
                              child: Text("Not Found"),
                            );
                          } else {
                            return Column(
                              children: [ 
                                GridView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: category.departments.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    childAspectRatio: 0.78,
                                    crossAxisSpacing: 12.0,
                                    mainAxisSpacing: 10.0,
                                    maxCrossAxisExtent: 200,
                                  ),
                                  itemBuilder: (context, index) {
                                    final department =
                                        category.departments[index];
                                    return DepartmentSubLayout(
                                      index: index,
                                      data: department,
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
    });
  }
}
