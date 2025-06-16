import 'package:yandex_school_finance/data/models/category_model.dart';
import 'package:yandex_school_finance/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final List<Map<String, Object?>> categories = [
    {"id": 1, "name": "Зарплата", "emoji": "💰", "isIncome": true},
    {"id": 2, "name": "Обучение", "emoji": "📚", "isIncome": false},
    {"id": 3, "name": "Дары", "emoji": "🎁", "isIncome": true},
    {"id": 4, "name": "Траты на Дом", "emoji": "🏠", "isIncome": false},
  ];

  @override
  Future<List<CategoryModel>> getCategories() async {
    await Future.delayed(Duration(seconds: 1));

    return categories
        .map((category) => CategoryModel.fromJson(category))
        .toList();
  }

  @override
  Future<List<CategoryModel>> getCategoriesWithType(bool isIncome) async {
    await Future.delayed(Duration(seconds: 1));

    return categories
        .where((category) => category["isIncome"] == isIncome)
        .map((category) => CategoryModel.fromJson(category))
        .toList();
  }
}
