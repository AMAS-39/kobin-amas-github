import 'package:kobin/plugin_list.dart';
import '../../../../config.dart';

class ProductSubLayoutOne extends StatelessWidget {
  final int index;
  final dynamic data;
  final int? category_id;

  const ProductSubLayoutOne(
      {super.key, required this.index, this.data, this.category_id});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context1, category, child) {
        return GestureDetector(
          onTap: () => route.push(
              context, DetailsScreen(product: data, category_id: category_id)),
          child: Stack(
            children: [
              //grid view layout
              CommonContainerGrid(
                imagePath: data['images'][0]['url'].toString(),
                //cart button layout and click event
                // widget: CommonCartButton(
                //   imagePath: svgAssets.iconCart,
                //   onTap: () => category.moveToCart(
                //       index,
                //       category.chairList as List<Map<String, dynamic>>,
                //       context),
                // ).paddingOnly(right: Insets.i9)
              ),
              //chair page sub layout
              ProductSubLayout(
                index: index,
                data: data,
              ),
            ],
          ),
        );
      },
    );
  }
}
