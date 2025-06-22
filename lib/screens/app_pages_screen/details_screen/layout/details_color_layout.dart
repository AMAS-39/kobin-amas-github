// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../config.dart';

class DetailsColorLayout extends StatelessWidget {
  List colors;
  List<dynamic> imagesColors;
  DetailsColorLayout({
    Key? key,
    required this.colors,
    required this.imagesColors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => print(colors), // List of hex codes
          child: Text(
            'Colors: ',
            style: appCss.dmPoppinsBold15.textColor(
              appColor(context).appTheme.primaryColor,
            ),
          ),
        ),
        //color layout list
        Builder(
          builder: (context) {
            if (colors.length == 0) {
              return SizedBox();
            } else {
              return Row(
                children: colors.asMap().entries.map(
                  (e) {
                    return DetailsColorSubLayout(
                      colors: e.value,
                      imagesColors: imagesColors,
                    );
                  },
                ).toList(),
              );
            }
          },
        ),
      ],
    ).paddingSymmetric(horizontal: Insets.i20);
  }
}
