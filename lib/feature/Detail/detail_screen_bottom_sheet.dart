import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:netflix_clone/feature/Detail/detail_screen_bottom_sheet_mixin.dart';
import 'package:netflix_clone/feature/Home/HomeView/home_view_model.dart';
import 'package:netflix_clone/product/enums/image_enums.dart';

// ignore: must_be_immutable
class CardListPoster extends StatefulWidget {
  CardListPoster({
    Key? key,
    this.index,
    this.imagePath,
    this.mediaType,
    this.viewModel,
  }) : super(key: key);
  final int? index;
  final String? mediaType; // Yeni eklenen mediaType
  final MovieViewModel? viewModel;

  String? imagePath; // Add this line to receive the index value

  @override
  State<CardListPoster> createState() => _CardListPosterState();
}

class _CardListPosterState extends State<CardListPoster> with TickerProviderStateMixin, DetailScreenBottomSheetMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // AnimationController'ı etkinleştirirken 'vsync' parametresine 'this' (State) ekleyin.
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this, // Bu, TickerProvider'ı etkinleştirir.
    );

    // Diğer animasyon işlemleri burada yapılabilir.
  }

  @override
  void dispose() {
    _controller.dispose(); // Animasyon kontrolcüsünü yok edin.
    super.dispose();
  }

  // Update the constructor
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Expanded(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                showDetailScreenBottomSheet();
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 50,
                child: SizedBox(
                  // ignore: deprecated_member_use
                  height: context.dynamicHeight(0.2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      ImageConstants.imagePath + (widget.imagePath ?? ''),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
