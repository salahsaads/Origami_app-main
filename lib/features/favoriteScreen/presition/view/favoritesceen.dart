import 'package:flutter/material.dart';
import 'package:origami/bussinus_logic/authentiacation/authentication.dart';
import 'package:origami/core/Theme/constant.dart';
import 'package:origami/features/favoriteScreen/data/firebase.dart';
import 'package:origami/features/favoriteScreen/presition/view/Widget/favorite_Item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Weight/prestion/view_model/widget/Shimmer_Loading_weight.dart';

class Favoritescreen extends StatelessWidget {
  const Favoritescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: FirebaseGetFav().getFavorites(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ShimmerLoadingWeight();
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                  child: Text('No favorites found.',
                      style: TextStyle(color: kPrimarycolor, fontSize: 28)));
            } else {
              List<Map<String, dynamic>> favorites = snapshot.data!;

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.3,
                  mainAxisSpacing: 5,
                  crossAxisCount: 1,
                ),
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onDoubleTap: () async {},
                    child: FavoriteItem(
                      point: favorites[index]['point'],
                      name: favorites[index]['name'],
                      image: favorites[index]['image'],
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
