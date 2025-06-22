import 'package:kobin/common/common_path_list.dart';
import 'package:kobin/plugin_list.dart';
import 'package:kobin/routes/index.dart';
import 'package:kobin/widgets/common_filter/filter_sublayout_categories.dart';
import 'package:kobin/widgets/common_filter/filter_sublayout_cities.dart';
import 'package:kobin/widgets/common_filter/filter_sublayout_companies.dart';
import 'package:kobin/widgets/common_filter/filter_sublayout_departments.dart';
import 'package:kobin/widgets/common_filter/filter_sublayout_sizes.dart';
import 'package:kobin/widgets/common_filter/filter_sublayout_styles.dart';
import '../../config.dart';
import 'package:intl/intl.dart';

class FurnitureFilterLayout extends StatefulWidget {
  const FurnitureFilterLayout({super.key});
  @override
  State<FurnitureFilterLayout> createState() => _FurnitureFilterLayoutState();
}

class _FurnitureFilterLayoutState extends State<FurnitureFilterLayout> {
  // Sort by data
  final List<String> sortByList = appArray.filterList[0]['filterData']
      .map<String>((item) => item["subtitle"] as String)
      .toList();
  String? selectedSortBy;

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('###,###,###');
    return Consumer2<FilterProvider, CurrencyProvider>(
      builder: (context2, filter, currency, child) {
        return StatefulWrapper(
          onInit: () => {filter.onFilterReady(currency)},
          onDispose: () => {filter.updateValueRangeData(RangeValues(0, 0))},
          child: Scaffold(
            backgroundColor: appColor(context).appTheme.backGroundColorMain,
            //appbar text
            appBar: AppBar(
              title: Text(
                language(context, appFonts.filter),
                overflow: TextOverflow.ellipsis,
                style: appCss.dmPoppinsSemiBold20.textColor(
                  isThemeColorReturn(context),
                ),
              ),
              elevation: 3,
              shadowColor: appColor(context).appTheme.shadowColorSix,
              centerTitle: true,
              backgroundColor: appColor(context).appTheme.whiteColor,
              // appbar icon
              leading: IconButton(
                icon: CommonWidget()
                    .svgImage(
                      context,
                      svgAssets.iconNextArrow,
                      svgAssets.iconBackArrow,
                    )
                    .paddingOnly(left: Insets.i10),
                onPressed: () => route.pop(context),
              ),
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const VSpace(Sizes.s25),
                        GridView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            childAspectRatio: 2.3,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 12.0,
                            maxCrossAxisExtent: 300,
                          ),
                          children: [
                            SingleSelectDropdown(
                              items: sortByList,
                              selectedValue: selectedSortBy,
                              title: appFonts.sortBy,
                            ),
                            MultiSelectDropdown(),
                            MultiSelectDropdown(),
                            MultiSelectDropdown(),
                            MultiSelectDropdown(),
                            MultiSelectDropdown(),
                            MultiSelectDropdown(),
                            MultiSelectDropdown(),
                          ],
                        ),
                        FilterSubLayoutPrice(),
                      ],
                    ).paddingOnly(bottom: Insets.i90),
                  ),

                  // Row(
                  //   children: [
                  // FilterMainListLayout(),
                  // FilterSortSubLayout(),
                  // FilterColorSubLayout(),
                  // FilterSubLayoutDepartments(),
                  // FilterSubLayoutCategories(),
                  // FilterSubLayoutCities(),
                  // FilterSubLayoutStyles(),
                  // FilterSubLayoutCompanies(),
                  // FilterSubLayoutSizes(),
                  //   ],
                  // ),

                  //bottom button layout
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FilterButtonSubLayout(),
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

class MultiSelectDropdown extends StatefulWidget {
  MultiSelectDropdown({super.key});

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  final List<String> items = [
    'red',
    'blue',
    'black',
    'green',
    'orange',
    'cyan',
    'yellow',
    'pink',
  ];

