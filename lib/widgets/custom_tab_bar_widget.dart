import 'package:filter_app/core/color.dart';
import 'package:filter_app/core/constants.dart';
import 'package:filter_app/screens/all.dart';
import 'package:filter_app/screens/name.dart';
import 'package:flutter/material.dart';

class CustomTabBarWidget extends StatefulWidget {
  final List<Map<String, dynamic>> filteredData;

  const CustomTabBarWidget({super.key, required this.filteredData});

  @override
  State<CustomTabBarWidget> createState() => _CustomTabBarWidgetState();
}

class _CustomTabBarWidgetState extends State<CustomTabBarWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> tabContents = [
      All(
        filteredData: widget.filteredData,
      ),
      const Name(),
      const Center(
          child: Text(
        'PurchaseCode',
      )),
      const Center(child: Text('PaymentType')),
    ];
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: ListView.separated(
            padding: const EdgeInsets.only(left: 10, top: 10),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final bool isSelected = index == selectedIndex;

              return InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  decoration: isSelected
                      ? ShapeDecoration(
                          color: ColorsManager.burgundyColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60),
                          ),
                        )
                      : BoxDecoration(
                          border: Border.all(
                              color: ColorsManager.burgundyColor, width: 1),
                          borderRadius: BorderRadius.circular(45),
                        ),
                  child: Text(
                    items[index],
                    style: TextStyle(
                        color: isSelected
                            ? ColorsManager.whiteColor
                            : ColorsManager.burgundyColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => kSizedBoxW8,
            itemCount: items.length,
          ),
        ),
        kSizedBox15,
        Expanded(
          child: tabContents[selectedIndex],
        ),
      ],
    );
  }
}
// class ContainerWidget extends StatefulWidget {
//   final String text;
//
//   const ContainerWidget({super.key, required this.text,});
//
//   @override
//   State<ContainerWidget> createState() => _ContainerWidgetState();
// }
//
// class _ContainerWidgetState extends State<ContainerWidget> {
//
//   @override
//   Widget build(BuildContext context) {
//     return
//         SizedBox(
//           height: 50,
//           child:  Container(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//                   decoration: isSelected
//                       ? ShapeDecoration(
//                           color: ColorsManager.burgundyColor,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(60),
//                           ),
//                         )
//                       : BoxDecoration(
//                           border: Border.all(
//                               color: ColorsManager.burgundyColor, width: 1),
//                           borderRadius: BorderRadius.circular(45),
//                         ),
//                   child: Text(
//                     widget.text,
//                     style: TextStyle(
//                         color: isSelected
//                             ? ColorsManager.whiteColor
//                             : ColorsManager.burgundyColor,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500),
//                   ),
//                 ),
//     );
//   }
// }
