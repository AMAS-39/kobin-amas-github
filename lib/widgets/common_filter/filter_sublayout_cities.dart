import 'package:kobin/plugin_list.dart';
import 'package:kobin/widgets/common_filter/filter_sublayout_list.dart';
import '../../config.dart';

class FilterSubLayoutCities extends StatelessWidget {
  const FilterSubLayoutCities({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterProvider>(builder: (context1, filter, child) {
      //visibility layout
      return Visibility(
          visible: filter.selectedFilterIndex == 5,
          child: Expanded(
              child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
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
                      //dimension list
                      return FilterListSubLayout(
                        currentItem: currentItem,
                        listName: "cities",
                      );
                    })),
          )));
    });
  }
}
