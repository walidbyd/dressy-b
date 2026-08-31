import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/product/item_entry_provider.dart';
import 'package:psxmpc/core/vendor/viewobject/custom_field.dart';

import '../../../../../../../core/vendor/provider/product/search_product_provider.dart';
import '../../../../../../../core/vendor/viewobject/entry_product_relation.dart';
import '../../../../../../../core/vendor/viewobject/selected_object.dart';
import '../../../../../common/custom_ui/ui_type/dropdown.dart';

class ItemFilterDropdownWidget extends StatelessWidget {
  const ItemFilterDropdownWidget({super.key, required this.field});

  final CustomField field;

  @override
  Widget build(BuildContext context) {
    final SearchProductProvider searchProductProvider =
        Provider.of<SearchProductProvider>(context);
    final ItemEntryFieldProvider itemEntryFieldProvider =
        Provider.of<ItemEntryFieldProvider>(context);

    // This widget will only support for the dropdown style ui types
    // uit00001 : Dropdown
    // uit00008 : Multi-Select
    // @todo : ?? Others that use dropdown for filter need to add here 
    if (itemEntryFieldProvider.isCustomFieldVisible(field, 'uit00001') ||
        itemEntryFieldProvider.isCustomFieldVisible(field, 'uit00008')) {
      final TextEditingController valueTextController = TextEditingController();
      final TextEditingController idTextController = TextEditingController();

      EntryProductRelation? productRelation;

      // If there are preselected id and value, need to get from search holder
      // and pass it to the dropdown widget to auto select.
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

      // Create the Dropdown UI using Dropdown widget.
      return DropDownWidget(
        customField: field,
      );
    }else {

      // Return Empty
      return const SizedBox();
    }
  }
}


// @todo : tmp to delete later
// if (itemEntryProvider.isCustomFieldVisible(field, 'uit00001') ||
                  //     itemEntryProvider.isCustomFieldVisible(field, 'uit00008')) {

                  //   final TextEditingController valueTextController =
                  //       TextEditingController();
                  //   final TextEditingController idTextController =
                  //       TextEditingController();

                  //   EntryProductRelation? productRelation;
                    
                  //   if (provider.productParameterHolder.productRelation != null &&
                  //       provider.productParameterHolder.productRelation!.isNotEmpty) {
                  //       productRelation = provider.productParameterHolder.productRelation?.firstWhere(
                  //         (EntryProductRelation element) => element.coreKeyId == field.coreKeyId,
                  //         orElse: () => EntryProductRelation(coreKeyId: '', value: ''),
                  //       );
                  //   }

                  //   if(productRelation != null && productRelation.value != '') {
                  //     idTextController.text = productRelation.value!;
                  //     valueTextController.text = productRelation.valueString!;                      
                  //   }
            
                  //   if (!itemEntryProvider.textControllerMap.containsKey(field)) {
                  //     print('core and custom field ${field.coreKeyId}');
                  //     itemEntryProvider.textControllerMap.putIfAbsent(
                  //       field,
                  //       () => SelectedObject(
                  //         valueTextController: valueTextController,
                  //         idTextController: idTextController,
                  //       ),
                  //     );
                  //   }
                  //   fields.add(DropDownWidget(
                  //     customField: field,
                  //   ));
                  // }
