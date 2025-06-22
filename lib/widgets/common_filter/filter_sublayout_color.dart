import 'package:kobin/plugin_list.dart';
import '../../config.dart';

class FilterColorSubLayout extends StatelessWidget {
  const FilterColorSubLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterProvider>(builder: (context1, filter, child) {
      return Visibility(
        visible: filter.selectedFilterIndex == 1,
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                //filter color layout select all option layout
                Container(
                  height: MediaQuery.of(context).size.height * 0.055,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.r6),
                    border: Border.all(
                      width: Sizes.s1,
                      color: appColor(context).appTheme.shadowColorSix,
                    ),
                    color: appColor(context).appTheme.searchBackground,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          language(context, appFonts.selectAll),
                          overflow: TextOverflow.ellipsis,
                          style: appCss.dmPoppinsRegular14.textColor(
                            isThemeColorReturn(context),
                          ),
                        ).paddingSymmetric(horizontal: Insets.i10),
                      ),
                      CheckBoxCommon(
                        isCheck: filter.isSelectColor,
                        onTap: () => filter.isSelectAll(
                          appArray.filterList[filter.selectedFilterIndex]
                              ['filterData'],
                        ),
                      ).paddingSymmetric(horizontal: Insets.i10)
                    ],
                  ),
                )
                    .inkWell(
                      onTap: () => filter.isSelectAll(
                          appArray.filterList[filter.selectedFilterIndex]
                              ['filterData']),
                    )
                    .paddingOnly(
                      left: Insets.i20,
                      top: Insets.i15,
                      right: Insets.i20,
                    ),
                //color list layout
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: appArray
                        .filterList[filter.selectedFilterIndex]['filterData']
                        .length,
                    itemBuilder: (BuildContext context, int index) {
                      final currentItem =
                          appArray.filterList[filter.selectedFilterIndex]
                              ['filterData'][index];
                      //color list
                      return FilterColorListSubLayout(currentItem: currentItem);
                    },
                  ),
                ),
              ],
            ).paddingOnly(bottom: 25),
          ),
        ),
      );
    });
  }
}
