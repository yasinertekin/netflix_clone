import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/feature/Profile/View%20Model/profile_view_model.dart';
import 'package:netflix_clone/product/constants/double_constants.dart';
import 'package:netflix_clone/product/widgets/Card/avatar_card.dart';

class AvatarSelectBottomSheet extends StatelessWidget {
  const AvatarSelectBottomSheet({super.key, required this.viewModel, required this.snapshot});
  final CreateSelectProfileViewModel viewModel;
  final AsyncSnapshot<List<Map<String, dynamic>>> snapshot;
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Container(
        height: context.general.mediaQuery.size.height * DoubleConstants.defaultBottomSheetHeight,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Observer(builder: (_) {
          return _AvatarList(
            viewModel: viewModel,
            snapshot: snapshot,
          );
        }),
      );
    });
  }
}

class _AvatarList extends StatelessWidget {
  const _AvatarList({
    required this.viewModel,
    required this.snapshot,
  });

  final CreateSelectProfileViewModel viewModel;
  final AsyncSnapshot<List<Map<String, dynamic>>> snapshot;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _AvatarSelectHeader(),
        AvatarAndNameList(snapshot: snapshot, viewModel: viewModel),
      ],
    );
  }
}

class _AvatarSelectHeader extends StatelessWidget {
  const _AvatarSelectHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Icon(Icons.arrow_back),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 125.0,
          ),
          child: Text(
            'Choose Icon',
            style: context.general.textTheme.bodyLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _AvatarHorizantalList extends StatelessWidget {
  const _AvatarHorizantalList({
    required this.photos,
    required this.viewModel,
  });

  final List photos;
  final CreateSelectProfileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: photos.length,
      itemBuilder: (context, photoIndex) {
        return Padding(
          padding: context.padding.low,
          child: InkWell(
            onTap: () {
              viewModel.selectedPhotoURL = photos[photoIndex];
              Navigator.pop(context);
            },
            child: AvatarCard(photos: photos, photoIndex: photoIndex),
          ),
        );
      },
    );
  }
}

class AvatarAndNameListTile extends StatelessWidget {
  const AvatarAndNameListTile({
    super.key,
    required this.name,
    required this.photos,
    required this.viewModel,
  });

  final String name;
  final List photos;
  final CreateSelectProfileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: _CharactarName(name: name),
      subtitle: SizedBox(
        height: context.general.mediaQuery.size.height * DoubleConstants.defaultAvatarCardHeight,
        child: _AvatarHorizantalList(photos: photos, viewModel: viewModel),
      ),
    );
  }
}

class _CharactarName extends StatelessWidget {
  const _CharactarName({
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: context.general.textTheme.bodyLarge!.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class AvatarAndNameList extends StatelessWidget {
  const AvatarAndNameList({
    super.key,
    required this.snapshot,
    required this.viewModel,
  });

  final AsyncSnapshot<List<Map<String, dynamic>>> snapshot;
  final CreateSelectProfileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: snapshot.data!.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final characterData = snapshot.data![index];
          final name = characterData['name'] as String;
          final photos = characterData['photos'] as List<dynamic>;

          return AvatarAndNameListTile(name: name, photos: photos, viewModel: viewModel);
        },
      ),
    );
  }
}
