import 'package:get/get.dart';
import 'package:gps_software/screens/bottomBar/module/account/viewModel/account_view_model.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountViewModel>(() => AccountViewModel());
  }
}
