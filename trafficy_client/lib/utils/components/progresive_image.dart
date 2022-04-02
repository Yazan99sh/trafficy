import 'package:flutter/material.dart';
import 'package:trafficy_client/utils/customIcon/mandob_icons_icons.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:trafficy_client/consts/urls.dart';
import 'package:trafficy_client/utils/customIcon/custom_icons.dart';
import 'package:trafficy_client/utils/images/images.dart';

class CustomNetworkImage extends StatelessWidget {
  final double height;
  final double width;
  final String imageSource;
  final bool assets;
  final Color? background;

  CustomNetworkImage({
    required this.height,
    required this.width,
    required this.imageSource,
    this.assets = false,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    bool asset = assets;
    var image = imageSource;

    if (image.contains('assets/')) {
      if (image == '') {
        image = ImageAsset.PLACEHOLDER;
      }
      asset = true;
    }

    if (asset) {
      return ProgressiveImage.custom(
        height: height,
        width: width,
        placeholderBuilder: (context) {
          return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: background ?? Theme.of(context).backgroundColor),
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    MandobIcons.logo,
                    size: 30,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
                  child: Container(
                    width: 28,
                    child: LinearProgressIndicator(
                        minHeight: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).textTheme.headline1!.color!)),
                  ),
                ),
              ],
            ),
          );
        },
        fadeDuration: Duration(milliseconds: 750),
        thumbnail: AssetImage(image),
        image: AssetImage(image),
        fit: BoxFit.cover,
      );
    } else {
      if (!image.contains('http')) {
      
      }
      return GestureDetector(
        onTap: () {},
        child: ProgressiveImage.custom(
          height: height,
          width: width,
          placeholderBuilder: (context) {
            return Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: background ?? Theme.of(context).backgroundColor),
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      MandobIcons.logo,
                      size: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 10.0),
                    child: Container(
                      width: 28,
                      child: LinearProgressIndicator(
                          minHeight: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).textTheme.headline1!.color!)),
                    ),
                  ),
                ],
              ),
            );
          },
          fadeDuration: Duration(milliseconds: 750),
          thumbnail: NetworkImage(image),
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
      );
    }
  }
}
