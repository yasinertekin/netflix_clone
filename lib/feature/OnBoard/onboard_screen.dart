import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/product/constants/string_constants.dart';
import 'package:netflix_clone/product/mixin/app_route_mixin.dart';
import 'package:netflix_clone/product/widgets/Logo/netflix_appbar_logo.dart';
import 'package:netflix_clone/product/widgets/Text%20Button/support_text_button.dart';

import '../../product/constants/color_constants.dart';
import '../../product/models/OnBoardScreenModel/onboard_screen_model.dart';
import '../../product/widgets/Tab Indicator/custom_tab_indicator.dart';
import '../auth/authentication_view.dart';
import 'onboard_screen_provider.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OnBoardScreenProvider onBoardScreenProvider = OnBoardScreenProvider();

    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: _myAppBar(context),
      body: SizedBox(
        height: context.general.mediaQuery.size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: context.general.mediaQuery.size.height * 0.7,
              child: Observer(
                builder: (BuildContext context) {
                  return _myPageView(onBoardScreenProvider);
                },
              ),
            ),
            Observer(builder: (_) {
              return CustomTabIndicator(
                selectedIndex: onBoardScreenProvider.selectedIndex,
              );
            }),
            Padding(
              padding: context.padding.normal,
              child: const _CustomSignInButton(),
            )
          ],
        ),
      ),
    );
  }

  AppBar _myAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: const [
        _PrivacyTextButton(),
        SupportTextButton(),
      ],
      title: const Padding(
        padding: EdgeInsets.only(right: 30, top: 20),
        child: NetflixAppBarLogo(),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  PageView _myPageView(OnBoardScreenProvider onBoardScreenProvider) {
    return PageView.builder(
      controller: PageController(initialPage: onBoardScreenProvider.selectedIndex),
      onPageChanged: (value) {
        onBoardScreenProvider.changeSelectedIndex(value);
      },
      scrollDirection: Axis.horizontal,
      itemCount: OnBoardScreenModels.onboardScreenItems.length,
      itemBuilder: (context, index) {
        return _myPageViewBody(index, context);
      },
    );
  }

  Column _myPageViewBody(int index, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          fit: BoxFit.cover,
          OnBoardScreenModels.onboardScreenItems[index].imageWithPath,
          height: context.general.mediaQuery.size.height * 0.4,
        ),
        Text(
          textAlign: TextAlign.center,
          OnBoardScreenModels.onboardScreenItems[index].title,
          style: context.general.textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: ColorConstants.white,
          ),
        ),
        SizedBox(
          height: context.general.mediaQuery.size.height * 0.02,
        ),
        Padding(
          padding: context.padding.normal,
          child: Text(
            textAlign: TextAlign.center,
            OnBoardScreenModels.onboardScreenItems[index].description,
            style: context.general.textTheme.bodyLarge?.copyWith(
              color: ColorConstants.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _CustomSignInButton extends StatelessWidget with MyNavigatorManager {
  const _CustomSignInButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        navigatoToWidget(context, const AuthenticationView());
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        minimumSize: Size(context.general.mediaQuery.size.height * 0.8, context.general.mediaQuery.size.height * 0.07),
      ),
      child: Text(
        'Oturum Aç',
        style: context.general.textTheme.bodyLarge?.copyWith(
          color: ColorConstants.white,
        ),
      ),
    );
  }
}

class _PrivacyTextButton extends StatelessWidget {
  const _PrivacyTextButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        StringConstans.privacy,
        style: context.general.textTheme.bodyMedium?.copyWith(
          color: ColorConstants.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
