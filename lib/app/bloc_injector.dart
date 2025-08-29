import 'package:apppallet_flutter/app/repositories/home/home_repository.dart';
import 'package:apppallet_flutter/app/repositories/load/load_repository.dart';
import 'package:apppallet_flutter/app/repositories/login/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_widget.dart';
import 'core/helpers/environments.dart';
import 'core/rest/http/http_rest_client.dart';
import 'core/rest/rest_client.dart';
import 'modules/home/cubit/home_bloc_cubit.dart';
import 'modules/load/cubit/load_bloc_cubit.dart';
import 'modules/login/cubit/login_bloc_cubit.dart';

class BlocInjection extends StatelessWidget {
  final RestClient _apiRestClient = HttpRestClient(
    baseUrl: Environments.get('BASE_URL') ?? "",
  );

  BlocInjection({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBlocCubit>(
          create:
              (context) => LoginBlocCubit(
                loginRepository: LoginRepository(rest: _apiRestClient),
              ),
        ),
        BlocProvider<HomeBlocCubit>(
          create: (context) => HomeBlocCubit(homeRepository: HomeRepository()),
        ),
        BlocProvider<LoadBlocCubit>(
          create: (context) => LoadBlocCubit(loadRepository: LoadRepository()),
        ),
      ],
      child: const AppWidget(),
    );
  }
}
