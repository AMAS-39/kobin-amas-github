import 'dart:convert';

import 'package:kobin/common/api.dart';
import 'package:kobin/config.dart';
import 'package:kobin/plugin_list.dart';
import "package:http/http.dart" as http;
import 'package:kobin/screens/bottom_screens/wishlist_screen/layout/add_wishlist_list.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DetailsProvider with ChangeNotifier {
  bool isDimensions = true;
  bool isCheckDelivery = true;
  bool isDetails = true;
  bool isDisableCenter = true;
  bool isReviews = true;
  bool isOverview = true;
  bool isSpecification = true;
  bool isCompany = true;
  CarouselSliderController carouselController = CarouselSliderController();
  int currentPage = 0;
  double currentValue = 0;
  bool isCurrentActive = false;
  bool isWishlist = false;
  int qty = 1;
  int stars = 5;
  int lengthMedia = 0;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  TextEditingController reviewsController = TextEditingController();
  final FocusNode reviewFocus = FocusNode();
  final FocusNode nameFocus = FocusNode();
  final FocusNode reviewsFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  bool isBack = false;

//load page
  onReady(context) {
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    isBack = data ?? false;
  }

// reviews on ready
  onDetailsReady(product) async {
    currentValue = 1 / product["images"].length + product["videos"].length;
    currentPage = 0;
    lengthMedia = product["images"].length + product["videos"].length;
    notifyListeners();
  }

//details 1 dropdown click
  isClickDown(String value) {
    if (value == appFonts.dimensions) {
      isDimensions = !isDimensions;
    } else if (value == appFonts.checkDelivery) {
      isCheckDelivery = !isCheckDelivery;
    } else if (value == appFonts.details) {
      isDetails = !isDetails;
    } else if (value == appFonts.reviews) {
      isReviews = !isReviews;
    } else if (value == appFonts.overview) {
      isOverview = !isOverview;
    } else if (value == appFonts.specification) {
      isSpecification = !isSpecification;
    } else if (value == appFonts.company) {
      isCompany = !isCompany;
    }
    notifyListeners();
  }

//details page increment
  void incrementProduct(currentitem) {
    qty = qty + 1;
    notifyListeners();
  }

//details page decrement
  void decrementProduct(currentItem) {
    if (qty > 1) {
      qty = qty - 1;
      notifyListeners();
    }
  }

//details 2 page change event
  onChange(int index) {
    currentPage = index;
    notifyListeners();
  }

//details 1 page change event
  onChangePage(int index) {
    print("index: $index currentPage: $lengthMedia");
    index == 0
        ? currentValue = (index + 1) / lengthMedia
        : index > currentPage
            ? currentValue += (index + 1) / lengthMedia
            : currentValue -= (index + 1) / lengthMedia;
    currentPage = index;

    notifyListeners();
  }

//details page wishlist in or not
  onWishlistIn(wishlist_id, product_id, is_Wished) async {
    if (is_Wished) {
      //get user id and token
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.get("token");

      //request to remove product from wish list
      var headers = {
        'Authorization': 'Bearer ${token.toString()}',
        'Accept': "application/json",
        "x-api-key": api().key
      };
      var response = await http.delete(
        Uri.parse(
            "${api().link}/favorite-lists/$wishlist_id/products/$product_id"),
        headers: headers,
      );
      if (response.statusCode != 200) {
        debugPrint('❌ Remove wishlist failed: ${response.statusCode}');
        return;
      }
      print(response.body);
    } else {
      //geting user id and token from stored database
      var prefs = await SharedPreferences.getInstance();

      var token = prefs.get("token");

      //add product to wishlist
      var headers = {
        'Authorization': 'Bearer ${token.toString()}',
        "x-api-key": api().key
      };

      var resposne = await http.post(
        Uri.parse(
            "${api().link}/favorite-lists/$wishlist_id/products/$product_id"),
        headers: headers,
      );
      if (resposne.statusCode != 200) {
        debugPrint('❌ Add to wishlist failed: ${resposne.statusCode}');
        return;
      }
      print(resposne.body);
    }
    is_Wished = !is_Wished;
    notifyListeners();
  }

  //details page write review layout
  void onShowBottomLayout(BuildContext context, product_id) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");

    if (token != null) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true, // Set to true to occupy full screen height
        builder: (BuildContext context) {
          return WriteReviewLayout(
            product_id: product_id,
          );
        },
      );
    } else {
      Navigator.pushNamed(context, routeName.login);
    }
  }

  //OrderDetails click event
  onOrderDetails(context, isBack) {
    if (isBack) {
      route.pop(context);
    } else {
      isDashboard(context);
    }
  }

  //popScope click event
  detailsPopScope(details, context) {
    if (!context.mounted) return; // Prevent navigation if widget is disposed
    try {
        if (Navigator.canPop(context)) {
            Navigator.pop(context);
        } else if (ModalRoute.of(context) != null && routeName.categoryView != null) {
            Navigator.pushReplacementNamed(context, routeName.categoryView);
        } else {
            debugPrint("❌ Navigation Error: Route not found.");
        }
    } catch (e) {
        debugPrint("❌ Error in back navigation: $e");
    }
}




  //updateReview
  void updateReview(starNum) {
    stars = starNum;
    notifyListeners();
  }

  // add review
  void addReview(context, product_id) async {
    showDialog(context: context, builder: (context) => BlurryLoadingDialog());

    var prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");

    //request to remove product from wish list
    var headers = {
      'Authorization': 'Bearer ${token.toString()}',
      'Accept': "application/json",
      "x-api-key": api().key
    };
    var body = {"rating": stars.toString(), "review": reviewsController.text};
    stars = 5;
    reviewsController.clear();
    notifyListeners();
    var response = await http.post(
        Uri.parse("${api().link}/products/$product_id/reviews"),
        headers: headers,
        body: body);
    Navigator.pop(context);
    if (response.statusCode != 200) {
      debugPrint('❌ Add review failed: ${response.statusCode}');
      return;
    }
  }
}
