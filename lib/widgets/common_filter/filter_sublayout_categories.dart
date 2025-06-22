import 'package:kobin/plugin_list.dart';
import 'package:kobin/widgets/common_filter/filter_sublayout_list.dart';
import '../../config.dart';

class FilterSubLayoutCategories extends StatelessWidget {
  const FilterSubLayoutCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterProvider>(
      builder: (context1, filter, child) {
        //visibility layout
        return Visibility(
          visible: filter.selectedFilterIndex == 4,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.65,
              child: Column(
                children: [
                  VSpace(Sizes.s20),
                  Text(
                    language(context, appFonts.categories),
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.55,
                    height: 40,
                    child: DropdownButton(
                      isExpanded: true,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.black,
                      ),
                      value: filter.selectedCategory.length == 0
                          ? null
                          : filter.selectedCategory[0],
                      items: filter.categoriesReady,
                      hint: Text(
                        language(
                          context,
                          "Not selected",
                        ),
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black,
                        ),
                      ),
                      onChanged: (value) {
                        filter.selectedsubCategory.clear();
                        filter.updateSelectedCategory(context, value);
                      },
                    ),
                  ),
                  VSpace(Sizes.s20),
                  Text(
                    language(context, appFonts.subCategory),
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: DropdownButton<dynamic>(
                      isExpanded: true,
                      disabledHint: Text(
                        "disabled",
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      value: filter.selectedsubCategory.length == 0
                          ? null
                          : filter.selectedsubCategory[0],
                      items: filter.subCategoriesReady,
                      hint: Text(
                        language(
                          context,
                          "Not selected",
                        ),
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      onChanged: filter.selectedCategory.length == 0
                          ? null
                          : (value) {
                              filter.selectedsubCategory = [value];
                              filter.notifyListeners();
                            },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}



  // ListView.builder(
                //     scrollDirection: Axis.vertical,
                //     shrinkWrap: true,
                //     itemCount: appArray
                //         .filterList[filter.selectedFilterIndex]['filterData']
                //         .length,
                //     itemBuilder: (BuildContext context, int index) {
                //       print(filter.selectedFilterIndex);
                //       final currentItem =
                //           appArray.filterList[filter.selectedFilterIndex]
                //               ['filterData'][index];
                //       //dimension list
                //       return FilterListSubLayout(
                //         currentItem: currentItem,
                //         listName: "categories",
                //       );
                //     })