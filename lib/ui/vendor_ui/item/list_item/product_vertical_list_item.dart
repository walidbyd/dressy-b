import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../config/route/route_paths.dart';
import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/viewobject/holder/intent_holder/product_detail_intent_holder.dart';
import '../../common/bluemark_icon.dart';
import '../../common/ps_ui_widget.dart';
import '../../common/shimmer_item.dart';

class ProductVeticalListItem extends StatelessWidget {
  const ProductVeticalListItem(
      {Key? key,
        required this.product,
        this.onTap,
        this.coreTagKey,
        required this.animationController,
        required this.animation,
        this.isLoading = false})
      : super(key: key);

  final Product product;
  final Function? onTap;
  final AnimationController animationController;
  final Animation<double> animation;
  final String? coreTagKey;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    animationController.forward();
    final PsValueHolder valueHolder =
    Provider.of<PsValueHolder>(context, listen: false);

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
            opacity: animation,
            child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 100 * (1.0 - animation.value), 0.0),
                child: child));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: PsDimens.space4, vertical: PsDimens.space8),
        child: isLoading
            ? const ShimmerItem()
            : GestureDetector(
          onTap: () {
            onDetailClick(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Utils.isLightMode(context)
                  ? PsColors.text50
                  : PsColors.achromatic700,
              borderRadius: const BorderRadius.all(
                  Radius.circular(PsDimens.space8)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // ========== LARGE CLEAN IMAGE ==========
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.circular(PsDimens.space6),
                          child: PsNetworkImage(
                            photoKey:
                            '$coreTagKey${product.id}${PsConst.HERO_TAG__IMAGE}',
                            defaultPhoto: product.defaultPhoto,
                            boxfit: BoxFit.cover,
                            imageAspectRation: PsConst.Aspect_Ratio_1x,
                            onTap: () {
                              onDetailClick(context);
                            },
                          ),
                        ),
                      ),
                      // Favorite only
                      if (!Utils.isOwnerItem(valueHolder, product))
                        Positioned(
                            top: PsDimens.space6,
                            right: PsDimens.space6,
                            child: GestureDetector(
                                onTap: () {
                                  onDetailClick(context);
                                },
                                child: Container(
                                    padding: const EdgeInsets.only(
                                        top: PsDimens.space4,
                                        left: PsDimens.space4,
                                        right: PsDimens.space4,
                                        bottom: PsDimens.space4),
                                    decoration: BoxDecoration(
                                        color: PsColors.achromatic50,
                                        border: Border.all(
                                            color: PsColors.achromatic50),
                                        shape: BoxShape.circle),
                                    child: product.isFavourited ==
                                        PsConst.ZERO ||
                                        Utils.isLoginUserEmpty(
                                            valueHolder)
                                        ? Icon(Icons.favorite_border,
                                        color: PsColors.text500,
                                        size: 20)
                                        : Icon(Icons.favorite,
                                        color: Theme.of(context)
                                            .primaryColor,
                                        size: 20)))),
                    ],
                  ),
                ),
                // ========== PRICE + SELLER + CONDITION ==========
                Container(
                  padding: const EdgeInsets.only(
                      left: PsDimens.space8,
                      right: PsDimens.space8,
                      top: PsDimens.space8,
                      bottom: PsDimens.space8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Single price (no strikethrough / discount)
                      Text(
                        _getDisplayPrice(valueHolder),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: PsDimens.space8),
                      // Seller name + photo + condition (New / Used / Old)
                      if (valueHolder.isShowOwnerInfo!)
                        Row(
                          children: <Widget>[
                            Stack(children: <Widget>[
                              SizedBox(
                                width: PsDimens.space40,
                                height: PsDimens.space40,
                                child: PsNetworkCircleImageForUser(
                                  photoKey: '',
                                  imagePath:
                                  product.user?.userCoverPhoto,
                                  boxfit: BoxFit.cover,
                                  onTap: () {
                                    onDetailClick(context);
                                  },
                                ),
                              ),
                              if (product.user != null &&
                                  product.user!.isVefifiedBlueMarkUser)
                                const Positioned(
                                  right: -1,
                                  bottom: -1,
                                  child: BluemarkIcon(),
                                ),
                            ]),
                            const SizedBox(width: PsDimens.space8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    product.user?.name == null ||
                                        product.user?.name == ''
                                        ? 'default__user_name'.tr
                                        : '${product.user?.name}',
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge,
                                  ),
                                  // Condition under seller (was date)
                                  if (_getItemCondition().isNotEmpty)
                                    Text(
                                      _getItemCondition(),
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                        color: Utils.isLightMode(
                                            context)
                                            ? PsColors.text500
                                            : PsColors.text400,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
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
  }

  /// Final price only — no original / strikethrough discount price
  String _getDisplayPrice(PsValueHolder valueHolder) {
    final bool isLoginUserEmpty = Utils.isLoginUserEmpty(valueHolder);
    if (valueHolder.hidePriceSetting == PsConst.ONE && isLoginUserEmpty) {
      return '${product.itemCurrency?.currencySymbol ?? ''}\t*****';
    }
    final String? price = (product.isDiscountedItem == true &&
        product.currentPrice != null &&
        product.currentPrice != '')
        ? product.currentPrice
        : product.originalPrice;
    if (price == null || price == '' || price == '0') {
      return 'item_price_free'.tr;
    }
    return '${product.itemCurrency?.currencySymbol ?? ''} ${Utils.getPriceFormat(price, valueHolder.priceFormat!)}';
  }

  /// Item condition (New / Used / Old) from productRelation
  String _getItemCondition() {
    const String conditionCoreKeyId = 'ps-itm00004';
    return product.selectedValuesOfProductRelation(conditionCoreKeyId).trim();
  }

  Future<void> onDetailClick(BuildContext context) async {
    if (!isLoading) {
      print(product.defaultPhoto!.imgPath);
      final ProductDetailIntentHolder holder = ProductDetailIntentHolder(
          productId: product.id,
          heroTagImage: coreTagKey! + product.id! + PsConst.HERO_TAG__IMAGE,
          heroTagTitle: coreTagKey! + product.id! + PsConst.HERO_TAG__TITLE);
      Navigator.pushNamed(context, RoutePaths.productDetail, arguments: holder);
    }

    if (onTap != null) {
      onTap!();
    }
  }
}