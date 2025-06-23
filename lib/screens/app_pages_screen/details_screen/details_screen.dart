import '../../../config.dart';
import '../../../plugin_list.dart';

class DetailsScreen extends StatefulWidget {
  final dynamic product;
  final int? category_id;
  final bool isFromWishlist;
  final int index;
  final int favourite_id;

  const DetailsScreen({
    super.key,
    required this.product,
    this.category_id,
    this.isFromWishlist = false,
    this.index = 0,
    this.favourite_id = 0,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Delay calling onDetailsReady to avoid setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final details = Provider.of<DetailsProvider>(context, listen: false);
        details.onDetailsReady(widget.product);
      }
    });
  }

  Future<bool> _handleWillPop() async {
    try {
      final details = Provider.of<DetailsProvider>(context, listen: false);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          details.detailsPopScope(details, context);
        }
      });
    } catch (e) {
      debugPrint("❌ Error in back navigation: $e");
    }
    return false; // Prevent default pop
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<DetailsProvider, DirectionProvider>(
      builder: (context2, details, direction, child) {
        return WillPopScope(
          onWillPop: _handleWillPop,
          child: DirectionLayout(
            dChild: Scaffold(
              backgroundColor: isTheme(context)
                  ? appColor(context).appTheme.backGroundColorMain
                  : null,
              body: SafeArea(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          DetailsSubLayout(
                            product: widget.product,
                            category_id: widget.category_id,
                            favourite_id: widget.favourite_id,
                            isFromWishlist: widget.isFromWishlist,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
