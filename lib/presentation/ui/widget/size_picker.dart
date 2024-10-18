import 'package:crafty_boy_ecommerce_app/presentation/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SizePicker extends StatefulWidget {
  const SizePicker(
      {super.key, required this.sizes, required this.sizeSelected});

  final List<String> sizes;
  final Function(String) sizeSelected;

  @override
  State<SizePicker> createState() => _SizePickerState();
}

class _SizePickerState extends State<SizePicker> {
  late String _selectedSize = widget.sizes.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          spacing: 8,
          children: widget.sizes.map(
                (item) {
              return GestureDetector(
                onTap: () {
                  _selectedSize = item;
                  widget.sizeSelected(item);
                  setState(() {});
                },
                child: Container(
                  padding:const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    color: _selectedSize == item ? AppColors.themeColor : null,
                  ),
                  child: Text(
                    item,style: TextStyle(color: _selectedSize == item ?Colors.white : null,fontSize: 20),
                  ),
                ),
              );
            },
          ).toList(),
        )
      ],
    );
  }
}