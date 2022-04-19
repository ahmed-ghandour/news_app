import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController() ;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: defaultFormField(
                    label: 'Search',
                    controller: searchController,
                    type: TextInputType.text,
                    prefix: Icons.search,
                    onChange: (value)
                    {
                      NewsCubit.get(context).getSearch(value);
                    },
                    validate: (String? value)
                    {
                      if (value == null || value.isEmpty)
                        {
                          return ' enter something to search';
                        }
                      else
                        {
                        return null ;
                        }
                    }
                ),
              ),
              Expanded(child: articleBuilder(list, context,isSearch: true))
            ],
          ),

        );
      },

    );
  }
}
