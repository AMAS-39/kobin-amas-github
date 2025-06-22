import '../../config.dart';

class AppArray {
  //onboarding
  List<Map<String, dynamic>> onBoardingList = [
    {
      "id": 1,
      "image": imageAssets.onBoardingChair,
      "title": appFonts.officeFurniture,
      "subtext": appFonts.officeFurnitureDetails,
    },
    {
      "id": 2,
      "image": imageAssets.onBoardingSofa,
      "title": appFonts.relaxingFurniture,
      "subtext": appFonts.officeFurnitureDetails,
    },
    {
      "id": 3,
      "image": imageAssets.onBoardingTable,
      "title": appFonts.homeDecor,
      "subtext": appFonts.officeFurnitureDetails,
    },
  ];
//home furniture list
  List<Map<String, dynamic>> furnitureType = [
    {"image": svgAssets.iconSofa, "title": appFonts.sofa},
    {"title": appFonts.table},
    {"title": appFonts.cubBoard},
    {"title": appFonts.lamp},
    {"title": appFonts.chair},
    {"title": appFonts.cabinets},
  ];
  //bottom dashboard
  List<Map<String, dynamic>> dashboardList = [
    {
      "icon": svgAssets.iconHome,
      "fillIcon": svgAssets.iconHomeFill,
      "name": "Home"
    },
    {
      "icon": svgAssets.iconBox,
      "fillIcon": svgAssets.iconBoxFill,
      "name": "Companies"
    },
    {
      "icon": svgAssets.iconCategory,
      "fillIcon": svgAssets.iconCategoryFill,
      "name": "Departments"
    },

    // {"icon": svgAssets.iconDashboardCart, "fillIcon": svgAssets.iconCartFill},
    {
      "icon": svgAssets.iconWishlist,
      "fillIcon": svgAssets.iconWishlistFill,
      "name": "Favourites"
    },
    {
      "icon": svgAssets.iconDashboardProfile,
      "fillIcon": svgAssets.iconProfileFill,
      "name": "Profile"
    }
  ];
  //new arrival
  List<dynamic> newArrival = [
    // {
    //   "image": imageAssets.imageChairOne,
    //   "title": appFonts.chairName,
    //   "description": appFonts.chairDescription,
    //   "finalAmount": appFonts.finalAmount,
    //   "amount": appFonts.amount,
    //   "rating": appFonts.rating,
    //   "qty": 1,
    //   "colorName": appFonts.blueColor,
    //   "fillIcon": svgAssets.iconWishlistOne,
    //   "icon": svgAssets.iconWishlistTwo,
    //   "isInWishlist": false,
    // },
  ];
  //trend furniture
  List<dynamic> trendFurniture = [
    // {
    //   "image": imageAssets.imageChairThree,
    //   "title": appFonts.chairNameOne,
    //   "description": appFonts.chairDescriptionOne,
    //   "finalAmount": appFonts.finalAmountOne,
    //   "amount": appFonts.saveAmount,
    //   "rating": appFonts.ratingTwo,
    //   "qty": 1,
    //   "colorName": appFonts.blueColor,
    // },
  ];
//offer zone
  List<dynamic> offerZone = [
    // {
    //   "image": imageAssets.imageTableLamp,
    //   "title": appFonts.tableLamp,
    //   "description": appFonts.tableLampDescription,
    //   "finalAmount": appFonts.finalAmountOne,
    //   "amount": appFonts.lampOfferPrice,
    //   "icon": svgAssets.iconRatingStar,
    //   "qty": 1,
    //   "colorName": appFonts.blueColor,
    //   "offerDiscount": appFonts.offerDiscount,
    //   "offer": appFonts.offerText,
    // },
  ];
  //furniture decor
  List<dynamic> furnitureDecor = [
    // {
    //   "image": imageAssets.imageJulaOne,
    //   "title": appFonts.chairName,
    //   "description": appFonts.chairDescription,
    //   "finalAmount": appFonts.finalAmount,
    //   "amount": appFonts.lampOfferPrice,
    //   "fillIcon": svgAssets.iconWishlistOne,
    //   "icon": svgAssets.iconWishlistTwo,
    //   "qty": 1,
    //   "colorName": appFonts.blueColor,
    //   "isInWishlist": false,
    // },
  ];
  //categories
  List<dynamic> categories = [
    // {
    //   "image": imageAssets.imageChairThree,
    //   "title": appFonts.chairs,
    //   "subtitle": appFonts.availableItem
    // },
    // {
    //   "image": imageAssets.imageTable,
    //   "title": appFonts.tables,
    //   "subtitle": appFonts.availableItem
    // },
    // {
    //   "image": imageAssets.imageSofaTwo,
    //   "title": appFonts.sofas,
    //   "subtitle": appFonts.availableItem
    // },
    // {
    //   "image": imageAssets.imageSmallTable,
    //   "title": appFonts.cabinets,
    //   "subtitle": appFonts.availableItem
    // },
    // {
    //   "image": imageAssets.imageJulaTwo,
    //   "title": appFonts.julo,
    //   "subtitle": appFonts.availableItem
    // },
    // {
    //   "image": imageAssets.imageLampOne,
    //   "title": appFonts.lamp,
    //   "subtitle": appFonts.availableItem
    // },
    // {
    //   "image": imageAssets.imageCupboard,
    //   "title": appFonts.cubBoard,
    //   "subtitle": appFonts.availableItem
    // }
  ];
  //cartlist
  List<Map<String, Object>> cartList = [
    // {
    //   "image": imageAssets.imageBuddyChair,
    //   "title": appFonts.buddyChair,
    //   "qty": 1,
    //   "color": Colors.blueAccent,
    //   "colorName": appFonts.blueColor,
    //   "finalAmount": appFonts.buddyChairAmount,
    //   "amount": appFonts.buddyChairDiscount,
    // },
    // {
    //   "image": imageAssets.imageLight,
    //   "title": appFonts.lamp,
    //   "qty": 2,
    //   "color": Colors.blueAccent,
    //   "colorName": appFonts.blueColor,
    //   "finalAmount": appFonts.lampAmount,
    //   "amount": appFonts.lampDiscount,
    // },
    // {
    //   "image": imageAssets.imageTableChair,
    //   "title": appFonts.tableWooden,
    //   "qty": 1,
    //   "color": Colors.blueAccent,
    //   "colorName": appFonts.blueColor,
    //   "finalAmount": appFonts.tableWoodenAmount,
    //   "amount": appFonts.buddyChairDiscount,
    // }
  ];
  //wishlist
  List<Map<String, Object>> wishlist = [
    // {
    //   "image": imageAssets.imageShinyWoodenChair,
    //   "title": appFonts.shinyWoodenChair,
    //   "qty": 1,
    //   "colorName": appFonts.blueColor,
    //   "finalAmount": appFonts.buddyChairAmount,
    //   "amount": appFonts.buddyChairDiscount,
    //   "isInWishlist": true,
    // },
    // {
    //   "image": imageAssets.imageBadRoomLamp,
    //   "title": appFonts.badRoomLamp,
    //   "qty": 1,
    //   "colorName": appFonts.blueColor,
    //   "finalAmount": appFonts.lampAmount,
    //   "amount": appFonts.lampDiscount,
    //   "isInWishlist": true,
    // },
    // {
    //   "image": imageAssets.imageFlowerVase,
    //   "title": appFonts.flowerVase,
    //   "qty": 1,
    //   "colorName": appFonts.blueColor,
    //   "finalAmount": appFonts.tableWoodenAmount,
    //   "amount": appFonts.buddyChairDiscount,
    //   "isInWishlist": true,
    // }
  ];
  //profile list
  List<Map<String, dynamic>> profileList = [
    {
      "id": 1,
      "icon": svgAssets.iconLanguageTranslate,
      "title": appFonts.language,
      "subtitle": appFonts.languageSubTitle,
      "route": routeName.language
    },
    {
      "id": 2,
      "icon": svgAssets.iconCurrency,
      "title": appFonts.currency,
      "subtitle": appFonts.currencySubtitle,
      "route": routeName.currencyScreen
    },
    // {
    //   "id": 3,
    //   "icon": svgAssets.iconSettings,
    //   "title": appFonts.setting,
    //   "subtitle": appFonts.settingSubtitle,
    //   "route": routeName.setting
    // },
    {
      "id": 3,
      "icon": svgAssets.iconTermCondition,
      "title": appFonts.termsAndCondition,
      "subtitle": appFonts.termAndConditionSubTitle,
      "route": routeName.termsCondition
    },
    {
      "id": 4,
      "icon": svgAssets.iconTrash,
      "title": appFonts.deleteAccount,
      "subtitle": appFonts.deleteAccount,
      "route": routeName.login
    },
    {
      "id": 5,
      "icon": svgAssets.arrowNew,
      "title": appFonts.logout,
      "subtitle": appFonts.logout,
      "route": routeName.login
    },
  ];
  //chair list
  List<Map<String, Object>> Productslist = [
    {
      "image": imageAssets.imageChairOne,
      "title": appFonts.chairName,
      "description": appFonts.chairDescription,
      "finalAmount": appFonts.finalAmount,
      "amount": appFonts.amount,
      "rating": appFonts.rating,
      "qty": 1,
      "colorName": appFonts.blueColor,
    },
    {
      "image": imageAssets.imageChairTwo,
      "title": appFonts.chairNameOne,
      "description": appFonts.chairDescription,
      "finalAmount": appFonts.finalAmount,
      "amount": appFonts.amount,
      "rating": appFonts.ratingOne,
      "qty": 1,
      "colorName": appFonts.blueColor,
    },
    {
      "image": imageAssets.imageChairFive,
      "title": appFonts.chairName,
      "description": appFonts.chairDescription,
      "finalAmount": appFonts.finalAmount,
      "amount": appFonts.amount,
      "qty": 1,
      "colorName": appFonts.blueColor,
      "rating": appFonts.rating,
    },
    {
      "image": imageAssets.imageChairSix,
      "title": appFonts.chairNameOne,
      "description": appFonts.chairDescription,
      "finalAmount": appFonts.finalAmountOne,
      "amount": appFonts.amount,
      "qty": 1,
      "colorName": appFonts.blueColor,
      "rating": appFonts.ratingOne,
    },
    {
      "image": imageAssets.imageChairSeven,
      "title": appFonts.sofaName,
      "description": appFonts.chairDescription,
      "finalAmount": appFonts.finalAmount,
      "amount": appFonts.amount,
      "qty": 1,
      "colorName": appFonts.blueColor,
      "rating": appFonts.rating,
    },
    {
      "image": imageAssets.imageChairEight,
      "title": appFonts.flowerVase,
      "description": appFonts.chairDescription,
      "finalAmount": appFonts.finalAmountOne,
      "amount": appFonts.amount,
      "qty": 1,
      "colorName": appFonts.blueColor,
      "rating": appFonts.ratingOne,
    },
  ];
  //filter list
  List filterList = [
    {
      "title": appFonts.sortBy,
      "filterData": [
        {"subtitle": appFonts.sortRelevance},
        {"subtitle": appFonts.sortNewest},
        {"subtitle": appFonts.sortOldest},
        {"subtitle": appFonts.sortHighestRating},
      ]
    },
    {
      "title": appFonts.colorFilter,
      "filterData": [ 
        // {"subtitle": appFonts.selectAll, "colorCode": const Color(0xffF6F6F7)},
        // {"subtitle": appFonts.blackColor, "colorCode": Colors.black},
      ],
    },
    {"title": appFonts.priceFilter, "filterData": []},
    // deparments
    {"title": appFonts.departments, "filterData": []},
    // categories
    {"title": appFonts.categories, "filterData": []},
    // cities
    {"title": appFonts.cities, "filterData": []},

    // styles
    {"title": appFonts.styles, "filterData": []},
    // companies
    {"title": appFonts.companies, "filterData": []},
    // sizes
    {"title": appFonts.sizes, "filterData": []},
  ];

