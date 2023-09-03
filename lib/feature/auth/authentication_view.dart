import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/feature/Profile/create_select_profile_screen.dart';
import 'package:netflix_clone/feature/auth/authentication_view_model.dart';
import 'package:netflix_clone/product/constants/color_constants.dart';
import 'package:netflix_clone/product/constants/string_constants.dart';
import 'package:netflix_clone/product/widgets/netflix_appbar_logo.dart';
import 'package:netflix_clone/product/widgets/support_text_button.dart';

class AuthenticationView extends StatelessWidget {
  const AuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationViewModel authViewModel = AuthenticationViewModel();
    return Scaffold(
      backgroundColor: ColorConstants.dirtyPink,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: _AuthAppBar(),
      ),
      body: FirebaseUIActions(
        actions: [
          AuthStateChangeAction<SignedIn>((context, state) {
            if (state.user != null) {
              authViewModel.fetchUserDetail(state.user);
              authViewModel.isLogin = true;
              authViewModel.isLogin
                  ? Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateSelectProfileScreen()))
                  : null;
            }
          }),
        ],
        child: SafeArea(
          child: Padding(
            padding: context.padding.normal,
            child: const Center(
              child: Expanded(
                child: _AuthBody(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AuthBody extends StatelessWidget {
  const _AuthBody();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _FirebaseAuth(),
        _AuthDescription(),
      ],
    );
  }
}

class _AuthDescription extends StatelessWidget {
  const _AuthDescription();

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      StringConstans.authDescription,
      style: context.general.textTheme.titleSmall!.copyWith(
        color: ColorConstants.grey,
      ),
    );
  }
}

class _AuthAppBar extends StatelessWidget {
  const _AuthAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: const [
        SupportTextButton(),
      ],
      centerTitle: true,
      elevation: 1,
      backgroundColor: ColorConstants.black,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      title: const NetflixAppBarLogo(),
    );
  }
}

class _FirebaseAuth extends StatelessWidget {
  const _FirebaseAuth();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.normal,
      child: LoginView(
        action: AuthAction.signIn,
        showTitle: false,
        showAuthActionSwitch: false,
        actionButtonLabelOverride: StringConstans.actionButtonLabelOverrideSignIn,
        auth: FirebaseAuth.instance,
        providers: FirebaseUIAuth.providersFor(
          FirebaseAuth.instance.app,
        ),
      ),
    );
  }
}
