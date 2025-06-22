import 'package:kobin/config.dart';
import 'package:kobin/plugin_list.dart';

class FilterSortSubLayout extends StatelessWidget {
  final int? index, selectIndex;
  final GestureTapCallback? onTap;
  const FilterSortSubLayout(
      {super.key, this.index, this.selectIndex, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Consumer2<FilterProvider, CurrencyProvider>(
      builder: (context1, filter, currency, child) {
        return StatefulWrapper(
          onInit: () => {filter.onFilterReady(currency)},
          onDispose: () => {filter.updateValueRangeData(RangeValues(0, 0))},
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                //list sort by data
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
                    //sort by list
                    return FilterSortBySubLayout(
                        index: index, currentItem: currentItem);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
