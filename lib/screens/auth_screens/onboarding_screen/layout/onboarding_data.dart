import '../../../../config.dart';
import 'package:kobin/plugin_list.dart';

class OnBoardingData extends StatelessWidget {
  final int? index;
  final dynamic data;
  const OnBoardingData({super.key, this.index, this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer<OnBoardingProvider>(builder: (context1, rotation, child) {
      return Container(
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          const VSpace(Sizes.s40),
          //Logo set
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Image.asset(
                imageAssets.onBoardingLogo,
                fit: BoxFit.cover,
              )),
          const VSpace(Sizes.s10),
          Stack(children: [
            //OnBoarding Background cricle image
            // OnBoardingWidget().image(imageAssets.onBoardingScreen),
            //round animated cricle position set
            if (rotation.controller != null)
              // OnBoardingWidget()
              //     .circlePosition(context, rotation.controller!),
              Column(children: [
                //Center image set size all diffrent size set
                Center(
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.33,
                        width: MediaQuery.of(context).size.width * 0.60,
                        child: Image.asset(data['image'])))
              ])
          ]),
          Expanded(
              flex: 5,
              //bottom subLayout
              child: OnBoardingSubData(
                index: index,
                data: data,
              )),
        ]),
      );
    });
  }
}
