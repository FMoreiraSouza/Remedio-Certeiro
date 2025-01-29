import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:remedio_certeiro/api-setup/app_write_service.dart';
import 'package:remedio_certeiro/components/home/controllers/home_controller.dart';
import 'package:remedio_certeiro/components/login/controllers/login_controller.dart';
import 'package:remedio_certeiro/components/medicine-register/controllers/medicine_register_controller.dart';
import 'package:remedio_certeiro/components/my-medicine-list/controllers/my_medicine_list_controller.dart';
import 'package:remedio_certeiro/components/profile/controllers/profile_controller.dart';
import 'package:remedio_certeiro/components/user-register/controllers/user_register_controller.dart';

List<SingleChildWidget> getProviders() {
  return [
    Provider(create: (_) => AppWriteService()),
    ChangeNotifierProvider(
        create: (context) => LoginController(Provider.of<AppWriteService>(context, listen: false))),
    ChangeNotifierProvider(
        create: (context) => ProfileController(
              Provider.of<AppWriteService>(context, listen: false),
            )),

    ChangeNotifierProvider(create: (_) => HomeController()),

    ChangeNotifierProvider(
        create: (context) =>
            MedicineRegisterController(Provider.of<AppWriteService>(context, listen: false))),

    ChangeNotifierProvider(
        create: (context) =>
            MyMedicineListController(Provider.of<AppWriteService>(context, listen: false))),

    ChangeNotifierProvider(
        create: (context) =>
            UserRegisterController(Provider.of<AppWriteService>(context, listen: false))),
    // ChangeNotifierProvider(create: (_) => MedicineListController()),
  ];
}
