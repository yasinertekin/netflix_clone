import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/feature/Home/HomeView/home_view_model.dart';
import 'package:netflix_clone/feature/My%20List%20Screen/my_list_screen.dart';
import 'package:netflix_clone/product/constants/color_constants.dart';

class HomeAppBarRowButton extends StatelessWidget {
  const HomeAppBarRowButton({
    super.key,
    required this.buttonTitle,
    this.isIcon = false,
    required this.viewModel,
  });

  final String buttonTitle;
  final bool isIcon;
  final MovieViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Observer(
        builder: (_) => TextButton(
          style: TextButton.styleFrom(
            backgroundColor:
                viewModel.showMovie || viewModel.showTvShow ? ColorConstants.grey : ColorConstants.transparant,
            side: const BorderSide(color: ColorConstants.white, style: BorderStyle.solid),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            if (buttonTitle == 'Movies') {
              viewModel.toggleDetailType();
            }
            if (buttonTitle == 'TV Shows') {
              viewModel.toggleTvShow();
            }
            if (buttonTitle == 'My List') {
              context.route.navigateToPage(const MyListScreen());
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                buttonTitle,
                style: const TextStyle(color: ColorConstants.white),
              ),
              isIcon
                  ? const Icon(
                      Icons.arrow_drop_down,
                      color: ColorConstants.white,
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
