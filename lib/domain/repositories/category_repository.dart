import 'package:yandex_school_finance/data/models/category_model.dart';

abstract class CategoryRepository {
  Future<List<CategoryModel>> getCategories();

  Future<List<CategoryModel>> getCategoriesWithType(bool isIncome);
}
