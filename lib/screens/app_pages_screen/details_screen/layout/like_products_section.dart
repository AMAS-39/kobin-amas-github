import '../../../../config.dart';
import '../../../../plugin_list.dart';

class LikeProductLayout extends StatelessWidget {
  final category_id;
  LikeProductLayout({super.key, required this.category_id});

  @override
  Widget build(BuildContext context) {
    return Consumer2<CategoryProvider, ThemeService>(
        builder: (context1, category, theme, child) {
      //gridview new arrival layout
      return StatefulWrapper(
        onInit: () => category.onSimilarProductsList(context, category_id),
        child: GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: category.simmilarProductsList.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                childAspectRatio: 0.56,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 10.0,
                maxCrossAxisExtent: 200),
            itemBuilder: (context, index) {
              return NewArrivalSubLayoutOne(
                  index: index, data: category.simmilarProductsList[index]);
            }),
      );
    });
  }
}
