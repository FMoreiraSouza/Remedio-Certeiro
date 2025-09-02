import 'package:flutter/material.dart';
import 'package:remedio_certeiro/core/states/error_state_widget.dart';
import 'package:remedio_certeiro/core/states/no_connection_state_widget.dart';
import 'package:remedio_certeiro/core/states/view_state_enum.dart';

class StateHandler extends StatelessWidget {
  final ViewStateEnum state;
  final String? errorMessage;
  final VoidCallback onRetry;
  final Widget successWidget;
  final Widget emptyWidget;
  final bool showLoadingOnTop;

  const StateHandler({
    super.key,
    required this.state,
    required this.onRetry,
    required this.successWidget,
    required this.emptyWidget,
    this.errorMessage,
    this.showLoadingOnTop = false,
  });

  @override
  Widget build(BuildContext context) {
    if (showLoadingOnTop && state == ViewStateEnum.loading) {
      return Stack(
        children: [
          successWidget,
          Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      );
    }

    switch (state) {
      case ViewStateEnum.success:
        return successWidget;
      case ViewStateEnum.loading:
        return Container(
          color: Colors.white,
          child: const Center(child: CircularProgressIndicator()),
        );
      case ViewStateEnum.error:
        return ErrorStateWidget(
          onRetry: onRetry,
          message: errorMessage ?? 'Ocorreu um erro inesperado',
        );
      case ViewStateEnum.noConnection:
        return NoConnectionStateWidget(onRetry: onRetry);
      case ViewStateEnum.empty:
        return emptyWidget;
    }
  }
}
