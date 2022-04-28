import 'package:get/get.dart';

import 'package:latihan_firebase/app/modules/add_note/bindings/add_note_binding.dart';
import 'package:latihan_firebase/app/modules/add_note/views/add_note_view.dart';
import 'package:latihan_firebase/app/modules/home/bindings/home_binding.dart';
import 'package:latihan_firebase/app/modules/home/views/home_view.dart';
import 'package:latihan_firebase/app/modules/login/bindings/login_binding.dart';
import 'package:latihan_firebase/app/modules/login/views/login_view.dart';
import 'package:latihan_firebase/app/modules/profile/bindings/profile_binding.dart';
import 'package:latihan_firebase/app/modules/profile/views/profile_view.dart';
import 'package:latihan_firebase/app/modules/register/bindings/register_binding.dart';
import 'package:latihan_firebase/app/modules/register/views/register_view.dart';
import 'package:latihan_firebase/app/modules/reset_password/bindings/reset_password_binding.dart';
import 'package:latihan_firebase/app/modules/reset_password/views/reset_password_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

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
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ADD_NOTE,
      page: () => AddNoteView(),
      binding: AddNoteBinding(),
    ),
  ];
}
