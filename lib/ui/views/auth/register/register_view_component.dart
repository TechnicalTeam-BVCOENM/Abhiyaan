import 'package:darpan/file_exporter.dart';
import 'package:darpan/ui/views/auth/register/register_view.dart';

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.colorScheme.secondaryWhiteColor),
        borderRadius: BorderRadius.circular(16.0).r,
        color: context.colorScheme.secondaryWhiteColor,
      ),
      child: DropdownButton<String>(
        value: dropdownValue,

        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
        },
        padding: const EdgeInsets.symmetric(horizontal: 15).r,
        underline: const SizedBox(), // Remove the default underline
        isExpanded: true,
        icon: Icon(
          Icons.arrow_drop_down,
          size: 40.sp,
        ),
        style: FontThemeClass().caption(
          context,
          color: context.colorScheme.secondaryBlackColor,
        ),
      ),
    );
  }
}
