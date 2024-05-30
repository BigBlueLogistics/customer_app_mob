import 'package:flutter/material.dart';
import 'package:customer_app_mob/core/presentation/widgets/atoms/md_text_input/md_text_form.dart';
import 'package:customer_app_mob/core/shared/enums/text_border_type.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_filtering/clear_button.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_filtering/filter_button.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_filtering/button_segmented.dart';
import 'notifier.dart';

class ModalFilterContent extends StatelessWidget {
  const ModalFilterContent({
    super.key,
    required this.customerList,
    required this.warehouseList,
    required this.movementTypeList,
    required this.filteringData,
    required this.onSelectCustomer,
    required this.onSelectWarehouse,
    required this.onSelectMovementType,
    required this.onFilterData,
    required this.onClearFilter,
    required this.onSelectMaterial,
    required this.onSelectCoverageDate,
  });

  final List<String> customerList;
  final List<String> warehouseList;
  final List<String> movementTypeList;
  final ValueChanged<String> onSelectCustomer;
  final ValueChanged<String> onSelectWarehouse;
  final ValueChanged<String> onSelectMovementType;
  final VoidCallback onFilterData;
  final VoidCallback onClearFilter;
  final ValueChanged<String> onSelectMaterial;
  final ValueChanged<DateTimeRange> onSelectCoverageDate;
  final ValueNotifier<FilterValueNotifier> filteringData;

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;
    const buttonBorderShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    );

    final segmentButtonStyles = SegmentedButton.styleFrom(
      side: BorderSide(color: Colors.grey.shade300),
      shape: buttonBorderShape,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        child: ValueListenableBuilder<FilterValueNotifier>(
          valueListenable: filteringData,
          builder: (context, value, child) {
            var column = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Customer:'),
                customerList.isNotEmpty
                    ? ButtonSegmented(
                        onSelectedChanged: (Set<String> newSelection) {
                          onSelectCustomer(newSelection.first);
                        },
                        dataList: customerList,
                        selectedValue: value.customerCode != null
                            ? value.customerCode.toString()
                            : '',
                        segmentButtonStyles: segmentButtonStyles)
                    : const Text('---'),
                const SizedBox(height: 10),
                const Text('Warehouse:'),
                warehouseList.isNotEmpty
                    ? ButtonSegmented(
                        onSelectedChanged: (newSelection) {
                          onSelectWarehouse(newSelection.first);
                        },
                        dataList: warehouseList,
                        selectedValue: value.warehouse != null
                            ? value.warehouse.toString()
                            : '',
                        segmentButtonStyles: segmentButtonStyles)
                    : const Text('---'),
                const SizedBox(height: 10),
                const Text('Movement Type:'),
                movementTypeList.isNotEmpty
                    ? ButtonSegmented(
                        onSelectedChanged: (newSelection) {
                          onSelectMovementType(newSelection.first);
                        },
                        dataList: movementTypeList
                            .map((e) => e.toUpperCase())
                            .toList(),
                        selectedValue: value.movementType != null
                            ? value.movementType.toString()
                            : '',
                        segmentButtonStyles: segmentButtonStyles)
                    : const Text('---'),
                const SizedBox(height: 10),
                const Text('Material:'),
                Autocomplete<Map<String, dynamic>>(
                  displayStringForOption: (option) => option.isNotEmpty
                      ? option['material'].toString().toUpperCase()
                      : '',
                  fieldViewBuilder: (context, textEditingController, focusNode,
                      onFieldSubmitted) {
                    return MDTextFormField(
                      textCapitalization: TextCapitalization.characters,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10.0),
                      textController: textEditingController,
                      focusNode: focusNode,
                      borderType: TextFormBorderType.outline,
                      borderColor: Colors.grey.shade300,
                    );
                  },
                  initialValue: TextEditingValue(
                      text: value.materialCode != null
                          ? value.materialCode.toString()
                          : ''),
                  optionsViewBuilder: (context, onSelected, options) {
                    return Material(
                      elevation: 4.0,
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: options.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(options.elementAt(index)['material']),
                              subtitle:
                                  Text(options.elementAt(index)['description']),
                              onTap: () {
                                onSelected(options.elementAt(index));
                              },
                            );
                          }),
                    );
                  },
                  optionsBuilder: (TextEditingValue fruitTextEditingValue) {
                    if (fruitTextEditingValue.text == '') {
                      return value.materialList!.isNotEmpty
                          ? value.materialList!.toList()
                          : [];
                    }
                    if (value.materialList!.isNotEmpty) {
                      return value.materialList!.where((option) {
                        return option.values
                            .map((e) => e.toString().toLowerCase())
                            .contains(fruitTextEditingValue.text.toLowerCase());
                      });
                    }
                    return [];
                  },
                  onSelected: (selected) =>
                      onSelectMaterial(selected['material']),
                ),
                const SizedBox(height: 10),
                const Text('Coverage Date:'),
                MDTextFormField(
                  textController: TextEditingController(
                      text: value.coverageDate != null
                          ? value.coverageDate!.join(' - ')
                          : ''),
                  borderType: TextFormBorderType.outline,
                  borderColor: Colors.grey.shade300,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  suffixIcon: IconButton(
                    onPressed: () async {
                      final DateTimeRange? coverageDate =
                          await showDateRangePicker(
                              context: context,
                              currentDate: DateTime.now(),
                              initialDateRange: null,
                              firstDate: DateTime(DateTime.now().year - 1),
                              lastDate: DateTime(DateTime.now().year + 1));
                      if (coverageDate != null) {
                        onSelectCoverageDate(coverageDate);
                      }
                    },
                    icon: Icon(
                      Icons.calendar_month_rounded,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                FilterButton(
                    onPressed: customerList.isNotEmpty ? onFilterData : null),
                ClearButton(
                    onTap: customerList.isNotEmpty ? onClearFilter : null,
                    mediaSize: mediaSize)
              ],
            );

            return SingleChildScrollView(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              child: column,
            ));
          },
        ),
      ),
    );
  }
}
