import 'package:addrec_employee_management/app/data/constants/const.dart';
import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/modules/home/model/employee_model.dart';
import 'package:addrec_employee_management/app/routes/app_pages.dart';
import 'package:addrec_employee_management/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSearchDelegate extends SearchDelegate {
// Demo list to show querying
  List<String> searchTerms = [
    "Apple",
    "Banana",
    "Mango",
    "Pear",
    "Watermelons",
    "Blueberries",
    "Pineapples",
    "Strawberries"
  ];

// first overwrite to
// clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    List<Employee> matchParams = [];
    for (var i = 0; i < employee.length; i++) {
      if ((employee[i].firstName).toLowerCase().contains(query.toLowerCase()) ||
          employee[i].lastName.toLowerCase().contains(query.toLowerCase()) ||
          employee[i].companyName.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add('${employee[i].firstName} ${employee[i].lastName}');
        matchParams.add(employee[i]);
      }
    }
    // for (var fruit in searchTerms) {
    //   if (fruit.toLowerCase().contains(query.toLowerCase())) {
    //     matchQuery.add(fruit);
    //   }
    // }
    return Container();
    // return ListView.builder(
    //   itemCount: matchParams.length,
    //   itemBuilder: (context, index) {
    //     Employee result = matchParams[index];
    //     return ListTile(
    //       title: Column(
    //         children: [
    //           Text(result.firstName),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    List<Employee> matchParams = [];
    for (var i = 0; i < employee.length; i++) {
      if (employee[i].firstName.toLowerCase().contains(query.toLowerCase()) ||
          employee[i].lastName.toLowerCase().contains(query.toLowerCase()) ||
          employee[i].companyName.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add('${employee[i].firstName} ${employee[i].lastName}');
        matchParams.add(employee[i]);
      }
    }
    // for (var fruit in searchTerms) {
    //   if (fruit.toLowerCase().contains(query.toLowerCase())) {
    //     matchQuery.add(fruit);
    //   }
    // }
    // return Container();
    return ListView.builder(
      itemCount: matchParams.length,
      itemBuilder: (context, index) {
        Employee result = matchParams[index];
        if (query == '') {
          print('index 0');
          return Container();
        } else {
          print(index);
          return ListTile(
            title: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: '${result.firstName} ${result.lastName}',
                      size: 16,
                    ),
                    CustomText(
                      text: result.companyName,
                      size: 14,
                      fontfamily: 'semiBold',
                      color: colorPrimary,
                    ),
                    const Divider(
                      thickness: 1,
                    )
                  ],
                ),
                Positioned(
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.EMPLOYEE_DETAILS,
                          arguments: {"id" : employee[index].id, "profile" : employee[index].profilePic});
                      // Get.to(EmployeeDetailsScreen(
                      //     arguments: {'employeeId': result}));
                      // navigationController.navigateTO(
                      //     employeeDetailsScreenRoute, {'employeeId': result});
                    },
                    child:  Center(
                      child: CustomText(
                        text: 'view',
                        size: 15,
                        fontfamily: 'semiBold',
                        color: colorSecondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
