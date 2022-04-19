import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cashe_helper.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  void changeIndex(int index)
  {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }
  bool isDark = false;
  late bool fromShared;
  void changeAppMode ({ fromShared })
  {
    if(fromShared != null )
    {
      isDark = fromShared;
      emit(NewsAppModeChangeState());
    }
    else
    {
      isDark = !isDark;
      CasheHelper.putBool(key: 'isDark', value: isDark).then((value)
      {
        emit(NewsAppModeChangeState());
      });
    }

  }

}