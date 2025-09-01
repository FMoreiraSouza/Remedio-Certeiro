import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/core/constants/colors.dart';
import 'package:remedio_certeiro/core/constants/routes.dart';
import 'package:remedio_certeiro/core/constants/texts.dart';
import 'package:remedio_certeiro/presentation/screens/home/home_viewmodel.dart';
import 'package:remedio_certeiro/presentation/screens/home/widgets/empty_medicine_widget.dart';
import 'package:remedio_certeiro/presentation/screens/home/widgets/medicine_hour_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().fetchMedicineHours(isFirstFetch: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(Texts.appName),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () => Navigator.pushNamed(context, Routes.profile),
              ),
            ],
          ),
          body: Consumer<HomeViewModel>(
            builder: (context, viewModel, child) {
              return viewModel.medicineHours.isEmpty
                  ? const EmptyMedicineWidget()
                  : Column(
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pushNamed(context, Routes.myMedicineList),
                          child: const Text(Texts.myMedicines),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: viewModel.medicineHours.length,
                            itemBuilder: (context, index) {
                              final medicine = viewModel.medicineHours[index];
                              return MedicineHourCard(medicine: medicine);
                            },
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
        Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            return Visibility(
              visible: viewModel.isFirstLoading,
              child: Container(
                color: AppColors.background,
                child: const Center(child: CircularProgressIndicator()),
              ),
            );
          },
        ),
      ],
    );
  }
}
