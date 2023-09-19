import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:netflix_clone/feature/Detail/detail_screen.dart';
import 'package:netflix_clone/feature/Profile/Edit%20Profile%20Bottom%20Sheet/edit_profile_mixin.dart';
import 'package:netflix_clone/feature/TabBar/tab_bar_screen.dart';
import 'package:netflix_clone/product/constants/string_constants.dart';
import 'package:netflix_clone/product/mixin/app_route_mixin.dart';
import 'package:netflix_clone/product/models/ProfileModel/profile_model.dart';
import 'package:netflix_clone/product/widgets/Card/avatar_card.dart';

class ProfileAvatarTile extends StatefulWidget {
  final bool isEditing;
  final int index;
  final ProfileModel? profileModel;

  const ProfileAvatarTile({
    super.key,
    required this.isEditing,
    required this.index,
    required this.profileModel,
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
                viewModel,
              )
            : navigatoToWidget(
                context,
                TabBarScreen(
                  profileModel: widget.profileModel,
                  profileViewModel: viewModel,
                  profileImage: viewModel.profiles[widget.index]['photoURL'] ?? StringConstans.randomImageURL,
                  profileName: viewModel.profiles[widget.index]['username'] ?? '',
                ),
              );
      },
      child: _CustomStack(
        widget: widget,
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
        Observer(builder: (_) {
          //Avatarın güncellenmesi için burayı da sarmalamamız lazım
          return AvatarCard(
            isEditing: widget.isEditing,
            photoURL: viewModel.profiles[widget.index]['photoURL'] ?? StringConstans.randomImageURL,
          );
        }),
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
