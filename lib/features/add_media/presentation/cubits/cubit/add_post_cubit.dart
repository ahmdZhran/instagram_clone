import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/add_media/data/models/media_model.dart';
import 'package:photo_manager/photo_manager.dart';
part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit() : super(AddPostInitial());
  
}
