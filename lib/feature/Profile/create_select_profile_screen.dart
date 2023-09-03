import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';
import 'package:netflix_clone/feature/Profile/create_select_profile_view_model.dart';
import 'package:netflix_clone/feature/TabBar/tab_bar_screen.dart';
import 'package:netflix_clone/product/mixin/app_route_mixin.dart';

class CreateSelectProfileScreen extends StatelessWidget with MyNavigatorManager {
  const CreateSelectProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = CreateSelectProfileViewModel();
    return Scaffold(
      appBar: const PreferredSize(preferredSize: Size.fromHeight(50), child: _Create_Select_Profile_Screen_Appbar()),
      backgroundColor: const Color(0xff161616),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: context.dynamicHeight(1),
            width: context.dynamicWidth(1),
            child: _buildProfileContent(context, viewModel),
          ),
        ),
      ),
    );
  }

  Column _buildProfileContent(BuildContext context, CreateSelectProfileViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildProfileListView(context, viewModel),
      ],
    );
  }

  SizedBox _buildProfileListView(BuildContext context, CreateSelectProfileViewModel viewModel) {
    return SizedBox(
      height: context.dynamicHeight(1),
      child: _buildProfileFutureBuilder(viewModel),
    );
  }

  FutureBuilder<List<Map<String, dynamic>>> _buildProfileFutureBuilder(CreateSelectProfileViewModel viewModel) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: viewModel.getProfiles(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        } else {
          viewModel.profiles = snapshot.data!;
          return _buildGridForProfiles(viewModel);
        }
      },
    );
  }

  GridView _buildGridForProfiles(CreateSelectProfileViewModel viewModel) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
      ),
      itemCount: viewModel.profiles.length + 1, // Profil sayısı + 1 (Add düğmesi için)
      itemBuilder: (context, index) {
        return _generateProfileGridItems(index, viewModel, context);
      },
    );
  }

  Padding _generateProfileGridItems(int index, CreateSelectProfileViewModel viewModel, BuildContext context) {
    if (index == viewModel.profiles.isEmpty) {
      // Son eleman "Add" düğmesi
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: _AddProfile(viewModel: viewModel),
      );
    } else if (index == viewModel.profiles.length) {
      // Son eleman "Add" düğmesi
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: viewModel.profiles.length < 5 ? _AddProfile(viewModel: viewModel) : const SizedBox.shrink(),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildProfileCardWidget(context, viewModel, index),
      );
    }
  }

  Column _buildProfileCardWidget(BuildContext context, CreateSelectProfileViewModel viewModel, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _profileAvatarTile(context, viewModel, index),
        _profileUsername(viewModel, index),
      ],
    );
  }

  Text _profileUsername(CreateSelectProfileViewModel viewModel, int index) =>
      Text(viewModel.profiles[index]['username'] ?? '');

  InkWell _profileAvatarTile(BuildContext context, CreateSelectProfileViewModel viewModel, int index) {
    return InkWell(
      onTap: () {
        navigatoToWidget(
            context,
            TabBarScreen(
              profileImage: viewModel.profiles[index]['photoURL'] ?? 'https://picsum.photos/200',
              profileName: viewModel.profiles[index]['username'] ?? '',
            ));
      },
      child: _avatarCard(viewModel, index, context),
    );
  }

  Card _avatarCard(CreateSelectProfileViewModel viewModel, int index, BuildContext context) {
    return Card(
      color: context.randomColor,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          viewModel.profiles[index]['photoURL'] ?? 'https://picsum.photos/200',
          height: context.dynamicHeight(0.20),
          width: context.dynamicWidth(0.32),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// ignore: unused_element, camel_case_types
class _Create_Select_Profile_Screen_Appbar extends StatelessWidget {
  const _Create_Select_Profile_Screen_Appbar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: const Text('Who is Watcing?'),
      actions: const [
        _EditTextButton(),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}

class _EditTextButton extends StatelessWidget {
  const _EditTextButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        child: const Text(
          'Edit',
          style: TextStyle(color: Colors.white),
        ));
  }
}

class _AddProfile extends StatelessWidget with MyNavigatorManager {
  const _AddProfile({
    required this.viewModel,
  });

  final CreateSelectProfileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _addProfileCard(context),
        Padding(
          padding: context.padding.onlyBottomLow,
          child: const _AddProfileText(),
        ),
      ],
    );
  }

  Card _addProfileCard(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(color: Colors.grey, width: 1),
      ),
      color: Colors.transparent,
      child: _addProfileBody(context),
    );
  }

  Column _addProfileBody(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.dynamicHeight(0.20),
          width: context.dynamicWidth(0.32),
          child: IconButton(
            iconSize: 45,
            onPressed: () {
              _addProfileBodyBottomSheet(context);
            },
            icon: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Future<dynamic> _addProfileBodyBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _addProfileBodyBottomSheetHeader(context),
              _SelectAvatarCard(viewModel: viewModel),
              Padding(
                padding: context.padding.onlyTopLow,
                child: SizedBox(
                  width: context.dynamicWidth(0.9),
                  child: _CustomTextFormField(viewModel: viewModel),
                ),
              ),
              Lottie.asset(
                repeat: false,
                'assets/lottie/tswitch.json',
                height: context.dynamicHeight(0.1),
                width: context.dynamicWidth(0.1),
              ),
            ],
          ),
        );
      },
    );
  }

  Row _addProfileBodyBottomSheetHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const _CancelTextButton(),
        Text(
          'Add Profile    ',
          style: context.general.textTheme.bodyLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        viewModel.newUsername.isNotEmpty && viewModel.newPhotoURL.isNotEmpty
            ? _saveButton(context)
            : const _InactiveSaveButton(),
      ],
    );
  }

  TextButton _saveButton(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await viewModel.addProfile(
            viewModel.newUsername, viewModel.newPhotoURL); // Kullanıcı adını ve fotoğrafı burada kaydedin

        // ignore: use_build_context_synchronously
        navigatoToWidget(
          context,
          const CreateSelectProfileScreen(),
        );
      },
      child: Text(
        'Save',
        style: context.general.textTheme.bodyLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _CustomTextFormField extends StatelessWidget {
  const _CustomTextFormField({
    required this.viewModel,
  });

  final CreateSelectProfileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        viewModel.newUsername = value;
      },
      style: context.general.textTheme.bodyLarge!.copyWith(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: 'Profile Name',
        hintStyle: context.general.textTheme.bodyLarge!.copyWith(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}

class _SelectAvatarCard extends StatelessWidget {
  const _SelectAvatarCard({
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
          _SelectedPhotoCardImage(viewModel: viewModel),
          const _EditIconButton(),
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
        final photoUrl = photos[photoIndex] as String;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              viewModel.newPhotoURL = photoUrl;
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
                  photoUrl,
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

class _EditIconButton extends StatelessWidget {
  const _EditIconButton();

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      bottom: 0,
      right: -1,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.edit,
          color: Colors.black,
        ),
      ),
    );
  }
}

class _SelectedPhotoCardImage extends StatelessWidget {
  const _SelectedPhotoCardImage({
    required this.viewModel,
  });

  final CreateSelectProfileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.2),
      child: Card(
        color: context.randomColor,
        child: Image.network(
          viewModel.newPhotoURL == '' ? 'https://picsum.photos/200' : viewModel.newPhotoURL,
          fit: BoxFit.cover,
          height: context.dynamicHeight(0.2),
          width: context.dynamicWidth(0.32),
        ),
      ),
    );
  }
}

class _InactiveSaveButton extends StatelessWidget {
  const _InactiveSaveButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: const Text(
        'Save',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}

class _CancelTextButton extends StatelessWidget {
  const _CancelTextButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text(
        'Cancel',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class _AddProfileText extends StatelessWidget {
  const _AddProfileText();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Add Profile',
      style: context.general.textTheme.bodyLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}
