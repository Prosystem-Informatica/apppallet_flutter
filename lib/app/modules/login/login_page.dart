import 'package:apppallet_flutter/app/modules/login/cubit/login_bloc_cubit.dart';
import 'package:apppallet_flutter/app/modules/login/cubit/login_bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/ui/helpers/messages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Messages<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final userController = TextEditingController();
  final passController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<LoginBlocCubit>(context).checkUrl();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  _login() async {
    if (_formKey.currentState!.validate()) {
      await context.read<LoginBlocCubit>().login(
        userController.text,
        passController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocConsumer<LoginBlocCubit, LoginBlocState>(
      listener: (context, state) {
        state.status.matchAny(
          success: () async {
            showSuccess(state.successMessage ?? "Login realizado com sucesso");
            // Get.toNamed("/home");
          },
          error: () {
            showError(state.errorMessage ?? "Erro não informado");
          },
          any: () {
            //Get.toNamed("/home");
          },
        );
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Column(
                      children: [
                        Image.asset("assets/logo.png", height: 80),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          spacing: 30,
                          children: [
                            TextFormField(
                              controller: userController,
                              decoration: InputDecoration(
                                hintText: "Ex: João",
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 14,
                                ),
                              ),
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return "Usuário é obrigatório";
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: passController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Senha",
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 14,
                                ),
                              ),
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return "Senha é obrigatório";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colorScheme.primaryContainer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: _login,
                                child: Text(
                                  "ENTRAR",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    "Versão 1.0.0",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
