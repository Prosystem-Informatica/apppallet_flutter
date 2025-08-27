import 'package:apppallet_flutter/app/repositories/home_repository.dart';
import 'package:apppallet_flutter/app/repositories/login/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_widget.dart';
import 'core/helpers/environments.dart';
import 'core/rest/http/http_rest_client.dart';
import 'core/rest/rest_client.dart';
import 'modules/login/cubit/login_bloc_cubit.dart';


class BlocInjection extends StatelessWidget {
  final RestClient _apiRestClient = HttpRestClient(
    baseUrl: Environments.get('BASE_URL') ?? "",
  );

  BlocInjection({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<RestClient>(
          create: (context) => _apiRestClient,
        ),
        RepositoryProvider<LoginRepository>(
          create: (context) =>
              LoginRepository(
                rest: RepositoryProvider.of<RestClient>(context),
              ),
        ),
        RepositoryProvider<HomeRepository>(
          create: (context) =>
              HomeRepository(
              ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBlocCubit>(
            create: (context) =>
                LoginBlocCubit(
                  loginRepository: RepositoryProvider.of<LoginRepository>(
                      context),
                ),
          ),
        ],
        child: const AppWidget(),
      ),
    );
  }
}