import 'package:yandex_school_finance/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:yandex_school_finance/data/models/freezed_models/category_model.dart';
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
      _categories = {for (var el in categories.response) el.name: el};
      emit(LoadedState(categories: categories.response));
    });
  }

  void fuzzySearch(String query) {
    if (_categories == null) {
      return emit(
        ErrorState(
          message: (context) => AppLocalizations.of(context).no_such_categories,
        ),
      );
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
  final String Function(BuildContext context) message;

  ErrorState({required this.message});
}
