import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:yandex_school_finance/data/models/category_model.dart';
import 'package:yandex_school_finance/domain/repositories/category_repository.dart';

class CategoriesCubit extends Cubit<CategoriesStateUI> {
  CategoriesCubit(this.categoryRepository) : super(InitialState());

  final CategoryRepository categoryRepository;
  Map<String, CategoryModel>? _categories;

  void loadCategories() async {
    emit(LoadingState());

    final failOrCategories = await categoryRepository.getCategories();
    failOrCategories.fold((fail) => emit(ErrorState(message: fail.message)), (
      categories,
    ) {
      _categories = {for (var el in categories) el.name: el};
      emit(LoadedState(categories: categories));
    });
  }

  void fuzzySearch(String query) {
    if (_categories == null) {
      return emit(ErrorState(message: "Нет таких категорий"));
    }

    final fuse = Fuzzy(_categories!.keys.toList());
    final result = fuse.search(query);

    emit(
      LoadedState(
        categories: result.map((el) => _categories![el.item]!).toList(),
      ),
    );
  }
}

sealed class CategoriesStateUI {}

class InitialState extends CategoriesStateUI {}

class LoadingState extends CategoriesStateUI {}

class LoadedState extends CategoriesStateUI {
  final List<CategoryModel> categories;

  LoadedState({required this.categories});
}

class ErrorState extends CategoriesStateUI {
  final String message;

  ErrorState({required this.message});
}
