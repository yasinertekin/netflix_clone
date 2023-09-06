// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/feature/Profile/Profile%20List/create_select_profile_view_model.dart';
import 'package:netflix_clone/product/widgets/Card/avatar_card.dart';
import 'package:netflix_clone/product/widgets/Card/selected_photo_card_image.dart';
import 'package:netflix_clone/product/widgets/Icon%20Button/edit_icon_button.dart';

class SelectAvatarCards extends StatelessWidget {
  const SelectAvatarCards({super.key, required this.viewModel, this.photoURL});
  final CreateSelectProfileViewModel viewModel;
  final String? photoURL;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Observer(builder: (_) {
          return SelectAvatarCard(viewModel: viewModel, photoURL: photoURL);
        })
      ],
    );
  }
}

class SelectAvatarCard extends StatelessWidget {
  const SelectAvatarCard({
    super.key,
    required this.viewModel,
    this.photoURL,
  });

  final CreateSelectProfileViewModel viewModel;
  final String? photoURL;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _avatarSelecBottomSheet(context);
      },
      child: Stack(
        children: [
          SelectedPhotoCardImage(
            viewModel: viewModel,
            photoURL: photoURL,
          ),
          const EditIconButton(),
        ],
      ),
    );
  }

  Future<dynamic> _avatarSelecBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder<List<Map<String, dynamic>>>(
          future: viewModel.getCharacterDataList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No characters available.');
            } else {
              return _AvatarList(viewModel: viewModel, snapshot: snapshot);
            }
          },
        );
      },
    );
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
    return SizedBox(
      height: context.dynamicHeight(0.5),
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
        height: context.dynamicHeight(0.20),
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

class _AvatarSelectHeader extends StatelessWidget {
  const _AvatarSelectHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {},
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
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              viewModel.newPhotoURL = photos[photoIndex];
              Navigator.pop(context);
            },
            child: AvatarCard(photos: photos, photoIndex: photoIndex),
          ),
        );
      },
    );
  }
}
