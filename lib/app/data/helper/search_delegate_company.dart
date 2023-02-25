import 'package:addrec_employee_management/app/data/constants/const.dart';
import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/modules/add-user/controllers/add_user_controller.dart';
import 'package:addrec_employee_management/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AddUserController controllerUser = Get.find();

class CustomSearchDelegateCompany extends SearchDelegate {
// Demo list to show querying
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
    for (var fruit in controllerUser.companyList) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List data = [];
    for (var i = 0; i < companyData.length; i++) {
      data.add('${companyData[i].name} (${companyData[i].code})');
    }
    List<String> matchQuery = [];
    var matchParams = [];
    for (var i = 0; i < data.length; i++) {
      if (data[i].toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(data[i]);
        matchParams.add(data[i]);
      }
    }
    // for (var fruit in searchTerms) {
    //   if (fruit.toLowerCase().contains(query.toLowerCase())) {
    //     matchQuery.add(fruit);
    //   }
    // }
    // return Container();
    return ListViewCustom(
      matchParams: matchParams,
    );
  }
}

class ListViewCustom extends StatefulWidget {
  final List matchParams;
  const ListViewCustom({Key? key, required this.matchParams}) : super(key: key);

  @override
  State<ListViewCustom> createState() => ListViewCustomState();
}

class ListViewCustomState extends State<ListViewCustom> {
  List<String> tempAddedCompany = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.matchParams.isEmpty) {
      return Container();
    } else {
      // return Container();
      return ListView.builder(
        itemCount: widget.matchParams.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          print(widget.matchParams[index]);
          var result = '';
          // try {
          result = widget.matchParams[index];
          print(result);
          // } catch (e) {
          //   print(e.toString());
          // }

          return ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: result,
                      size: 16,
                      color: result == 'Company' ? gray : black,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (addedCompanyList.contains(result) ||
                              tempAddedCompany.contains(result)) {
                            print('remove');
                            addedCompanyList.remove(result);
                            tempAddedCompany.remove(result);
                            // print(controllerUser.addedCompanyList);
                          } else {
                            print('addedd');
                            addedCompanyList.add(result);
                            tempAddedCompany.add(result);
                            // print(controllerUser.addedCompanyList);
                          }
                        });
                      },
                      child: CustomText(
                        text: result == 'Company' || result == ''
                            ? ''
                            : (addedCompanyList.contains(result)
                                ? 'Remove'
                                : 'Add'),
                        fontfamily: 'semiBold',
                        color: addedCompanyList.contains(result)
                            ? colorPrimary
                            : colorSecondary,
                        size: 16,
                      ),
                    ),
                  ],
                ),
                // const Divider(
                //   thickness: 1,
                // )
              ],
            ),
          );
        },
      );
    }
  }
}