  //shipping choose list
  List shippingChoose = [
    {
      'id': 1,
      "icon": svgAssets.iconBoxTick,
      "title": appFonts.economy,
      "description": appFonts.economyDescription,
      "price": appFonts.economyPrice
    },
    {
      'id': 2,
      "icon": svgAssets.iconShippingBox,
      "title": appFonts.regular,
      "description": appFonts.regularDescription,
      "price": appFonts.regularPrice
    },
    {
      'id': 3,
      "icon": svgAssets.iconTruck,
      "title": appFonts.cargo,
      "description": appFonts.cargoDescription,
      "price": appFonts.cargoPrice
    },
    {
      'id': 4,
      "icon": svgAssets.iconFastTruck,
      "title": appFonts.express,
      "description": appFonts.expressDescription,
      "price": appFonts.expressPrice
    }
  ];
  //coupon list
  List couponList = [
    {
      "offer": appFonts.couponOffer,
      "off": appFonts.offerText,
      "offerMode": appFonts.gPay,
      "offerDescription": appFonts.offerDescriptionGpay,
      "offerCode": appFonts.promoCodeOne
    },
    {
      "offer": appFonts.couponOffer,
      "off": appFonts.offerText,
      "offerMode": appFonts.gPay,
      "offerDescription": appFonts.offerDescriptionGpay,
      "offerCode": appFonts.promoCodeOne
    },
    {
      "offer": appFonts.couponOffer,
      "off": appFonts.offerText,
      "offerMode": appFonts.gPay,
      "offerDescription": appFonts.offerDescriptionGpay,
      "offerCode": appFonts.promoCodeTwo
    },
    {
      "offer": appFonts.couponOffer,
      "off": appFonts.offerText,
      "offerMode": appFonts.gPay,
      "offerDescription": appFonts.offerDescriptionGpay,
      "offerCode": appFonts.promoCodeOne
    },
    {
      "offer": appFonts.couponOffer,
      "off": appFonts.offerText,
      "offerMode": appFonts.gPay,
      "offerDescription": appFonts.offerDescriptionGpay,
      "offerCode": appFonts.promoCodeOne
    },
    {
      "offer": appFonts.couponOffer,
      "off": appFonts.offerText,
      "offerMode": appFonts.gPay,
      "offerDescription": appFonts.offerDescriptionGpay,
      "offerCode": appFonts.promoCodeOne
    },
  ];
  //shipping details list
  List shippingDetailsList = [
    {
      "id": 1,
      "location": appFonts.home,
      "locationAddress": appFonts.shippingAddressDetails,
      "phoneNumber": appFonts.phoneNumber
    },
    {
      "id": 2,
      "location": appFonts.office,
      "locationAddress": appFonts.officeAddress,
      "phoneNumber": appFonts.officePhone
    }
  ];
  //payment method
  List paymentMethod = [
    {
      "id": 1,
      "icon": svgAssets.iconMasterCard,
      "card": appFonts.masterCard,
      "date": appFonts.masterCardDate
    },
    {
      "id": 2,
      "icon": svgAssets.iconVisaCard,
      "card": appFonts.visaCard,
      "date": appFonts.visaCardDate
    },
    {"id": 3, "icon": svgAssets.iconPaypal, "title": appFonts.payPal},
    {"id": 4, "icon": svgAssets.iconApplePay, "title": appFonts.applePay},
    {"id": 5, "icon": svgAssets.iconGpay, "title": appFonts.googlePay},
    {
      "id": 6,
      "icon": svgAssets.iconCashOnDelivery,
      "title": appFonts.cashOnDelivery
    }
  ];
  //address type
  List addressType = [
    {"id": 1, "title": appFonts.home},
    {"id": 2, "title": appFonts.officeOne},
    {"id": 3, "title": appFonts.other}
  ];
  //order tracking list
  List orderTrackingList = [
    {
      "id": 1,
      "icon": svgAssets.iconTrue,
      "title": appFonts.trackingOne,
      "date": appFonts.trackingOneDate,
      "isActive": true,
      "isReadyActive": true
    },
    {
      "id": 2,
      "icon": svgAssets.iconTrue,
      "title": appFonts.trackingTwo,
      "date": appFonts.trackingTwoDate,
      "isActive": true,
      "isReadyActive": true
    },
    {
      "id": 3,
      "icon": svgAssets.iconReadySoon,
      "title": appFonts.trackingThree,
      "date": appFonts.trackingThreeDate,
      "isActive": false,
      "isReadyActive": true
    },
    {
      "id": 4,
      "icon": svgAssets.iconShipping,
      "title": appFonts.trackingFour,
      "date": appFonts.trackingFourDate,
      "isActive": false,
      "isReadyActive": false
    },
    {
      "id": 5,
      "icon": svgAssets.iconArrival,
      "title": appFonts.trackingFive,
      "date": appFonts.trackingFiveDate,
      "isActive": false,
      "isReadyActive": false
    },
  ];
  //notification list
  List notificationList = [
    {
      "id": 1,
      "icon": svgAssets.iconDiscount,
      "title": appFonts.notificationOne,
      "subtitle": appFonts.notificationSubTextOne
    },
    {
      "id": 2,
      "icon": svgAssets.iconWallet,
      "title": appFonts.notificationTwo,
      "subtitle": appFonts.notificationSubTextTwo
    },
    {
      "id": 3,
      "icon": svgAssets.iconLocationFill,
      "title": appFonts.notificationThree,
      "subtitle": appFonts.notificationSubTextThree
    },
    {
      "id": 4,
      "icon": svgAssets.iconCard,
      "title": appFonts.notificationFour,
      "subtitle": appFonts.notificationSubTextFour
    },
    {
      "id": 5,
      "icon": svgAssets.iconProfileFill,
      "title": appFonts.notificationFive,
      "subtitle": appFonts.notificationSubTextFive
    }
  ];
  //page list
  List pageList = [
    {
      "title": appFonts.authScreen,
      "screen": [
        {"subtitle": appFonts.createAccount, "route": routeName.registration},
        {"subtitle": appFonts.forgotPassword, "route": routeName.forgot},
        {"subtitle": appFonts.onboarding, "route": routeName.onBoarding},
        {"subtitle": appFonts.login, "route": routeName.login},
        {"subtitle": appFonts.otp, "route": routeName.otpVerify},
        {"subtitle": appFonts.resetPassword, "route": routeName.changePassword}
      ]
    },
    {
      "title": appFonts.mainPage,
      "screen": [
        {"subtitle": appFonts.categories, "route": routeName.categoryView},
        {"subtitle": appFonts.home, "route": routeName.homePage},
        {"subtitle": appFonts.chair, "route": routeName.productData},
        {
          "subtitle": appFonts.productDetailsOne,
          "route": routeName.detailsScreen
        },
        {
          "subtitle": appFonts.productDetailsTwo,
          "route": routeName.detailsScreenSecond
        }
      ]
    },
    {
      "title": appFonts.cartOrderPayment,
      "screen": [
        {"subtitle": appFonts.cart, "route": routeName.cartView},
        {"subtitle": appFonts.checkOut, "route": routeName.checkOut},
        {"subtitle": appFonts.coupon, "route": routeName.couponCode},
        {"subtitle": appFonts.addNewAddress, "route": routeName.addNewAddress},
        {"subtitle": appFonts.addCard, "route": routeName.addCard},
        {"subtitle": appFonts.orderTracker, "route": routeName.oderTracking},
        {"subtitle": appFonts.payment, "route": routeName.payment},
        {"subtitle": appFonts.orderDetail, "route": routeName.orderDetails},
        {
          "subtitle": appFonts.shippingAddress,
          "route": routeName.shippingScreen
        },
      ]
    },
    {
      "title": appFonts.profileSettingsPage,
      "screen": [
        {"subtitle": appFonts.help, "route": routeName.help},
        {"subtitle": appFonts.language, "route": routeName.language},
        {
          "subtitle": appFonts.deliveryAddress,
          "route": routeName.shippingDetails
        },
        {"subtitle": appFonts.notification, "route": routeName.notification},
        {"subtitle": appFonts.orderHistory, "route": routeName.orderHistory},
        {"subtitle": appFonts.profile, "route": routeName.profile},
        {
          "subtitle": appFonts.profileSetting,
          "route": routeName.profileSetting
        },
        {"subtitle": appFonts.setting, "route": routeName.setting},
        {"subtitle": appFonts.wishlist, "route": routeName.wishlist},
        {
          "subtitle": appFonts.termsAndCondition,
          "route": routeName.termsCondition
        }
      ]
    },
    {
      "title": appFonts.otherPage,
      "screen": [
        {"subtitle": appFonts.emptyWishList, "route": routeName.emptyWishList},
        {
          "subtitle": appFonts.emptyNotification,
          "route": routeName.emptyNotification
        },
        {"subtitle": appFonts.emptySearch, "route": routeName.emptySearch},
        {"subtitle": appFonts.emptyCart, "route": routeName.emptyCart},
        {
          "subtitle": appFonts.emptyOrderHistory,
          "route": routeName.emptyOrderHistory
        },
        {"subtitle": appFonts.search, "route": routeName.productData},
      ]
    }
  ];
  //order history list
  List orderHistory = [
    {
      "image": imageAssets.imageChairThree,
      "title": appFonts.chairNameOne,
      "qty": 1,
      "status": appFonts.dispatched,
      "deliveryStatus": appFonts.onGoing,
      "orderDeliveryDate": appFonts.orderDate,
      "isMap": false,
      "dispatch": ''
    },
    {
      "image": imageAssets.imageLightLamp,
      "title": appFonts.chairNameOne,
      "qty": 1,
      "status": appFonts.viewDetails,
      "deliveryStatus": appFonts.onGoing,
      "orderDeliveryDate": appFonts.orderDate,
      "isMap": true,
      "dispatch": appFonts.dispatch
    },
    {
      "image": imageAssets.imageTableChair,
      "title": appFonts.chairNameOne,
      "qty": 1,
      "status": appFonts.viewDetails,
      "deliveryStatus": appFonts.delivery,
      "orderDeliveryDate": appFonts.orderDate,
      "isMap": true,
      "dispatch": appFonts.dispatch
    },
  ];
  //check delivery list
  List checkDeliveryList = [
    {"id": 1, "icon": svgAssets.iconFastTruck, "title": appFonts.freeDelivery},
    {"id": 2, "icon": svgAssets.iconDollar, "title": appFonts.codAvailable},
    {"id": 3, "icon": svgAssets.iconReturn, "title": appFonts.returnPolicy}
  ];
  //review list
  List reviewList = [
    {
      "id": 1,
      "image": imageAssets.imageReviewOne,
      "name": appFonts.reviewNameOne,
      "time": appFonts.reviewTimeOne,
      "rating": appFonts.rating,
      "description": appFonts.reviewDescriptionOne,
    },
    {
      "id": 2,
      "image": imageAssets.imageReviewTwo,
      "name": appFonts.reviewNameTwo,
      "time": appFonts.reviewTimeTwo,
      "rating": appFonts.ratingOne,
      "description": appFonts.reviewDescriptionTwo,
    }
  ];
  //review customer list
  List reviewCustomerList = [
    {
      "id": 1,
      "image": imageAssets.imageReviewOne,
      "name": appFonts.reviewNameOne,
      "time": appFonts.reviewTimeOne,
      "rating": appFonts.rating,
      "description": appFonts.reviewDescriptionOne,
    },
    {
      "id": 2,
      "image": imageAssets.imageReviewTwo,
      "name": appFonts.reviewNameTwo,
      "time": appFonts.reviewTimeTwo,
      "rating": appFonts.ratingOne,
      "description": appFonts.reviewDescriptionTwo,
    },
    {
      "id": 1,
      "image": imageAssets.imageReviewOne,
      "name": appFonts.reviewNameOne,
      "time": appFonts.reviewTimeOne,
      "rating": appFonts.rating,
      "description": appFonts.reviewDescriptionOne,
    },
    {
      "id": 2,
      "image": imageAssets.imageReviewTwo,
      "name": appFonts.reviewNameTwo,
      "time": appFonts.reviewTimeTwo,
      "rating": appFonts.ratingOne,
      "description": appFonts.reviewDescriptionTwo,
    },
    {
      "id": 1,
      "image": imageAssets.imageReviewOne,
      "name": appFonts.reviewNameOne,
      "time": appFonts.reviewTimeOne,
      "rating": appFonts.rating,
      "description": appFonts.reviewDescriptionOne,
    },
    {
      "id": 2,
      "image": imageAssets.imageReviewTwo,
      "name": appFonts.reviewNameTwo,
      "time": appFonts.reviewTimeTwo,
      "rating": appFonts.ratingOne,
      "description": appFonts.reviewDescriptionTwo,
    }
  ];
  //image slider array details 1
  List<String> imageArray = [
    imageAssets.imageSliderChair,
    imageAssets.imageSliderChairTwo,
    imageAssets.imageSliderChair,
    imageAssets.imageSliderChairTwo,
    imageAssets.imageSliderChair,
  ];
  //video slider array list

