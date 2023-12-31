import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/modules/connections_taps/my_connectios.dart';
import 'package:social_app/shared/network/local/cubit/cubit.dart';
import 'package:social_app/shared/network/local/cubit/cubit_states.dart';
import 'package:social_app/shared/style/colors.dart';
import 'connections_taps/let_me_connect.dart';

class Connections extends StatefulWidget {

  @override
  State<Connections> createState() => _ConnectionsState();
}

class _ConnectionsState extends State<Connections> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  TabBar _tabBar = TabBar(
    tabs: const [
      Tab(text: "My Connections"),
      Tab(text: "Let Me Connect"),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: _tabBar.preferredSize,
            child: Material(
              color: cubit.isDark ? DarkSurface :Colors.white,
              child: TabBar(
                controller: _tabController,
                indicatorColor: cubit.isDark ? Colors.grey : Colors.black,
                labelColor: cubit.isDark ? Colors.white : Colors.black,
                labelStyle: TextStyle(fontSize: 13.sp),
                tabs: [
                  Tab(text: "Let Me Connect"),
                  Tab(text: "My Connections"),
                ],
              ),
            ),
          ),
          body:TabBarView(
            controller: _tabController,
            physics: BouncingScrollPhysics(),
            children: [
              LetMeConnect(),
              MyConnections(),
            ],
          ),
        );
      },
    );
  }
}

