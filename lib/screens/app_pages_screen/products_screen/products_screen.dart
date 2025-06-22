import 'package:kobin/plugin_list.dart';
import 'package:kobin/widgets/common_subcategory.dart';
import '../../../../config.dart';

class ProductsScreen extends StatelessWidget {
  final int? department_id;

  final int? category_id;
  final int? sub_category_id;
  final int? sales_id;

  final String title;
  final String? others;
  final String? search;
  final List products;
  ProductsScreen(
      {super.key,
      this.category_id = 0,
      this.department_id = 0,
      this.sub_category_id = 0,
      this.sales_id = 0,
      required this.title,
      this.others = "none",
      this.search = "",
      products})
      : this.products = (products != null ? products : []);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CategoryProvider(),
      child: Consumer<CategoryProvider>(
        builder: (context, category, child) {
          return StatefulWrapper(
            //load event
            onInit: () => category.CategoryProdcutsonReady(
              context,
              this.category_id,
              others,
              searchTerm: search,
              sub_category_id: sub_category_id,
              department_id: department_id,
              sales_id: sales_id,
            ),
            onDispose: () {
              category.productsList = [];
              category.subCategoriesList = [];
            },
            //direction
            child: DirectionLayout(
              dChild: Scaffold(
                backgroundColor: appColor(context).appTheme.backGroundColorMain,
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //chair page appbar layout and filter layout
                        ProductsAppbarLayout(
                          title: title,
                          category_id: category_id,
                        ),
                        //subCategories

                        Builder(
                          builder: (context) {
                            if (sub_category_id == 0) {
                              return CommonSubCategory(
                                subCategories: category.subCategoriesList,
                                category_id: category_id,
                              ).paddingSymmetric(vertical: Insets.i5);
                            } else {
                              return SizedBox();
                            }
                          },
                        ),

                        //products
                        Builder(
                          builder: (context) {
                            if (products.length > 0) {
                              if (products[0]["error"] != null) {
                                return Text(products[0]['error']);
                              } else {
                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: products.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    childAspectRatio: 0.56,
                                    crossAxisSpacing: 12.0,
                                    mainAxisSpacing: 12.0,
                                    maxCrossAxisExtent: 200,
                                  ),
                                  itemBuilder: (context, index) {
                                    //chair page sub layout
                                    return ProductSubLayoutOne(
                                      index: index,
                                      data: products[index],
                                      category_id: category_id,
                                    );
                                  },
                                ).paddingSymmetric(horizontal: Insets.i20);
                              }
                            } else {
                              if (category.productsList.length > 0) {
                                // print(category.productsList[0]["error"]);

                                if (category.productsList[0]["error"] != null) {
                                  return Text(
                                    category.productsList[0]['error'],
                                  ).paddingOnly(top: Insets.i20);
                                } else {
                                  return GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: category.productsList.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                      childAspectRatio: 0.56,
                                      crossAxisSpacing: 12.0,
                                      mainAxisSpacing: 12.0,
                                      maxCrossAxisExtent: 200,
                                    ),
                                    itemBuilder: (context, index) {
                                      //chair page sub layout
                                      return ProductSubLayoutOne(
                                        index: index,
                                        data: category.productsList[index],
                                        category_id: category_id,
                                      );
                                    },
                                  ).paddingSymmetric(
                                    horizontal: Insets.i20,
                                  );
                                }
                              } else {
                                return CircularProgressIndicator();
                              }
                            }
                          },
                        ),
                        VSpace(Sizes.s30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
