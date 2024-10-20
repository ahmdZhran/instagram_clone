
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/auth/domain/entities/user_data_entity.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
}
