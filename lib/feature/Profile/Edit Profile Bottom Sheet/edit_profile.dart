import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:netflix_clone/feature/Profile/Edit%20Profile%20Bottom%20Sheet/edit_profile_mixin.dart';
import 'package:netflix_clone/feature/Profile/View%20Model/profile_view_model.dart';
import 'package:netflix_clone/feature/TabBar/tab_bar_screen.dart';
import 'package:netflix_clone/product/constants/string_constants.dart';
import 'package:netflix_clone/product/mixin/app_route_mixin.dart';
import 'package:netflix_clone/product/widgets/Card/avatar_card.dart';

class ProfileAvatarTile extends StatefulWidget {
  final bool isEditing;
  final int index;
  final CreateSelectProfileViewModel viewModel;

  const ProfileAvatarTile({
    super.key,
    required this.isEditing,
    required this.viewModel,
    required this.index,
  });

  @override
  State<ProfileAvatarTile> createState() => _ProfileAvatarTileState();
}

class _ProfileAvatarTileState extends State<ProfileAvatarTile> with EditProfileMixin, MyNavigatorManager {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.isEditing
            ? showEditProfileSheet(
                context,
                widget.index,
                widget.viewModel,
              )
            : navigatoToWidget(
                context,
                TabBarScreen(
                  profileImage: widget.viewModel.profiles[widget.index]['photoURL'] ?? StringConstans.randomImageURL,
                  profileName: widget.viewModel.profiles[widget.index]['username'] ?? '',
                ),
              );
      },
      child: Observer(
        builder: (_) {
          return _CustomStack(
            widget: widget,
          );
        },
      ),
    );
  }
}

class _CustomStack extends StatelessWidget {
  const _CustomStack({
    required this.widget,
  });

  final ProfileAvatarTile widget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AvatarCard(
          isEditing: widget.isEditing,
          photoURL: widget.viewModel.profiles[widget.index]['photoURL'] ?? StringConstans.randomImageURL,
        ),
        widget.isEditing
            ? const Icon(
                Icons.edit,
                weight: 10.0,
                size: 30.0,
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
