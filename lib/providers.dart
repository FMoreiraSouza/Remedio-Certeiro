import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:remedio_certeiro/api-setup/app-write-service.dart';
import 'package:remedio_certeiro/components/home/controllers/home-controller.dart';
import 'package:remedio_certeiro/components/login/controllers/login_controller.dart';
import 'package:remedio_certeiro/components/medicine-register/controllers/medicine-register-controller.dart';
import 'package:remedio_certeiro/components/user-register/controllers/user-register-controller.dart';

List<SingleChildWidget> getProviders() {
  return [
    ChangeNotifierProvider(create: (_) => LoginController()),
    ChangeNotifierProvider(create: (_) => HomeController()),
    ChangeNotifierProvider(create: (_) => MedicineRegisterController()),
    Provider(create: (_) => AppWriteService()),
    ChangeNotifierProvider(
        create: (context) =>
            UserRegisterController(Provider.of<AppWriteService>(context, listen: false))),
    // ChangeNotifierProvider(create: (_) => MedicineListController()),
  ];
}
