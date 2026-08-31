import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/intent_holder/product_detail_intent_holder.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../config/route/route_paths.dart';
import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/provider/add_to_cart/add_to_cart_provider.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../custom_ui/item/list_item/product_price_widget.dart';
import '../../../custom_ui/item/list_item/product_shop_owner_info_widget.dart';
import '../../common/bluemark_icon.dart';
import '../../common/ps_ui_widget.dart';
import '../../common/shimmer_item.dart';

class ProductHorizontalListItem extends StatelessWidget {
  const ProductHorizontalListItem({
    Key? key,
    required this.product,
    required this.tagKey,
    this.isLoading = false,
  }) : super(key: key);

  final Product product;
  final String tagKey;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder =
    Provider.of<PsValueHolder>(context, listen: false);
    final AddToCartProvider addToCartProvider =
    Provider.of<AddToCartProvider>(context);

    return Container(
      margin: const EdgeInsets.only(
        right: PsDimens.space4,
      ),
      width: PsDimens.space180,
      child: isLoading
          ? const ShimmerItem()
          : InkWell(
        onTap: () {
          onDetailClick(context, addToCartProvider, valueHolder);
        },
        child: Card(
          elevation: 0.0,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Utils.isLightMode(context)
                  ? PsColors.text50
                  : PsColors.achromatic700,
              borderRadius: const BorderRadius.all(
                  Radius.circular(PsDimens.space8)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // ========== LARGE CLEAN IMAGE ONLY ==========
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.circular(PsDimens.space4),
                          child: PsNetworkImage(
                            photoKey:
                            '$tagKey${product.id}${PsConst.HERO_TAG__IMAGE}',
                            defaultPhoto: product.defaultPhoto,
                            boxfit: BoxFit.cover,
                            imageAspectRation: PsConst.Aspect_Ratio_1x,
                            onTap: () {
                              onDetailClick(context, addToCartProvider,
                                  valueHolder);
                            },
                          ),
                        ),
                      ),
                      // Favorite heart only (optional – remove this block if you want zero icons on image)
                      if (!Utils.isOwnerItem(valueHolder, product))
                        Positioned(
                            top: PsDimens.space6,
                            right: PsDimens.space6,
                            child: GestureDetector(
                                onTap: () {
                                  onDetailClick(context,
                                      addToCartProvider, valueHolder);
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
                // ========== PRICE + VENDOR ==========
                Container(
                  padding: const EdgeInsets.only(
                      left: PsDimens.space8,
                      right: PsDimens.space8,
                      top: PsDimens.space8,
                      bottom: PsDimens.space8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // Price
                      CustomProductPriceWidget(
                        product: product,
                        tagKey: tagKey,
                      ),
                      // Vendor name + image
                      if (valueHolder.isShowOwnerInfo! &&
                          product.vendorId != '' &&
                          valueHolder.vendorFeatureSetting == PsConst.ONE)
                        CustomProductShopOwnerInfoWidget(
                          tagKey: tagKey,
                          product: product,
                        )
                      else if (valueHolder.isShowOwnerInfo!)
                        Padding(
                          padding: const EdgeInsets.only(
                            left: PsDimens.space4,
                            top: PsDimens.space8,
                          ),
                          child: Row(
                            children: <Widget>[
                              Stack(children: <Widget>[
                                Container(
                                  child: SizedBox(
                                    width: PsDimens.space40,
                                    height: PsDimens.space40,
                                    child: PsNetworkCircleImageForUser(
                                      photoKey: '',
                                      imagePath:
                                      product.user?.userCoverPhoto,
                                      boxfit: BoxFit.cover,
                                      onTap: () {
                                        onDetailClick(
                                            context,
                                            addToCartProvider,
                                            valueHolder);
                                      },
                                    ),
                                  ),
                                ),
                                if (product.user!.isVefifiedBlueMarkUser)
                                  const Positioned(
                                    right: -1,
                                    bottom: -1,
                                    child: BluemarkIcon(),
                                  ),
                              ]),
                              const SizedBox(width: PsDimens.space8),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: PsDimens.space4,
                                      top: PsDimens.space4),
                                  child: Text(
                                      product.user?.name == ''
                                          ? 'default__user_name'.tr
                                          : '${product.user?.name}',
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                ),
                              )
                            ],
                          ),
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

  Future<void> onDetailClick(BuildContext context,
      AddToCartProvider addToCartProvider, PsValueHolder valueHolder) async {
    if (!isLoading) {
      print(product.defaultPhoto!.imgPath);
      final ProductDetailIntentHolder holder = ProductDetailIntentHolder(
          productId: product.id,
          heroTagImage: tagKey + product.id! + PsConst.HERO_TAG__IMAGE,
          heroTagTitle: tagKey + product.id! + PsConst.HERO_TAG__TITLE);
      final dynamic result = await Navigator.pushNamed(
          context, RoutePaths.productDetail,
          arguments: holder);

      if (result) {
        addToCartProvider.loadData(
            requestPathHolder: RequestPathHolder(
                isCheckoutPage: PsConst.ZERO,
                loginUserId: valueHolder.loginUserId,
                languageCode: valueHolder.languageCode));
      }
    }
  }
}