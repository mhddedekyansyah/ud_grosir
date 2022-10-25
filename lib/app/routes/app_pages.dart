import 'package:get/get.dart';

import '../modules/add_product/bindings/add_product_binding.dart';
import '../modules/add_product/views/add_product_view.dart';
import '../modules/add_user/bindings/add_user_binding.dart';
import '../modules/add_user/views/add_user_view.dart';
import '../modules/admin_home/bindings/admin_home_binding.dart';
import '../modules/admin_home/views/admin_home_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/checkout/bindings/checkout_binding.dart';
import '../modules/checkout/views/checkout_view.dart';
import '../modules/edit_grosir/bindings/edit_grosir_binding.dart';
import '../modules/edit_grosir/views/edit_grosir_view.dart';
import '../modules/edit_product/bindings/edit_product_binding.dart';
import '../modules/edit_product/views/edit_product_view.dart';
import '../modules/form_register/bindings/form_register_binding.dart';
import '../modules/form_register/views/form_register_view.dart';
import '../modules/grosir_product/bindings/grosir_product_binding.dart';
import '../modules/grosir_product/views/grosir_product_view.dart';
import '../modules/grosir_transactions/bindings/grosir_transactions_binding.dart';
import '../modules/grosir_transactions/views/grosir_transactions_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home_grosir/bindings/home_grosir_binding.dart';
import '../modules/home_grosir/views/home_grosir_view.dart';
import '../modules/main_home_user/bindings/main_home_user_binding.dart';
import '../modules/main_home_user/views/main_home_user_view.dart';
import '../modules/read_grosir/bindings/read_grosir_binding.dart';
import '../modules/read_grosir/views/read_grosir_view.dart';
import '../modules/read_product/bindings/read_product_binding.dart';
import '../modules/read_product/views/read_product_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/transaction/bindings/transaction_binding.dart';
import '../modules/transaction/views/transaction_view.dart';
import '../modules/transactionSuccess/bindings/transaction_success_binding.dart';
import '../modules/transactionSuccess/views/transaction_success_view.dart';
import '../modules/user_home/bindings/user_home_binding.dart';
import '../modules/user_home/views/user_home_view.dart';
import '../modules/verify/bindings/verify_binding.dart';
import '../modules/verify/views/verify_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY,
      page: () => VerifyView(),
      binding: VerifyBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_HOME,
      page: () => AdminHomeView(),
      binding: AdminHomeBinding(),
    ),
    GetPage(
      name: _Paths.USER_HOME,
      page: () => UserHomeView(),
      binding: UserHomeBinding(),
    ),
    GetPage(
      name: _Paths.FORM_REGISTER,
      page: () => const FormRegisterView(),
      binding: FormRegisterBinding(),
    ),
    GetPage(
      name: _Paths.ADD_USER,
      page: () => const AddUserView(),
      binding: AddUserBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_HOME_USER,
      page: () => const MainHomeUserView(),
      binding: MainHomeUserBinding(),
    ),
    GetPage(
      name: _Paths.HOME_GROSIR,
      page: () => HomeGrosirView(),
      binding: HomeGrosirBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PRODUCT,
      page: () => AddProductView(),
      binding: AddProductBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION,
      page: () => TransactionView(),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: _Paths.GROSIR_PRODUCT,
      page: () => GrosirProductView(),
      binding: GrosirProductBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.READ_PRODUCT,
      page: () => const ReadProductView(),
      binding: ReadProductBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PRODUCT,
      page: () => EditProductView(),
      binding: EditProductBinding(),
    ),
    GetPage(
      name: _Paths.READ_GROSIR,
      page: () => const ReadGrosirView(),
      binding: ReadGrosirBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_GROSIR,
      page: () => EditGrosirView(),
      binding: EditGrosirBinding(),
    ),
    GetPage(
      name: _Paths.GROSIR_TRANSACTIONS,
      page: () => GrosirTransactionsView(),
      binding: GrosirTransactionsBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION_SUCCESS,
      page: () => const TransactionSuccessView(),
      binding: TransactionSuccessBinding(),
    ),
  ];
}