  List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          child: Text(
            // language(context, 'widget.title'),
            'Color',
            style: appCss.dmPoppinsSemiBold16.textColor(
              appColor(context).appTheme.txtColor,
            ),
          ).paddingOnly(
            left: Insets.i22,
            bottom: Insets.i3,
          ),
          alignment: Alignment.centerLeft,
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Row(
              children: [
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    'Select',
                    style: appCss.dmPoppinsRegular18.textColor(
                      appColor(context).appTheme.txtColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                //disable default onTap to avoid closing menu when selecting an item
                enabled: false,
                child: StatefulBuilder(
                  builder: (context, menuSetState) {
                    final isSelected = selectedItems.contains(item);
                    return InkWell(
                      onTap: () {
                        isSelected
                            ? selectedItems.remove(item)
                            : selectedItems.add(item);
                        //This rebuilds the StatefulWidget to update the button's text
                        setState(() {});
                        //This rebuilds the dropdownMenu Widget to update the check mark
                        menuSetState(() {});
                      },
                      child: Container(
                        height: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            if (isSelected)
                              const Icon(Icons.check_box_outlined)
                            else
                              const Icon(Icons.check_box_outline_blank),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
            //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
            value: selectedItems.isEmpty ? null : selectedItems.last,
            onChanged: (value) {},
            selectedItemBuilder: (context) {
              return items.map(
                (item) {
                  return Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      selectedItems.join(', '),
                      style: const TextStyle(
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  );
                },
              ).toList();
            },
            buttonStyleData: ButtonStyleData(
              height: 50,
              width: 160,
              padding: const EdgeInsets.only(
                left: 14,
                right: 14,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                border: Border.all(
                  color: Colors.black26,
                ),
                color: Colors.white,
              ),
            ),
            iconStyleData: IconStyleData(
              icon: Icon(
                Icons.keyboard_arrow_down_sharp,
              ),
              iconSize: 25,
              iconEnabledColor: appColor(context).appTheme.txtColor,
              iconDisabledColor: Colors.grey,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                color: appColor(context).appTheme.whiteColor,
              ),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all<double>(6),
                thumbVisibility: MaterialStateProperty.all<bool>(true),
              ),
            ),
            menuItemStyleData: MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
              overlayColor: WidgetStatePropertyAll(
                appColor(context).appTheme.backGroundColorMain,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/////////////////////////////////////////////////

class SingleSelectDropdown extends StatefulWidget {
  SingleSelectDropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.title,
  });

  final List<String> items;
  late String? selectedValue;
  late String title;

  @override
  State<SingleSelectDropdown> createState() => _SingleSelectDropdownState();
}

class _SingleSelectDropdownState extends State<SingleSelectDropdown> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FilterProvider>(
      builder: (context1, filter, child) {
        return Column(
          children: [
            Align(
              child: Text(
                language(context, widget.title),
                style: appCss.dmPoppinsSemiBold16.textColor(
                  appColor(context).appTheme.txtColor,
                ),
              ).paddingOnly(
                left: Insets.i22,
                bottom: Insets.i3,
              ),
              alignment: Alignment.centerLeft,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Row(
                  children: [
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Text(
                        'Select',
                        style: appCss.dmPoppinsRegular18.textColor(
                          appColor(context).appTheme.txtColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                items: widget.items
                    .map(
                      (String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          language(context, item),
                          style: appCss.dmPoppinsRegular14.textColor(
                            appColor(context).appTheme.txtColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                value: widget.selectedValue,
                onChanged: (String? value) {
                  int index = widget.items.indexOf(value!);
                  filter.onSelectSortByMethod(index);
                  setState(() {
                    widget.selectedValue = value;
                  });

                  // print(language(context, value));
                },
                buttonStyleData: ButtonStyleData(
                  height: 50,
                  width: 160,
                  padding: const EdgeInsets.only(
                    left: 14,
                    right: 14,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.r12),
                    border: Border.all(
                      color: Colors.black26,
                    ),
                    color: Colors.white,
                  ),
                ),
                iconStyleData: IconStyleData(
                  icon: Icon(
                    Icons.keyboard_arrow_down_sharp,
                  ),
                  iconSize: 25,
                  iconEnabledColor: appColor(context).appTheme.txtColor,
                  iconDisabledColor: Colors.grey,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.r12),
                    color: appColor(context).appTheme.whiteColor,
                  ),
                  // offset: const Offset(-20, 0),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(40),
                    thickness: MaterialStateProperty.all<double>(6),
                    thumbVisibility: MaterialStateProperty.all<bool>(true),
                  ),
                ),
                menuItemStyleData: MenuItemStyleData(
                  height: 40,
                  padding: EdgeInsets.only(left: 14, right: 14),
                  overlayColor: WidgetStatePropertyAll(
                    appColor(context).appTheme.backGroundColorMain,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
