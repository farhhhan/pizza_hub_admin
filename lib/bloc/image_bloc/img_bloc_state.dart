part of 'img_bloc_bloc.dart';

 class ImgBlocState extends Equatable {
 const  ImgBlocState({ this.file});
  final List<Uint8List>? file;
  ImgBlocState copyWith({List<Uint8List>? file}){
    return  ImgBlocState(file: file ?? this.file);
  }
  @override
  List<Object?> get props => [file];
}

