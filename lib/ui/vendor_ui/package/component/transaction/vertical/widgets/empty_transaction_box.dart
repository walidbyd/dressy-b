import 'package:flutter/material.dart';
import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../core/vendor/utils/utils.dart';

class EmptyTransactionBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 120,
        child: Center(
          child: Text(
            '${'empty_active_package'.tr} \n ${'buy_and_create_post'.tr}',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Utils.isLightMode(context)
                    ? PsColors.text400
                    : PsColors.text300),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
