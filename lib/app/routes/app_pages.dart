import 'package:get/get.dart';

import '../modules/activity-timeline/bindings/activity_timeline_binding.dart';
import '../modules/activity-timeline/views/activity_timeline_view.dart';
import '../modules/add-company/bindings/add_company_binding.dart';
import '../modules/add-company/views/add_company_view.dart';
import '../modules/add-employee/bindings/add_employee_binding.dart';
import '../modules/add-employee/views/add_employee_view.dart';
import '../modules/add-user/bindings/add_user_binding.dart';
import '../modules/add-user/views/add_user_view.dart';
import '../modules/dynamic-employee-form/bindings/dynamic_employee_form_binding.dart';
import '../modules/dynamic-employee-form/views/dynamic_employee_form_view.dart';
import '../modules/employee-details/bindings/employee_details_binding.dart';
import '../modules/employee-details/views/employee_details_view.dart';
import '../modules/forgot-password/bindings/forgot_password_binding.dart';
import '../modules/forgot-password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/manage-companies/bindings/manage_companies_binding.dart';
import '../modules/manage-companies/views/manage_companies_view.dart';
import '../modules/manage-user/bindings/manage_user_binding.dart';
import '../modules/manage-user/views/manage_user_view.dart';
import '../modules/sign-up/bindings/sign_up_binding.dart';
import '../modules/sign-up/views/sign_up_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ADD_COMPANY,
      page: () => AddCompanyView(),
      binding: AddCompanyBinding(),
    ),
    GetPage(
      name: _Paths.ADD_USER,
      page: () => AddUserView(),
      binding: AddUserBinding(),
    ),
    GetPage(
      name: _Paths.ADD_EMPLOYEE,
      page: () => AddEmployeeView(),
      binding: AddEmployeeBinding(),
    ),
    GetPage(
      name: _Paths.EMPLOYEE_DETAILS,
      page: () => EmployeeDetailsView(),
      binding: EmployeeDetailsBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.MANAGE_COMPANIES,
      page: () => ManageCompaniesView(),
      binding: ManageCompaniesBinding(),
    ),
    GetPage(
      name: _Paths.MANAGE_USER,
      page: () => ManageUserView(),
      binding: ManageUserBinding(),
    ),
    GetPage(
      name: _Paths.ACTIVITY_TIMELINE,
      page: () => ActivityTimelineView(),
      binding: ActivityTimelineBinding(),
    ),
    GetPage(
      name: _Paths.DYNAMIC_EMPLOYEE_FORM,
      page: () => const DynamicEmployeeFormView(),
      binding: DynamicEmployeeFormBinding(),
    ),
  ];
}
