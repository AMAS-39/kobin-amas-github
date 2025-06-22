import '../../config.dart';
import '../../plugin_list.dart';

class FilterListSubLayout extends StatelessWidget {
  final dynamic currentItem;
  final dynamic listName;
  const FilterListSubLayout({super.key, this.currentItem, this.listName});

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterProvider>(
      builder: (context1, filter, child) {
        //dimension layout and on click event
        return GestureDetector(
          onTap: () => switch (listName) {
            "styles" => filter.isCheckBoxStyles(currentItem['id']),
            "companies" => filter.isCheckBoxCompanies(currentItem['id']),
            "sizes" => filter.isCheckBoxSizes(currentItem['id']),
            "cities" => filter.isCheckBoxCities(currentItem['id']),
            "categories" => filter.isCheckBoxCategories(currentItem['id']),
            "departments" => filter.isCheckBoxDepartment(currentItem['id']),
            Object() => null,
            null => null,
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.055,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.r6),
              border: Border.all(
                width: Sizes.s1,
                color: appColor(context).appTheme.shadowColorSix,
              ),
              color: appColor(context).appTheme.searchBackground,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: Insets.i10,
              vertical: Insets.i8,
            ),
            margin: EdgeInsets.only(
              left: Insets.i20,
              top: Insets.i15,
              right: Insets.i20,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    language(
                      context,
                      currentItem['subtitle'].toString(),
                    ),
                    overflow: TextOverflow.ellipsis,
                    style: appCss.dmPoppinsRegular14.textColor(
                      isThemeColorReturn(context),
                    ),
                  ),
                ),
                CheckBoxCommon(
                  isCheck: switch (listName) {
                    "styles" =>
                      filter.selectedStyles.contains(currentItem['id']),
                    "companies" =>
                      filter.selectedCompanies.contains(currentItem['id']),
                    "sizes" => filter.selectedSizes.contains(currentItem['id']),
                    "cities" =>
                      filter.selectedCities.contains(currentItem['id']),
                    "categories" =>
                      filter.selectedCategory.contains(currentItem['id']),
                    "departments" =>
                      filter.selectedDepartments.contains(currentItem['id']),
                    Object() => null,
                    null => null,
                  },
                  onTap: () => {
                    switch (listName) {
                      "styles" => filter.isCheckBoxStyles(currentItem['id']),
                      "companies" =>
                        filter.isCheckBoxCompanies(currentItem['id']),
                      "sizes" => filter.isCheckBoxSizes(currentItem['id']),
                      "cities" => filter.isCheckBoxCities(currentItem['id']),
                      "categories" =>
                        filter.isCheckBoxCategories(currentItem['id']),
                      "departments" =>
                        filter.isCheckBoxDepartment(currentItem['id']),
                      Object() => null,
                      null => null,
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
