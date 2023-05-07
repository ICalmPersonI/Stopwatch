import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stopwatch_dart/stopwatch_bloc.dart';

class RefreshButton extends StatelessWidget {
  final double topPadding;

  const RefreshButton(this.topPadding, {super.key});

  @override
  Widget build(BuildContext context) {
    StopwatchBloc bloc = BlocProvider.of<StopwatchBloc>(context);
    SvgPicture icon = SvgPicture.asset(
      'assets/icons/refresh-svgrepo-com.svg',
      colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn)
    );
    return Container(
      padding: EdgeInsets.only(top: topPadding),
      child: IconButton(
        onPressed: () => bloc.add(StopwatchRefresh()),
        icon: icon,
        iconSize: 55.0,
        color: Colors.white,
        key: const ValueKey("refresh_button"),
      ),
    );
  }
}
