import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/product/item_entry_provider.dart';
import 'package:psxmpc/core/vendor/viewobject/custom_field.dart';

import '../../../../../../../core/vendor/provider/product/search_product_provider.dart';
import '../../../../../../../core/vendor/viewobject/entry_product_relation.dart';
import '../../../../../../../core/vendor/viewobject/selected_object.dart';
import '../../../../../common/custom_ui/ui_type/checkbox.dart';

class ItemFilterCheckboxWidget extends StatelessWidget {
  const ItemFilterCheckboxWidget({super.key, required this.field});

  final CustomField field;

  @override
  Widget build(BuildContext context) {
    final SearchProductProvider searchProductProvider =
        Provider.of<SearchProductProvider>(context);
    final ItemEntryFieldProvider itemEntryFieldProvider =
        Provider.of<ItemEntryFieldProvider>(context);

    // This widget will only support for the Checkbox style ui types
    // uit00004 : Checkbox
    if (itemEntryFieldProvider.isCustomFieldVisible(field, 'uit00004')) {
      final TextEditingController valueTextController = TextEditingController();
      final TextEditingController idTextController = TextEditingController();

      EntryProductRelation? productRelation;

      // If there are preselected id and value, need to get from search holder
      // and pass it to the checkbox widget to auto select.
      if (searchProductProvider.productParameterHolder.productRelation !=
              null &&
          searchProductProvider
              .productParameterHolder.productRelation!.isNotEmpty) {
        productRelation = searchProductProvider
            .productParameterHolder.productRelation
            ?.firstWhere(
          (EntryProductRelation element) =>
              element.coreKeyId == field.coreKeyId,
          orElse: () => EntryProductRelation(coreKeyId: '', value: ''),
        );
      }

      // if there are selected value, set it to the controller to pass the data
      if (productRelation != null && productRelation.value != '') {
        idTextController.text = productRelation.value!;
        valueTextController.text = productRelation.valueString!;
      }

      // Add the controller to controller map to store and get the data later.
      if (!itemEntryFieldProvider.textControllerMap.containsKey(field)) {
        itemEntryFieldProvider.textControllerMap.putIfAbsent(
          field,
          () => SelectedObject(
            valueTextController: valueTextController,
            idTextController: idTextController,
          ),
        );
      }

      // Create the Checkbox UI using Checkbox widget.
      return CheckBoxWidget(
        customField: field,
      );
    }else {

      // Return Empty
      return const SizedBox();
    }
  }
}
