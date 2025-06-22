import 'dart:convert';
import 'dart:ui';
import 'package:kobin/common/api.dart';
import 'package:kobin/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:http/http.dart" as http;

class BlurryAddWishlistDialog extends StatefulWidget {
  final String operation;
  var data;
  BlurryAddWishlistDialog(this.operation, this.data);

  @override
  State<BlurryAddWishlistDialog> createState() =>
      _BlurryAddWishlistDialogState();
}

class _BlurryAddWishlistDialogState extends State<BlurryAddWishlistDialog> {
  TextEditingController title = new TextEditingController();
  TextEditingController details = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.data != null) {
      title.text = widget.data["title"] != null ? widget.data["title"] : "";
      details.text =
          widget.data["description"] != null ? widget.data["description"] : "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          backgroundColor: appColor(context).appTheme.backGroundColor,
          title: new CommonTextLayout(
            text: language(context, appFonts.addWishList),
            isStyle: false,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonTextFieldAddress(
                hintText: language(context, appFonts.title),
                maxLength: 30,
                controller: title,
                validator: (value) {
                  return value?.isEmpty.toString();
                },
              ),
              SizedBox(
                height: Sizes.s10,
              ),
              CommonTextFieldAddress(
                hintText: language(context, appFonts.details),
                height: Sizes.s100,
                width: Sizes.s50,
                maxLine: 3,
                maxLength: 100,
                controller: details,
              )
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonCommon(
                  width: 80,
                  height: 40,
                  color: appColor(context).appTheme.backGroundColorMain,
                  title: language(context, appFonts.cancle),
                  style: TextStyle(
                    color: appColor(context).appTheme.backGroundColor,
                    fontWeight: FontWeight.w600,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ButtonCommon(
                  width: 80,
                  height: 40,
                  title: language(context, appFonts.add),
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (context) => BlurryLoadingDialog());
                    var _sharedPreferences =
                        await SharedPreferences.getInstance();
                    var token = _sharedPreferences.getString("token");
                    var id = _sharedPreferences.get("user_id");

                    var headers = {
                      'Authorization': 'Bearer $token',
                      "Accept": 'application/json',
                      "x-api-key": api().key
                    };

                    var body = {
                      "title": title.value.text,
                      "description": details.value.text
                    };

                    //get favourite list id from backend
                    var favouriteJson;
                    if (widget.operation == "new") {
                      var fovouriteIdResponse = await http.post(
                          Uri.parse(
                              "${api().link}/customers/$id/favorite-lists"),
                          headers: headers,
                          body: body);
                      favouriteJson = json.decode(fovouriteIdResponse.body);
                    } else {
                      var fovouriteIdResponse = await http.put(
                          Uri.parse(
                              "${api().link}/customers/$id/favorite-lists/${widget.data["id"]}"),
                          headers: headers,
                          body: body);
                      favouriteJson = json.decode(fovouriteIdResponse.body);
                    }

                    if (favouriteJson["message"] != null) {
                      await showDialog(
                          context: context,
                          builder: (context) =>
                              BlurryErrorDialog(favouriteJson["message"]));
                      Navigator.of(context).pop();
                    } else {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            )
          ],
        ));
  }
}

//error message dialog
class BlurryErrorDialog extends StatelessWidget {
  final String message;
  BlurryErrorDialog(this.message);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          backgroundColor: appColor(context).appTheme.primaryColor,
          title: new CommonTextLayout(
            text: language(context, appFonts.error),
            isStyle: true,
          ),
          content: new CommonTextLayout(
            text: language(context, message),
            isStyle: true,
          ),
          actions: <Widget>[
            ButtonCommon(
              title: language(context, appFonts.okay),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}
