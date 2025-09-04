import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meal_mate/features/online_meals/area_feature/manager/cubit/area_cubit.dart';
import 'package:meal_mate/features/online_meals/area_feature/manager/cubit/area_state.dart';

import 'package:meal_mate/features/online_meals/area_feature/widgets/areas_grid.dart';
import 'package:meal_mate/features/online_meals/area_feature/widgets/exit_dialoge.dart';

class AreasScreen extends StatefulWidget {
  const AreasScreen({super.key});

  @override
  State<AreasScreen> createState() => _AreasScreenState();
}

class _AreasScreenState extends State<AreasScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AreaCubit>().getAreas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        final shouldExit =
            await showDialog<bool>(
              context: context,
              barrierDismissible: false,
              builder: (_) => const ExitDialog(),
            ) ??
            false;

        if (shouldExit) SystemNavigator.pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "available_areas".tr(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),
        body: BlocBuilder<AreaCubit, AreaState>(
          builder: (context, state) {
            if (state is AreaLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AreaLoaded) {
              return AreasGrid(areas: state.areas);
            } else if (state is AreaError) {
              final colors = Theme.of(context).colorScheme;
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(color: colors.error),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
