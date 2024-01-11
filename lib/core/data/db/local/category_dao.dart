import 'package:floor/floor.dart';
import 'package:mashgh/core/data/entities/category_entity.dart';

@dao
abstract class CategoryDao {
  @Query('''
SELECT c.id,c.name,c.nameFa,c.color,c.icon,COUNT(w.id) as worksheetsCount
FROM category c
LEFT JOIN worksheet w on c.id = w.categoryId 
GROUP BY c.id
''')
  Future<List<CategoryEntity>> getAllCategory();

  @Query('SELECT * FROM category WHERE name = :name')
  Future<CategoryEntity?> findCategoryByName(String name);

  @insert
  Future<void> insertCategory(
    CategoryEntity categoryEntity,
  );

  @update
  Future<void> updateCategory(
    CategoryEntity categoryEntity,
  );

//   @Query('''
// DELETE FROM worksheet WHERE categoryId = :id;
// DELETE FROM category WHERE id = :id;
// ''')
//   Future<void> deleteCategoryById(int id);

  // @override
  // @transaction
  // Future<CategoryEntity?> deleteCategoryById(int id) async {
  //   await _queryAdapter.queryNoReturn(
  //     'DELETE FROM worksheet WHERE categoryId = ?1',
  //     arguments: [id],
  //   );

  //   await _queryAdapter.queryNoReturn(
  //     'DELETE FROM category WHERE id = ?1',
  //     arguments: [id],
  //   );

  //   return null;
  // }

  @Query('DELETE FROM worksheet WHERE categoryId = :id')
  Future<void> deleteFromWorksheet(int id);

  @Query('DELETE FROM category WHERE id = :id')
  Future<void> deleteFromCategory(int id);

  @transaction
  Future<void> deleteCategoryById(int id) async {
    await deleteFromWorksheet(id);
    await deleteFromCategory(id);
  }

  /// delete all rows
  @Query('DELETE FROM category')
  Future<void> deleteAllCategory();
}
