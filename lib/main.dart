import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cashe_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:news_app/shared/styles/themes.dart';
import 'shared/cubit/cubit.dart';

void main() async
{
  BlocOverrides.runZoned( () async
  {
    WidgetsFlutterBinding.ensureInitialized();
    DioHelper.init();
    await CasheHelper.init();
    bool isDark = await CasheHelper.getData(key:'isDark');
    runApp(MyApp(
      isDark : isDark
    ));

  },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  const MyApp({
    this.isDark,
  });
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (BuildContext context)=> NewsCubit()..getSports()..getBusiness()..getScience()),
        BlocProvider(create: (BuildContext context)=> AppCubit()..changeAppMode(fromShared: isDark)),
      ],
      child: BlocConsumer< AppCubit, AppStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: const NewsLayout(),
          );
        },
      ),

    );
  }
}
