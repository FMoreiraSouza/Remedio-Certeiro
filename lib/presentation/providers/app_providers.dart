import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:remedio_certeiro/core/utils/database_helper.dart';
import 'package:remedio_certeiro/data/api/app_write_service.dart';
import 'package:remedio_certeiro/data/repositories/i_medicine_repository.dart';
import 'package:remedio_certeiro/data/repositories/i_user_repository.dart';
import 'package:remedio_certeiro/data/repositories/implementation/medicine_repository.dart';
import 'package:remedio_certeiro/data/repositories/implementation/user_repository.dart';
import 'package:remedio_certeiro/presentation/screens/home/home_viewmodel.dart';
import 'package:remedio_certeiro/presentation/screens/login/login_viewmodel.dart';
import 'package:remedio_certeiro/presentation/screens/medicine-register/medicine_register_viewmodel.dart';
import 'package:remedio_certeiro/presentation/screens/my-medicine-list/my_medicine_list_viewmodel.dart';
import 'package:remedio_certeiro/presentation/screens/profile/profile_viewmodel.dart';
import 'package:remedio_certeiro/presentation/screens/user-register/user_register_viewmodel.dart';

List<SingleChildWidget> getProviders() {
  return [
    Provider(create: (_) => AppWriteService()),
    Provider(create: (_) => DatabaseHelper.instance),
    Provider<IMedicineRepository>(
      create: (context) => MedicineRepository(
        context.read<AppWriteService>(),
        context.read<DatabaseHelper>(),
      ),
    ),
    Provider<IUserRepository>(
      create: (context) => UserRepository(context.read<AppWriteService>()),
    ),
    ChangeNotifierProvider(create: (context) => LoginViewModel(context.read<IUserRepository>())),
    ChangeNotifierProvider(
        create: (context) => UserRegisterViewModel(context.read<IUserRepository>())),
    ChangeNotifierProvider(create: (context) => HomeViewModel(context.read<IMedicineRepository>())),
    ChangeNotifierProvider(create: (context) => ProfileViewModel(context.read<IUserRepository>())),
    ChangeNotifierProvider(
      create: (context) => MyMedicineListViewModel(context.read<IMedicineRepository>()),
    ),
    ChangeNotifierProvider(
      create: (context) => MedicineRegisterViewModel(context.read<IMedicineRepository>()),
    ),
  ];
}
