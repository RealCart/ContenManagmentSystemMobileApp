import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instai/core/constants/app_colors.dart';
import 'package:instai/core/presentation/widgets/glass.dart';
import 'package:instai/core/presentation/widgets/logo.dart';
import 'package:instai/core/routing/app_router.gr.dart';
import 'package:instai/core/utils/global_loader.dart';
import 'package:instai/core/utils/status.dart';
import 'package:instai/features/authorization/domain/entities/form_params_entity.dart';
import 'package:instai/features/authorization/presentation/bloc/auth_bloc.dart';
import 'package:instai/features/authorization/presentation/widget/sign_in_form.dart';
import 'package:instai/features/authorization/presentation/widget/sign_up_form.dart';
import 'package:instai/service_locator.dart';

@RoutePage()
class AuthScreen extends StatefulWidget implements AutoRouteWrapper {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => getIt<AuthBloc>(), child: this);
  }
}

class _AuthScreenState extends State<AuthScreen> {
  late final GlobalKey<FormState> _formKey = GlobalKey();
  late final TextEditingController _emailSignInController;
  late final TextEditingController _emailSignUpController;
  late final TextEditingController _passwordSignInController;
  late final TextEditingController _passwordSignUpController;
  late final TextEditingController _repeatPasswordSignUpController;
  late final FocusNode _emailSignInFocusNode;
  late final FocusNode _emailSignUpFocusNode;
  late final FocusNode _passwordSignInFocusNode;
  late final FocusNode _passwordSignUpFocusNode;
  late final FocusNode _repeatPasswordSignUpFocusNode;

  @override
  void initState() {
    super.initState();
    _emailSignInController = TextEditingController();
    _emailSignUpController = TextEditingController();
    _passwordSignInController = TextEditingController();
    _passwordSignUpController = TextEditingController();
    _repeatPasswordSignUpController = TextEditingController();
    _emailSignInFocusNode = FocusNode();
    _emailSignUpFocusNode = FocusNode();
    _passwordSignInFocusNode = FocusNode();
    _passwordSignUpFocusNode = FocusNode();
    _repeatPasswordSignUpFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _emailSignInController.dispose();
    _emailSignUpController.dispose();
    _passwordSignInController.dispose();
    _passwordSignUpController.dispose();
    _repeatPasswordSignUpController.dispose();
    _emailSignInFocusNode.dispose();
    _emailSignUpFocusNode.dispose();
    _passwordSignInFocusNode.dispose();
    _passwordSignUpFocusNode.dispose();
    _repeatPasswordSignUpFocusNode.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final bool isSignIn =
        BlocProvider.of<AuthBloc>(context).state.pageState == PageState.signIn;

    late final FormParamsEntity formParams;

    if (isSignIn) {
      formParams = FormParamsEntity(
        login: _emailSignInController.text,
        password: _passwordSignInController.text,
      );
    } else {
      formParams = FormParamsEntity(
        login: _emailSignUpController.text,
        password: _passwordSignUpController.text,
      );
    }

    BlocProvider.of<AuthBloc>(context).add(SubmitFormEvent(formParams));
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.gradientColors,
          stops: [0.0, 0.2, 0.4, 0.8, 1.0],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == Status.loading) {
              context.showLoader();
            } else {
              context.hideLoader();
            }

            if (state.status == Status.successfully) {
              context.replaceRoute(const HomeRoute());
            }

            if (state.status == Status.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error?.errorMessage ?? "")),
              );
            }
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Logo(),
                        const SizedBox(height: 10.0),
                        Glass(
                          padding: const EdgeInsets.all(24),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                BlocSelector<AuthBloc, AuthState, PageState>(
                                  selector: (state) => state.pageState,
                                  builder: (context, state) {
                                    if (state == PageState.signUp) {
                                      return SignUpForm(
                                        emailController: _emailSignUpController,
                                        emailFocusNode: _emailSignUpFocusNode,
                                        passwordController:
                                            _passwordSignUpController,
                                        passwordFocusNode:
                                            _passwordSignUpFocusNode,
                                        repeatPasswordController:
                                            _repeatPasswordSignUpController,
                                        repeatPasswordFocusNode:
                                            _repeatPasswordSignUpFocusNode,
                                        onFinishedForm: () => _submit(),
                                      );
                                    }

                                    return SignInForm(
                                      emailController: _emailSignInController,
                                      emailFocusNode: _emailSignInFocusNode,
                                      passwordController:
                                          _passwordSignInController,
                                      passwordFocusNode:
                                          _passwordSignInFocusNode,
                                      onFinishedForm: () => _submit(),
                                    );
                                  },
                                ),
                                const SizedBox(height: 10.0),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: AppColors.accentBlue,
                                    minimumSize: const Size(
                                      double.infinity,
                                      0.0,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12.0,
                                    ),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadiusGeometry.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () => _submit(),
                                  child:
                                      BlocSelector<
                                        AuthBloc,
                                        AuthState,
                                        PageState
                                      >(
                                        selector: (state) => state.pageState,
                                        builder: (context, state) {
                                          final String text =
                                              state == PageState.signIn
                                              ? "Sign in"
                                              : "Sign up";

                                          return Text(
                                            text,
                                            style: const TextStyle(
                                              color: AppColors.white,
                                            ),
                                          );
                                        },
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 10.0),
                  BlocSelector<AuthBloc, AuthState, PageState>(
                    selector: (state) => state.pageState,
                    builder: (context, state) {
                      if (state == PageState.signUp) {
                        return Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(text: "Already have an account? "),
                              TextSpan(
                                text: "Sign in",
                                style: const TextStyle(
                                  color: AppColors.accentBlue,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    BlocProvider.of<AuthBloc>(context).add(
                                      const ChangeAuthStateEvent(
                                        PageState.signIn,
                                      ),
                                    );
                                  },
                              ),
                            ],
                          ),
                        );
                      }

                      return Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(text: "Don't have an account? "),
                            TextSpan(
                              text: "Sign up",
                              style: const TextStyle(
                                color: AppColors.accentBlue,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  BlocProvider.of<AuthBloc>(context).add(
                                    const ChangeAuthStateEvent(
                                      PageState.signUp,
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
