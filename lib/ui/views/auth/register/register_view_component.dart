import 'package:darpan/file_exporter.dart';
import 'package:darpan/ui/views/auth/register/register_view.dart';

class DropdownMenuBtn extends StatefulWidget {
  const DropdownMenuBtn({super.key});

  @override
  State<DropdownMenuBtn> createState() => _DropdownMenuBtnState();
}

class _DropdownMenuBtnState extends State<DropdownMenuBtn> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
        ),
        if (dropdownValue == 'BVCOE Student')
          Column(
            children: [
              SizedBox(
                height: 15.h,
              ),
              TextFormField(
                cursorColor: context.colorScheme.primaryColor,
                controller: TextEditingController(),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15)
                          .r,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        const Radius.circular(15).r,
                      ),
                      borderSide: BorderSide.none),
                  fillColor: context.colorScheme.secondaryWhiteColor,
                  filled: true,
                  focusColor: context.colorScheme.secondaryWhiteColor,
                  hintText: 'Enter MIS Number',
                  hintStyle: FontThemeClass().caption(context,
                      color: context.colorScheme.secondarySectionColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
