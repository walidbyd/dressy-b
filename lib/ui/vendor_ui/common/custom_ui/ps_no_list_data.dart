import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:psxmpc/core/vendor/constant/ps_dimens.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';

class NoListData extends StatelessWidget {
  const NoListData({required this.assetName, required this.emptyText});
  final String assetName;
  final String emptyText;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 245, height: 200, child: SvgPicture.asset(assetName)),
          const SizedBox(
            height: PsDimens.space20,
          ),
          Text(
            emptyText.tr,
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
          )
        ],
      ),
    );
  }
}