  //color list
  List colorList = [
    {
      "colorCode": Colors.amber,
      "active": true,
    },
    {
      "colorCode": Colors.blue,
      "active": false,
    },
    {
      "colorCode": Colors.lightGreen,
      "active": false,
    }
  ];
  //image slider array details 2
  List<String> imageArraySecond = [
    imageAssets.imageSliderChairThree,
    imageAssets.imageSliderChairFour,
    imageAssets.imageSliderChairFive,
  ];
  //color lict
  List colorListSecond = [
    {
      "colorCode": Colors.amber,
      "active": false,
    },
    {
      "colorCode": Colors.blue,
      "active": true,
    },
    {
      "colorCode": Colors.lightGreen,
      "active": false,
    },
    {
      "colorCode": Colors.grey,
      "active": false,
    }
  ];
  //details data
  List detailsData = [
    {"icon": svgAssets.iconDetailsCm, "title": appFonts.detailsCM},
    {"icon": svgAssets.iconDetailsCMetter, "title": appFonts.detailsCMetter},
    {"icon": svgAssets.iconDetailLB, "title": appFonts.detailsLB},
    {"icon": svgAssets.iconDetailsKg, "title": appFonts.detailsKG}
  ];
  //currency list
  var currencyList = [
    {
      "id": 0,
      "code": "IQD",
      'title': appFonts.IQD,
      "symbol": "IQD",
      "no_of_decimal": "2.00",
      "exchange_rate": "1.00",
      "thousands_separator": "comma",
      "decimal_separator": "comma",
      "system_reserve": "0",
      "status": "1",
      "created_by_id": null,
      "created_at": "2023-09-08T16:55:08.000000Z",
      "updated_at": "2023-11-13T03:43:17.000000Z",
      "deleted_at": null,
      "icon": svgAssets.iconDetailsDollar,
      "media": [
        {"id": 1, "original_url": svgAssets.iconDetailsDollar}
      ]
    },
    {
      "id": 1,
      "code": "USD",
      'title': appFonts.dollar,
      "symbol": "\$",
      "no_of_decimal": "2.00",
      "exchange_rate": "1.00",
      "thousands_separator": "comma",
      "decimal_separator": "comma",
      "system_reserve": "0",
      "status": "1",
      "created_by_id": null,
      "created_at": "2023-09-08T16:55:08.000000Z",
      "updated_at": "2023-11-13T03:43:17.000000Z",
      "deleted_at": null,
      "icon": svgAssets.iconDetailsDollar,
      "media": [
        {"id": 1, "original_url": svgAssets.iconDetailsDollar}
      ]
    },
    // {
    //   "id": 2,
    //   "code": "INR",
    //   "symbol": "₹",
    //   'title': appFonts.inr,
    //   "no_of_decimal": "2.00",
    //   "exchange_rate": "83.24",
    //   "thousands_separator": "comma",
    //   "decimal_separator": "comma",
    //   "system_reserve": "1",
    //   "status": "1",
    //   "created_by_id": null,
    //   "created_at": "2023-09-08T16:55:08.000000Z",
    //   "updated_at": "2023-11-13T03:43:17.000000Z",
    //   "deleted_at": null,
    //   "icon": svgAssets.iconINR,
    //   "media": [
    //     {"id": 2, "original_url": svgAssets.iconINR}
    //   ]
    // },
    // {
    //   "id": 3,
    //   "code": "GBP",
    //   'title': appFonts.pound,
    //   "symbol": "£",
    //   "no_of_decimal": "2.00",
    //   "exchange_rate": "100.00",
    //   "thousands_separator": "comma",
    //   "decimal_separator": "comma",
    //   "system_reserve": "0",
    //   "status": "1",
    //   "created_by_id": null,
    //   "created_at": "2023-09-08T16:55:08.000000Z",
    //   "updated_at": "2023-09-08T16:55:08.000000Z",
    //   "deleted_at": null,
    //   "icon": svgAssets.iconPound,
    //   "media": [
    //     {"id": 3, "original_url": svgAssets.iconPound}
    //   ]
    // },
    // {
    //   "id": 4,
    //   "code": "EUR",
    //   "symbol": "€",
    //   'title': appFonts.euro,
    //   "no_of_decimal": "2.00",
    //   "exchange_rate": "0.01",
    //   "thousands_separator": "comma",
    //   "decimal_separator": "comma",
    //   "system_reserve": "0",
    //   "status": "1",
    //   "created_by_id": null,
    //   "created_at": "2023-09-08T16:55:08.000000Z",
    //   "updated_at": "2023-09-08T16:55:08.000000Z",
    //   "deleted_at": null,
    //   "icon": svgAssets.iconEuro,
    //   "media": [
    //     {"id": 4, "original_url": svgAssets.iconEuro}
    //   ]
    // }
  ];
  //local list
  var localList = <Locale>[
    const Locale('en'),
    const Locale('ar'),
    const Locale('fa'),
  ];
  //language list
  List languageList = [
    {
      "title": appFonts.english,
      "locale": const Locale('en', 'EN'),
      "code": "en"
    },
    {
      "title": appFonts.arabic,
      "locale": const Locale("ar", 'AE'),
      "code": "ar"
    },
    {"title": appFonts.kurdish, "locale": const Locale('fa'), "code": "fa"},
  ];
  //setting list
  List settingList = [
    {"id": 1, "title": appFonts.dartLight},
    // {"id": 2, "title": appFonts.rtl},
    {"id": 3, "title": appFonts.notification},
  ];
//drawer list
  List drawerList = [
    {"id": 1, "title": appFonts.rtl},
    {"id": 2, "title": appFonts.dark},
    {"id": 3, "title": appFonts.pageList, "route": routeName.pageList},
    {"id": 4, "title": appFonts.setting, "route": routeName.setting},
    {"id": 5, "title": appFonts.logout, "route": routeName.login},
  ];
//help list
  List helpList = [
    {
      "title": appFonts.queryOne,
      "isSublistOpen": false,
      "sublist": [
        {"subtitle": appFonts.queryOneSolution}
      ],
    },
    {
      "title": appFonts.queryTwo,
      "isSublistOpen": false,
      "sublist": [
        {"subtitle": appFonts.queryTwoSolutionOne},
        {"subtitle": appFonts.queryTwoSolutionSecond},
        {"subtitle": appFonts.queryTwoSolutionThird},
        {"subtitle": appFonts.queryTwoSolutionFour}
      ]
    },
    {
      "title": appFonts.queryThird,
      "isSublistOpen": false,
      "sublist": [
        {"subtitle": appFonts.queryThirdSolution},
        {"subtitle": appFonts.queryThirdSolutionOne},
        {"subtitle": appFonts.queryThirdSolutionTwo},
        {"subtitle": appFonts.queryThirdSolutionThree},
        {"subtitle": appFonts.queryThirdSolutionFour},
        {"subtitle": appFonts.queryThirdSolutionFive}
      ]
    },
    {
      "title": appFonts.queryFour,
      "isSublistOpen": false,
      "sublist": [
        {"subtitle": appFonts.queryThirdSolution},
        {"subtitle": appFonts.queryThirdSolutionOne},
        {"subtitle": appFonts.queryThirdSolutionTwo},
        {"subtitle": appFonts.queryThirdSolutionThree},
        {"subtitle": appFonts.queryThirdSolutionFour},
        {"subtitle": appFonts.queryThirdSolutionFive}
      ]
    },
    {
      "title": appFonts.queryFive,
      "isSublistOpen": false,
      "sublist": [
        {"subtitle": appFonts.queryThirdSolution},
        {"subtitle": appFonts.queryThirdSolutionOne},
        {"subtitle": appFonts.queryThirdSolutionTwo},
        {"subtitle": appFonts.queryThirdSolutionThree},
        {"subtitle": appFonts.queryThirdSolutionFour},
        {"subtitle": appFonts.queryThirdSolutionFive}
      ]
    }
  ];
  //table list
  List tableList = [
    {"title": appFonts.height, "subData": appFonts.heightCm},
    {"title": appFonts.width, "subData": appFonts.widthCm},
    {"title": appFonts.length, "subData": appFonts.lengthCm},
    {"title": appFonts.weight, "subData": appFonts.weightCm},
  ];
  //terms condition list
  List termsConditionList = [
    {
      "mainTitle": appFonts.introduction,
      "subText": [
        {"title": appFonts.introductionData},
        {"title": appFonts.introductionDataOne},
      ],
    },
    {
      "mainTitle": appFonts.introductionOne,
      "subText": [
        {"title": appFonts.introductionOneData},
        {"title": appFonts.introductionOneDataOne}
      ],
    },
    {
      "mainTitle": appFonts.introductionTwo,
      "subText": [
        {"title": appFonts.introductionTwoData},
        {"title": appFonts.dataOne},
        {"title": appFonts.dataEight}
      ],
    },
    {
      "mainTitle": appFonts.introductionThree,
      "subText": [
        {"title": appFonts.introductionThreeData},
      ],
    }
  ];
}
