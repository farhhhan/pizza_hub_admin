part of 'img_bloc_bloc.dart';

sealed class ImgBlocEvent extends Equatable {
  const ImgBlocEvent();

  @override
  List<Object> get props => [];
}
class gellaryPickerEvent extends ImgBlocEvent{}
class SaveEvent extends ImgBlocEvent{}