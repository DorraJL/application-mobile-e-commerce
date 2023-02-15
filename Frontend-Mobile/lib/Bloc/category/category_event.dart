part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class OnAddNewSubCategoryEvent extends CategoryEvent {
  final String nameSubCategory;
  final String idCategory;

  OnAddNewSubCategoryEvent(this.nameSubCategory, this.idCategory);
}

class OnAddNewCategoryEvent extends CategoryEvent {
  final String nameCategory;

  OnAddNewCategoryEvent(this.nameCategory);
}

class OnEditCategoryEvent extends CategoryEvent {
  final String nameCategory;
  final String idCategory;

  OnEditCategoryEvent(this.nameCategory, this.idCategory);
}

class OnEditSubCategoryEvent extends CategoryEvent {
  final String uidsubCategory;
  final String nameSubCategory;

  OnEditSubCategoryEvent(this.uidsubCategory, this.nameSubCategory);
}

class OnSelectUidCategoryEvent extends CategoryEvent {
  final int uidCategory;
  final String category;

  OnSelectUidCategoryEvent(this.uidCategory, this.category);
}
class OnSelectUidSubCategoryEvent extends CategoryEvent {
  final int uidSubCategory;
  final String Subcategory;

  OnSelectUidSubCategoryEvent(this.uidSubCategory, this.Subcategory);
}

class OnDeleteCategoryEvent extends CategoryEvent {
  final String uidCategory;

  OnDeleteCategoryEvent(this.uidCategory);
}

class OnDeleteSubCategoryEvent extends CategoryEvent {
  final String uidCategory;

  OnDeleteSubCategoryEvent(this.uidCategory);
}
