import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science.dart';
import 'package:news_app/modules/sports/sports.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';


class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super (NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List <BottomNavigationBarItem> bottomItems =
  [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',

    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',

    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',

    ),
  ] ;
  List <Widget> screens =
  [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];
  void changeBottomNavbar (int index)
  {
    currentIndex = index;
    emit(NewsBottomNavState());
  }
  List<dynamic>sports = [];
  void getSports ()
  {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
        url: '/v2/top-headlines',
        query :
        {
          'country' : 'eg',
          'category':'sports',
          'apiKey' : 'f5e2fdff5ed4431291d70648074f177c',
        }).then((value){
      sports = value.data['articles'];
      emit(NewsGetSportsSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(NewsGetSportsErrorState(onError.toString()));
    });
  }

  List<dynamic>business = [];
  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url: '/v2/top-headlines',
        query :
        {
          'country' : 'eg',
          'category':'business',
          'apiKey' : 'f5e2fdff5ed4431291d70648074f177c',
        }).then((value){
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(NewsGetBusinessErrorState(onError.toString()));
    });
  }
  List<dynamic>science = [];
  void getScience ()
  {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
        url: '/v2/top-headlines',
        query :
        {
          'country' : 'eg',
          'category':'science',
          'apiKey' : 'f5e2fdff5ed4431291d70648074f177c',
        }).then((value){
      science = value.data['articles'];
      emit(NewsGetScienceSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(NewsGetScienceErrorState(onError.toString()));
    });
  }
  List<dynamic> search= [];
  void getSearch(value)
  {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url: '/v2/everything',
        query :
        {
          'q' : '$value',
          'apiKey' : 'f5e2fdff5ed4431291d70648074f177c',
        }).then((value){
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
      print(search[0]['title']);
    }).catchError((onError){
      print(onError.toString());
      emit(NewsGetSearchErrorState(onError.toString()));
    });
  }

}