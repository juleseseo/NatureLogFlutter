import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nature_log_flutter/ui/screens/plant_details.dart';

import '../../cubits/search_cubit.dart';

class SearchPlantsScreen extends StatefulWidget {
    const SearchPlantsScreen({super.key});
    @override
    State<SearchPlantsScreen> createState() => _SearchPlantsScreenState();
}
class _SearchPlantsScreenState extends State<SearchPlantsScreen> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.lightGreen[50],
            appBar: AppBar(
                title: const Text('Rechercher une plante'),
                backgroundColor: Color(0xFF628A67),
                centerTitle: true,
                elevation: 0,
            ),
            body: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                    return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                            children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                            BoxShadow(
                                                color: Colors.green.withOpacity(0.3),
                                                blurRadius: 10,
                                                offset: const Offset(0, 5),
                                            ),
                                        ],
                                    ),
                                    child: TextField(
                                        decoration: InputDecoration(
                                            hintText: 'Rechercher une plante...',
                                            hintStyle: TextStyle(color: Colors.grey[400]),
                                            prefixIcon: const Icon(Icons.search, color: Color(0xFF628A67)),
                                            suffixIcon: IconButton(
                                                icon: const Icon(Icons.clear, color: Colors.grey),
                                                onPressed: () {},
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30),
                                                borderSide: BorderSide.none,
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                        ),
                                        onChanged: (value) {
                                            if (value.length > 2) {
                                                context.read<SearchCubit>().searchPlants(value);
                                            }
                                        },
                                    ),
                                ),
                                const SizedBox(height: 10),
                                Expanded(
                                    child: _buildContent(state),
                                ),
                            ],
                        ),
                    );
                },
            ),
        );
    }

    Widget _buildContent(SearchState state) {
        if (state is SearchLoading) {
            return Center(
                child: CircularProgressIndicator(color: Color(0xFF628A67)),
            );
        } else if (state is SearchSuccess) {
            return ListView.builder(
                itemCount: state.results.length,
                itemBuilder: (context, index) {
                    final plant = state.results[index];
                    print(plant);
                    return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            title: Text(
                                plant['name'] ?? 'Inconnu',
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                ),
                            ),
                            leading: plant['url'] != null && plant['url']!.isNotEmpty
                                ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                    plant['url']!,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                ),
                            )
                                : const Icon(Icons.local_florist, color: Color(0xFF628A67)),
                            trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF628A67), size: 18),
                            onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PlantDetailsScreen(plant: plant),
                                    ),
                                );
                            },
                        ),
                    );

                },
            );
        } else if (state is SearchError) {
            return Center(
                child: Text(
                    state.message,
                    style: TextStyle(color: Colors.red[700]),
                ),
            );
        }

        return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Icon(
                        Icons.local_florist,
                        size: 80,
                        color: Color(0xFF628A67),
                    ),
                    const SizedBox(height: 20),
                    Text(
                        'Recherchez une plante',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF628A67),
                            fontWeight: FontWeight.w500,
                        ),
                    ),
                ],
            ),
        );
    }
}
