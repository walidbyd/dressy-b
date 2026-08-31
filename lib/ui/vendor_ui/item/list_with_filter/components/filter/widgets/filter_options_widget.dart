import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/product/item_entry_provider.dart';
import 'package:psxmpc/core/vendor/viewobject/custom_field.dart';

import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/product/search_product_provider.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../custom_ui/item/list_with_filter/components/filter/widgets/location.dart';
import '../../../../../../custom_ui/item/list_with_filter/components/filter/widgets/location_township.dart';
import '../../../../../../custom_ui/item/list_with_filter/components/filter/widgets/price_arrange.dart';
import '../../../../../../custom_ui/item/list_with_filter/components/filter/widgets/sorting.dart';
import '../../../../../../custom_ui/item/list_with_filter/components/filter/widgets/status.dart';
import 'item_filter_checkbox_widget.dart';
import 'item_filter_dropdown_widget.dart';
import 'item_filter_radio_widget.dart';

class FilterOptionsWidget extends StatelessWidget {
  const FilterOptionsWidget({
    Key? key,
    required TextEditingController minPriceTextController,
    required TextEditingController maxPriceTextController,
  })  : _minPriceTextController = minPriceTextController,
        _maxPriceTextController = maxPriceTextController,
        super(key: key);

  final TextEditingController _minPriceTextController;
  final TextEditingController _maxPriceTextController;

  @override
  Widget build(BuildContext context) {
    final SearchProductProvider provider =
        Provider.of<SearchProductProvider>(context);
    
    final PsValueHolder _valueHolder = Provider.of<PsValueHolder>(context);

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CustomSortingRadioView(
            searchProductProvider: provider,
          ),
          CustomStatusRadioView(
            searchProductProvider: provider,
          ),
          CustomPriceArrangementWidget(
            minPriceTextController: _minPriceTextController,
            maxPriceTextController: _maxPriceTextController,
          ),
          const CustomLocationDropDownButton(),
          if (_valueHolder.isSubLocation == PsConst.ONE)
            const CustomLocationTownshipDownDownButton(),
          Consumer<ItemEntryFieldProvider>(
            builder: (BuildContext context, ItemEntryFieldProvider itemEntryProvider,
                Widget? child) {
              if (itemEntryProvider.dataList.data != null &&
                  itemEntryProvider.itemEntryField.data?.customField != null) {
                final List<Widget> fields = <Widget>[];

                for (CustomField field
                    in itemEntryProvider.itemEntryField.data!.customField!) {

                  // <!-- dropdown -->
                  fields.add(ItemFilterDropdownWidget(field: field,));
                  
                  // <!-- Radio -->
                  fields.add(ItemFilterRadioWidget(field: field,));

                  // <!-- Checkbox -->
                  fields.add(ItemFilterCheckboxWidget(field: field,));
                  
                  // <!-- Datetime -->
                  // v-if="(customFieldHeader.uiType.coreKeysId === 'uit00005') && customFieldHeader.isVisible == '1' && customFieldHeader.isDelete == '0'">
                  // if (itemEntryProvider.isCustomFieldVisible(field, 'uit00005')) {
                    
                  // <!-- Date Only -->
                  // v-if="(customFieldHeader.uiType.coreKeysId === 'uit00011') && customFieldHeader.isVisible == '1' && customFieldHeader.isDelete == '0'">
                  // if (itemEntryProvider.isCustomFieldVisible(field, 'uit00011')) {
                    
                  // <!-- Time Only -->
                  // v-if="(customFieldHeader.uiType.coreKeysId === 'uit00010') && customFieldHeader.isVisible == '1' && customFieldHeader.isDelete == '0'">
                  // if (itemEntryProvider.isCustomFieldVisible(field, 'uit00010')) {                    

                  // <!-- Number -->
                  // v-if="(customFieldHeader.uiType.coreKeysId === 'uit00007') && customFieldHeader.isVisible == '1' && customFieldHeader.isDelete == '0'">
                  // if (itemEntryProvider.isCustomFieldVisible(field, 'uit00007')) {
                    
                }

                return Column(
                  children: fields,
                  mainAxisSize: MainAxisSize.max,
                );
              } else {
                return const Column(mainAxisSize: MainAxisSize.min);
              }
            },
          ),
          const SizedBox(height: PsDimens.space120,)
        
        ],
      ),
    );
  }
}
