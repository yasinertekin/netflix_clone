import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/feature/Profile/Add%20Profile/add_profile.dart';
import 'package:netflix_clone/feature/Profile/Profile%20List/create_select_profile_view_model.dart';

class SelectAvatarCardS extends StatelessWidget {
  const SelectAvatarCardS({super.key, required this.viewModel});
  final CreateSelectProfileViewModel viewModel;
  // END: ed8c6549bwf9
  // END: ed8c6549bwf9

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [SelectAvatarCard(viewModel: viewModel)],
    );
  }
}

class SelectAvatarCard extends StatelessWidget {
  const SelectAvatarCard({
    super.key,
    required this.viewModel,
  });

  final CreateSelectProfileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _avatarSelecBottomSheet(context);
      },
      child: Stack(
        children: [
          SelectedPhotoCardImage(viewModel: viewModel),
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
        Row(
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
        ),
        SizedBox(
          height: context.dynamicHeight(0.5),
          child: ListView.builder(
            itemCount: snapshot.data!.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final characterData = snapshot.data![index];
              final name = characterData['name'] as String;
              final photos = characterData['photos'] as List<dynamic>;

              return ListTile(
                title: Text(
                  name,
                  style: context.general.textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: SizedBox(
                  height: context.dynamicHeight(0.20),
                  child: _AvatarHorizantalList(photos: photos, viewModel: viewModel),
                ),
              );
            },
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
            child: Card(
              color: context.randomColor,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  photos[photoIndex],
                  fit: BoxFit.cover,
                  height: context.dynamicHeight(0.25),
                  width: context.dynamicWidth(0.32),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
