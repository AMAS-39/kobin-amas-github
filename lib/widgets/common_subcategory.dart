import 'package:kobin/config.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart'; // ✅ Add this

class CommonSubCategory extends StatelessWidget {
  final List subCategories;
  final int? category_id;
  const CommonSubCategory(
      {super.key, required this.subCategories, this.category_id = 0});

  @override
  Widget build(BuildContext context) {
    return subCategories.isEmpty
        ? const SizedBox()
        : Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: AlignedGridView.count(
              itemCount: subCategories.length,
              scrollDirection: Axis.horizontal,
              crossAxisCount: 1,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context1) => ProductsScreen(
                        title: subCategories[index]["title"],
                        sub_category_id: subCategories[index]["id"],
                        category_id: category_id,
                        others: "subCategory",
                      ),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.r8),
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 50,
                            height: 100,
                            child: CachedNetworkImage(
                              imageUrl: subCategories[index]["image"].toString(),
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Text(
                              subCategories[index]["title"],
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
