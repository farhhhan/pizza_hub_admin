import 'dart:async';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_hut_admin/bloc/image_bloc/repos.dart';


part 'img_bloc_event.dart';
part 'img_bloc_state.dart';

class ImgBlocBloc extends Bloc<ImgBlocEvent, ImgBlocState> {
  final ImagePickerServices imagePickUtils;
  ImgBlocBloc(this.imagePickUtils) : super(ImgBlocState()) {
    on<gellaryPickerEvent>(_imageFromGellary);
    on<SaveEvent>(_saveEvent);
  }

  FutureOr<void> _imageFromGellary(
      gellaryPickerEvent event, Emitter<ImgBlocState> emit) async {
    Uint8List? file = await imagePickUtils.getimageFromGellary();
    List<Uint8List> list = [];
    list.add(file!);
    emit(state.copyWith(file: list));
  }

  
  FutureOr<void> _saveEvent(SaveEvent event, Emitter<ImgBlocState> emit) {
    emit(state.copyWith(file: []));
  }
}
