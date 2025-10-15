import 'package:r_connector/core/extension/build_context_extension.dart';
import 'package:r_connector/core/extension/widget_extensions.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utils/decore_utils.dart';

enum PopupMode { dialog, modalBottomSheet, menu, bottomSheet }

class DropdownWidget<T> extends StatelessWidget {
  final PopupMode popupMode;
  final String? hintText, lable, index;
  final DropdownSearchOnFind<T>? items;
  final T? selectedItem;
  final List<T>? selectedItems; // For multi-select
  final Function(T?)? onChanged;
  final Function(List<T>)? onChangedMulti; // For multi-select
  final String? Function(T?)? validator;
  final String? Function(List<T>?)? multiValidator;
  final bool showSearchBox;
  final bool enable;
  final bool isMultiSelect;

  const DropdownWidget({
    super.key,
    this.popupMode = PopupMode.menu,
    this.hintText,
    this.lable,
    this.index,
    required this.items,
    this.onChanged,
    this.onChangedMulti,
    this.validator,
    this.multiValidator,
    this.selectedItem,
    this.selectedItems,
    this.showSearchBox = true,
    this.enable = true,
    this.isMultiSelect = false,
  });

  @override
  Widget build(BuildContext context) {
    final labelTextWidget = (index ?? '').isNotEmpty
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$index.  ", style: context.textTheme.titleMedium),
              Expanded(
                child: Text(lable ?? '', style: context.textTheme.titleMedium),
              ),
            ],
          ).padBottom(bottom: 10.h)
        : (lable ?? '').isNotEmpty
        ? Text(
            lable ?? '',
            style: context.textTheme.titleMedium,
          ).padBottom(bottom: 10.h)
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelTextWidget != null) labelTextWidget,
        if (isMultiSelect)
          DropdownSearch<T>.multiSelection(
            enabled: enable,
            items: items,
            selectedItems: selectedItems ?? [],
            itemAsString: (item) => item.toString(),
            compareFn: (i1, i2) => i1 == i2,
            onChanged: onChangedMulti,
            validator: multiValidator,
            popupProps: PopupPropsMultiSelection.menu(
              showSearchBox: showSearchBox,
              showSelectedItems: true,
              searchFieldProps: TextFieldProps(
                decoration: inputDecoration(
                  context: context,
                  hintText: 'Search',
                ),
              ),
              fit: FlexFit.loose,
              constraints: BoxConstraints(maxHeight: 0.5.sh),
            ),
            decoratorProps: DropDownDecoratorProps(
              decoration: inputDecoration(
                context: context,
                labelText: hintText ?? 'Select items',
                hintText: hintText ?? 'Select items',
              ),
            ),
          )
        else
          DropdownSearch<T>(
            enabled: enable,
            items: items,
            selectedItem: selectedItem,
            itemAsString: (item) => item.toString(),
            compareFn: (i1, i2) => i1 == i2,
            onChanged: onChanged,
            validator: validator,
            popupProps: PopupProps.menu(
              showSearchBox: showSearchBox,
              showSelectedItems: true,
              searchFieldProps: TextFieldProps(
                decoration: inputDecoration(
                  context: context,
                  hintText: 'Search',
                ),
              ),
              fit: FlexFit.loose,
              constraints: BoxConstraints(maxHeight: 0.5.sh),
            ),
            decoratorProps: DropDownDecoratorProps(
              decoration: inputDecoration(
                context: context,
                labelText: hintText ?? 'Select item',
                hintText: hintText ?? 'Select item',
              ),
            ),
          ),
      ],
    );
  }
}
