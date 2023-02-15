import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../Service/ProductController.dart';
part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<OnSelectUidCategoryEvent>(_selectUidCategory);
      on<OnSelectUidSubCategoryEvent>(_selectUidSubCategory);
    on<OnAddNewCategoryEvent>(_onAddNewCategory);
    on<OnAddNewSubCategoryEvent>(_onAddNewSubCategory);
    on<OnDeleteCategoryEvent>(_onDeleteCategory);
    on<OnDeleteSubCategoryEvent>(_onDeleteSubCategory);
    on<OnEditCategoryEvent>(_onEditCategory);
     on<OnEditSubCategoryEvent>(_onEditSubCategory);
  }
  Future<void> _onEditCategory(
      OnEditCategoryEvent event, Emitter<CategoryState> emit) async {
    try {
      emit(LoadingCategoryState());

      final data = await productServices.editCategory(
          event.nameCategory, event.idCategory);

      if (data.resp) {
        emit(SuccessCategoryState());
      } else {
        emit(FailureCategoryState(data.message));
      }
    } catch (e) {
      emit(FailureCategoryState(e.toString()));
    }
  }
  Future<void> _onEditSubCategory(
      OnEditSubCategoryEvent event, Emitter<CategoryState> emit) async {
    try {
      emit(LoadingCategoryState());

      final data = await productServices.editSubCategory(
         event.uidsubCategory, event.nameSubCategory);

      if (data.resp) {
        emit(SuccessCategoryState());
      } else {
        emit(FailureCategoryState(data.message));
      }
    } catch (e) {
      emit(FailureCategoryState(e.toString()));
    }
  }

  Future<void> _onAddNewSubCategory(
      OnAddNewSubCategoryEvent event, Emitter<CategoryState> emit) async {
    try {
      emit(LoadingCategoryState());

      final data = await productServices.addNewSubCategory(
          event.nameSubCategory, event.idCategory);

      if (data.resp)
        emit(SuccessCategoryState());
      else
        emit(FailureCategoryState(data.message));
    } catch (e) {
      emit(FailureCategoryState(e.toString()));
    }
  }

  Future<void> _onAddNewCategory(
      OnAddNewCategoryEvent event, Emitter<CategoryState> emit) async {
    try {
      emit(LoadingCategoryState());

      final data = await productServices.addNewCategory(event.nameCategory);

      if (data.resp)
        emit(SuccessCategoryState());
      else
        emit(FailureCategoryState(data.message));
    } catch (e) {
      emit(FailureCategoryState(e.toString()));
    }
  }

  Future<void> _onDeleteCategory(
      OnDeleteCategoryEvent event, Emitter<CategoryState> emit) async {
    try {
      emit(LoadingCategoryState());

      final data = await productServices.deleteCategory(event.uidCategory);

      await Future.delayed(Duration(seconds: 1));

      if (data.resp)
        emit(SuccessCategoryState());
      else
        emit(FailureCategoryState(data.message));
    } catch (e) {
      emit(FailureCategoryState(e.toString()));
    }
  }

  Future<void> _onDeleteSubCategory(
      OnDeleteSubCategoryEvent event, Emitter<CategoryState> emit) async {
    try {
      emit(LoadingCategoryState());

      final data = await productServices.deleteSubCategory(event.uidCategory);

      await Future.delayed(Duration(seconds: 1));

      if (data.resp)
        emit(SuccessCategoryState());
      else
        emit(FailureCategoryState(data.message));
    } catch (e) {
      emit(FailureCategoryState(e.toString()));
    }
  }

  Future<void> _selectUidCategory(
      OnSelectUidCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(SetSelectCategoryState(event.uidCategory, event.category));
  }
   Future<void> _selectUidSubCategory(
      OnSelectUidSubCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(SetSelectCategoryState(event.uidSubCategory, event.Subcategory));
  }
}
