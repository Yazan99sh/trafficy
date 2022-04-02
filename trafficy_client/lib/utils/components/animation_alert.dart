import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:trafficy_client/consts/urls.dart';
import 'package:trafficy_client/generated/l10n.dart';
import 'package:trafficy_client/utils/components/progresive_image.dart';
import 'package:trafficy_client/utils/effect/scaling.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class CustomAnimationAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: double.maxFinite,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 50.0, end: width),
            duration: Duration(milliseconds: 650),
            builder: (context, double val, _) {
              return Container(
                width: val,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: Theme.of(context).primaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Icon(
                        Icons.info_rounded,
                        color: Colors.white,
                      ),
                      Container(
                        width: 8,
                      ),
                      val == width
                          ? Expanded(
                              child: Text(
                                S.of(context).chooseAddressNote,
                                style:
                                    TextStyle(color: Colors.white, height: 1.1),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class CustomInvoiceAlert extends StatelessWidget {
  final String image;
  final String cost;

  CustomInvoiceAlert({required this.image, required this.cost});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ScalingWidget(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).backgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Flex(
              direction: Axis.vertical,
              children: [
                ScalingWidget(
                  fade: true,
                  child: ListTile(
                    leading: Icon(Icons.info),
                    title: Text(
                      S.current.totalBillCostHint,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, right: 32, left: 32),
                  child: DottedLine(
                    dashColor: Theme.of(context).disabledColor.withOpacity(0.1),
                    lineThickness: 2.5,
                    dashLength: 6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${S.current.invoiceImage}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Hero(
                          tag: 'Invoice',
                          child: CustomNetworkImage(
                            imageSource: image,
                            width: double.maxFinite,
                            height: 150,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 90.0),
                          child: Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: InkWell(
                              customBorder: CircleBorder(),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return Scaffold(
                                        appBar: AppBar(
                                          backgroundColor:
                                              Colors.transparent.withOpacity(0),
                                          elevation: 0,
                                          leading: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              customBorder: CircleBorder(),
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.black38,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons
                                                        .cancel_presentation_rounded,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        backgroundColor: Colors.black38,
                                        body: PinchZoom(
                                          child: Hero(
                                              tag: 'Invoice',
                                              child: Image.network(
                                                  image)),
                                          resetDuration:
                                              const Duration(milliseconds: 100),
                                          maxScale: 2.5,
                                          onZoomStart: () {},
                                          onZoomEnd: () {},
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black38,
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.fullscreen,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${S.current.invoiceCost}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, right: 32, left: 32),
                  child: DottedLine(
                    dashColor: Theme.of(context).disabledColor.withOpacity(0.1),
                    lineThickness: 2.5,
                    dashLength: 6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$cost ${S.current.sar}',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
