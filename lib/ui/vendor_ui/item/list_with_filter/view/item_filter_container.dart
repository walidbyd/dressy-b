import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/db/common/ps_data_source_manager.dart';
import 'package:psxmpc/core/vendor/provider/product/item_entry_provider.dart';
import 'package:psxmpc/core/vendor/repository/item_entry_field_repository.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';
import 'package:psxmpc/core/vendor/viewobject/custom_field.dart';
import 'package:psxmpc/core/vendor/viewobject/entry_product_relation.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/request_path_holder.dart';
import 'package:psxmpc/core/vendor/viewobject/selected_object.dart';
import 'package:psxmpc/ui/vendor_ui/common/base/ps_widget_with_appbar_with_two_provider.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../core/vendor/provider/product/search_product_provider.dart';
import '../../../../../core/vendor/repository/product_repository.dart';
import '../../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';
import '../../../../custom_ui/item/list_with_filter/components/filter/filter_view.dart';


class ItemFilterContainer extends StatefulWidget {
  const ItemFilterContainer({
    required this.productParameterHolder,
  });

  final ProductParameterHolder productParameterHolder;

  @override
  _ItemFilterContainerState createState() => _ItemFilterContainerState();
}

class _ItemFilterContainerState extends State<ItemFilterContainer> {
  late ProductRepository repo;
  late SearchProductProvider? _searchProductProvider;
  late ItemEntryFieldRepository itemEntryFieldRepository;
  late ItemEntryFieldProvider? _itemEntryFieldProvider;
  final TextEditingController _itemNameTextController = TextEditingController();
  final TextEditingController _maxPriceTextController = TextEditingController();
  final TextEditingController _minPriceTextController = TextEditingController();
  PsValueHolder? valueHolder;

  String? orderByFirstValue = '';
  bool isAllLocationSelected = false;

  void _handleReset() {
    _itemNameTextController.text = '';
    _maxPriceTextController.text = '';
    _minPriceTextController.text = '';
    _searchProductProvider?.productParameterHolder.orderBy = orderByFirstValue;
    _searchProductProvider?.clearData();
    
    Navigator.pop(context, _searchProductProvider?.productParameterHolder);
  }

  void _handleApply() {
    if (_itemNameTextController.text.isNotEmpty) {
      _searchProductProvider?.productParameterHolder.searchTerm =
          _itemNameTextController.text;
    } else {
      _searchProductProvider?.productParameterHolder.searchTerm = '';
    }

    if (_maxPriceTextController.text.isNotEmpty) {
      _searchProductProvider?.productParameterHolder.maxPrice =
          _maxPriceTextController.text;
    } else {
      _searchProductProvider?.productParameterHolder.maxPrice = '';
    }

    if (_minPriceTextController.text.isNotEmpty) {
      _searchProductProvider?.productParameterHolder.minPrice =
          _minPriceTextController.text;
    } else {
      _searchProductProvider?.productParameterHolder.minPrice = '';
    }

    _searchProductProvider?.productParameterHolder.itemLocationId =
        _searchProductProvider?.locationId;
    _searchProductProvider?.productParameterHolder.itemLocationName =
        _searchProductProvider?.selectedLocationName;
    _searchProductProvider?.productParameterHolder.itemLocationTownshipId =
        _searchProductProvider?.locationTownshipId;
    _searchProductProvider?.productParameterHolder.itemLocationTownshipName =
        _searchProductProvider?.selectedLocationTownshipName;
    if (_searchProductProvider?.itemIsSoldOut != null) {
      _searchProductProvider?.productParameterHolder.isSoldOut =
          _searchProductProvider?.itemIsSoldOut;
    }

    _itemEntryFieldProvider?.textControllerMap.forEach(
      (CustomField customField, SelectedObject value) {
        // Remove the old value if it exists
        _searchProductProvider?.productParameterHolder.productRelation
            ?.removeWhere((EntryProductRelation element) => element.coreKeyId == customField.coreKeyId);

      if (value.idTextController.text.isNotEmpty) {

        // Add the new value
          _searchProductProvider?.productParameterHolder.productRelation
              ?.add(EntryProductRelation(
            coreKeyId: customField.coreKeyId,
            value: value.idTextController.text,
            valueString: value.valueTextController.text,));
      }
       
      
    });
    

    Navigator.pop(context, _searchProductProvider?.productParameterHolder);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalization langProvider = Provider.of<AppLocalization>(context);

    valueHolder = Provider.of<PsValueHolder>(context);
    repo = Provider.of<ProductRepository>(context);
    itemEntryFieldRepository = Provider.of<ItemEntryFieldRepository>(context);

    return PsWidgetWithAppBarWithTwoProvider<SearchProductProvider,
            ItemEntryFieldProvider>(
        appBarTitle: 'search__filter'.tr,
        initProvider1: () {
          return SearchProductProvider(repo: repo);
        },
        onProviderReady1: (SearchProductProvider? provider) {
          _searchProductProvider = provider;
          _searchProductProvider?.productParameterHolder =
              widget.productParameterHolder;
          _searchProductProvider?.locationId =
              widget.productParameterHolder.itemLocationId;
          _searchProductProvider?.locationTownshipId =
              widget.productParameterHolder.itemLocationTownshipId;
          _searchProductProvider?.selectedLocationName =
              widget.productParameterHolder.itemLocationName;
          _searchProductProvider?.selectedLocationTownshipName =
              widget.productParameterHolder.itemLocationTownshipName;

          orderByFirstValue =
              _searchProductProvider?.productParameterHolder.orderBy;

          _itemNameTextController.text =
              widget.productParameterHolder.searchTerm!;
              return _searchProductProvider;
        },
        initProvider2: () {
          _itemEntryFieldProvider = ItemEntryFieldProvider(repo: itemEntryFieldRepository);
          _itemEntryFieldProvider?.textControllerMap.clear();
          return _itemEntryFieldProvider;
        },
        onProviderReady2: (ItemEntryFieldProvider? itemEntryFieldProvider) {
          itemEntryFieldProvider!.loadData(
              dataConfig: DataConfiguration(
                  dataSourceType: DataSourceType.SERVER_DIRECT),
              requestPathHolder: RequestPathHolder(
                  loginUserId: valueHolder?.loginUserId,
                  languageCode: langProvider.currentLocale.languageCode,
                  categoryId: widget.productParameterHolder.catId)); //widget.categoryId));
          return itemEntryFieldProvider;
        },
        child: Consumer<ItemEntryFieldProvider>(builder: (BuildContext context,
            ItemEntryFieldProvider provider, Widget? child) {
          return CustomFilterView(
            handleApply: _handleApply,
            handleReset: _handleReset,
            maxPriceTextController: _maxPriceTextController,
            minPriceTextController: _minPriceTextController,
          );
        }));
    // });
  }
}
