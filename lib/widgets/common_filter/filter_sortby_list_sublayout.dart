import '../../config.dart';
import '../../plugin_list.dart';

class FilterSortBySubLayout extends StatelessWidget {
  final int index;
  final dynamic currentItem;
  const FilterSortBySubLayout(
      {super.key, required this.index, this.currentItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterProvider>(
      builder: (context1, filter, child) {
        //filter sortby list layout
        return GestureDetector(
          onTap: () => filter.onSelectSortByMethod(index),
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
                    language(context, currentItem['subtitle'].toString()),
                    overflow: TextOverflow.ellipsis,
                    style: appCss.dmPoppinsRegular14.textColor(
                      isThemeColorReturn(context),
                    ),
                  ),
                ),
                CommonRadio(
                  onTap: () => filter.onSelectSortByMethod(index),
                  index: index,
                  selectedIndex: filter.selectedSortMethod,
                ).paddingOnly(right: Insets.i1),
              ],
            ),
          ),
        );
      },
    );
  }
}
