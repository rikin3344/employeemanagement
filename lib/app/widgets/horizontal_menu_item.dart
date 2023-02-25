import 'package:addrec_employee_management/app/data/constants/controllers.dart';
import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HorizontalMenuItem extends StatelessWidget {
  final String itemName;
  final String route;
  final Function onTap;
  const HorizontalMenuItem(
      {Key? key,
      required this.itemName,
      required this.route,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // navigationController.navigateTO(route);
        onTap();
      },
      onHover: (value) {
        value
            ? menuController.onHover(itemName)
            : menuController.onHover('not hovering');
      },
      child: Obx(() => Container(
            height: 60,
            margin:
                const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
            decoration: BoxDecoration(
                color: menuController.isHovering(itemName)
                    ? colorPrimary.withOpacity(0.2)
                    : menuController.isActive(itemName)
                        ? colorPrimary.withOpacity(0.8)
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(20.0)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: menuController.returnIconFor(route),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                if (!menuController.isActive(itemName))
                  Flexible(
                    child: CustomText(
                      text: itemName,
                      fontfamily: 'semiBold',
                      size: 18,
                      color: menuController.isHovering(itemName)
                          ? black.withOpacity(0.7)
                          : gray,
                    ),
                  )
                else
                  Flexible(
                    child: CustomText(
                      text: itemName,
                      color: white,
                      size: 18,
                      fontfamily: 'Hanuman-bold',
                    ),
                  )
              ],
            ),
          )),
    );
  }
}
