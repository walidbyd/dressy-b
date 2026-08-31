import 'package:flutter/material.dart';
import 'package:flutter_decorated_container/flutter_decorated_container.dart';
import '../../../../../../../config/ps_colors.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/utils/utils.dart';

class EmptyImageItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  DecoratedContainer(
      cornerRadius: PsDimens.space4,
      backgroundColor:Utils.isLightMode(context)?
      PsColors.achromatic50 :PsColors.achromatic800 ,
      strokeColor: Utils.isLightMode(context)?
      PsColors.achromatic500 :PsColors.achromatic200
      ,
        child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Icon(
          Icons.add_a_photo_outlined,
        ),
      ),
    );
    // return Image.asset(
    //   'assets/images/default_image.png',
    //   width: MediaQuery.of(context).size.width,
    //   height: MediaQuery.of(context).size.height,
    //   fit: BoxFit.cover,
    // );
  }
}
