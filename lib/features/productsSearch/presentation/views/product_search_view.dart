import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origami/features/productsSearch/cubits/productsearch/productsearch_cubit.dart';

class ProductsSearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductsearchCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Products'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: ProductSearchDelegate());
              },
            ),
          ],
        ),
        body: BlocBuilder<ProductsearchCubit, ProductsearchState>(
          builder: (context, state) {
            // Default state, you can show all products or a welcome screen
            return Center(child: Text('Search for products'));
          },
        ),
      ),
    );
  }
}

class ProductSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      context.read<ProductsearchCubit>().searchProducts(query);
    }

    return BlocBuilder<ProductsearchCubit, ProductsearchState>(
      builder: (context, state) {
        if (state is ProductsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ProductsLoaded) {
          if (state.products.isEmpty) {
            return Center(child: Text('No products found'));
          }

          return ListView(
            children: state.products.entries.map((entry) {
              return ExpansionTile(
                title: Text(entry.key), // Category name
                children: entry.value.map((product) {
                  return ListTile(
                    title: Text(product['name']),
                    subtitle: Text('Price: ${product['price']}'),
                  );
                }).toList(),
              );
            }).toList(),
          );
        } else if (state is ProductsError) {
          return Center(child: Text('Error: ${state.message}'));
        }

        return Center(child: Text('Type to search for products'));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }
}
