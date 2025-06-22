import 'package:kobin/plugin_list.dart';
import '../../config.dart';
import 'package:intl/intl.dart';

class FilterSubLayoutPrice extends StatelessWidget {
  const FilterSubLayoutPrice({super.key});

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('###,###,###');
    return Consumer2<FilterProvider, CurrencyProvider>(
        builder: (context1, filter, currency, child) {
      //filter price layout
      return Builder(builder: (context) {
        if (filter.valueRangeData.start == 0 &&
            filter.valueRangeData.end == 0) {
          return Container(
            margin: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width * 0.65,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircularProgressIndicator(),
              ],
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        language(context, appFonts.priceRange),
                        style: appCss.dmPoppinsSemiBold16.textColor(
                          isThemeColorReturn(context),
                        ),
                      ).paddingSymmetric(horizontal: Insets.i10),
                      Text(
                        language(
                          context,
                          currency.priceSymbol == "IQD"
                              ? "IQD ${formatter.format(filter.valueRangeData.start.round()).toString()} - IQD ${formatter.format(filter.valueRangeData.end.round()).toString()}"
                              : "\$ ${formatter.format(filter.valueRangeData.start.round()).toString()} - \$ ${formatter.format(filter.valueRangeData.end.round()).toString()}",
                        ),
                        textAlign: TextAlign.end,
                        style: appCss.dmPoppinsRegular14.textColor(
                          isThemeColorReturn(context),
                        ),
                      ),
                    ],
                  ),
                  //slider for price

                  SizedBox(
                      width: MediaQuery.of(context).size.width *
                          0.65, // Adjust width as needed
                      child: RangeSlider(
                          activeColor: isThemeColorReturn(context),
                          inactiveColor: appColor(context).appTheme.colorText,
                          values: filter.valueRangeData,
                          min: filter.min,
                          max: filter.max,
                          divisions: ((filter.max - filter.min) / 10).round(),
                          onChanged: (RangeValues newValues) {
                            filter.updateValueRangeData(newValues);
                          }))
                ]),
          );
        }
      });
    });
  }
}
