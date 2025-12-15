import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/plant_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final PlantRepository repository;

  SearchCubit(this.repository) : super(SearchInitial());

  Future<void> searchPlants(String query) async {
    try {
      emit(SearchLoading());
      print(query);
      final results = await repository.searchPlant(query);
      print(results);
      emit(SearchSuccess(results));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

}

