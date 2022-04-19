import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view.dart';
Widget defaultFormField (
{
  required String label,
  required TextEditingController controller,
  TextInputType? type,
  required IconData prefix,
  IconData? suffix,
  bool isPasword = false,
  required final String? Function (String? value)? validate,
  final void Function (String? value)? onSubmit,
  final void Function (String? value)? onChange,
  VoidCallback? suffixPressed,
  VoidCallback? onTap,
}
    )=> TextFormField(
  controller: controller ,
  keyboardType: type,
  obscureText: isPasword,
  decoration: InputDecoration(
    labelText: label,
    border: const OutlineInputBorder(),
    prefixIcon: Icon(prefix),
    suffixIcon: suffix != null ? IconButton(
        icon : Icon(suffix),
        onPressed : suffixPressed ): null

  ),
  validator: validate,
  onTap: onTap,
  onFieldSubmitted: onSubmit,
  onChanged: onChange
);

Widget buildArticleItem (article,context)=> InkWell(
  onTap: ()
  {
    navigateTo(context, WebViewScreen(article['url']));
  },
  child: Padding(
    padding: const EdgeInsets.all(14),
    child: Row(
      children:
      [
        Container(
          width: 120,
          height: 85,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage('${article['urlToImage']}'),
                fit: BoxFit.cover,
              )
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Container(
            height: 85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children:
              [
                 Expanded(
                   child: Text('${article['title']}',
                     style: Theme.of(context).textTheme.bodyText1,
                     maxLines: 3,
                     overflow: TextOverflow.ellipsis,
                     textDirection: TextDirection.rtl,
                   ),
                 ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text('${article['publishedAt']}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  ),
);

Widget dividerBuilder()=>Container(
  color: Colors.grey[300],
  height: 1,
  width: double.infinity,
);
Widget articleBuilder(list,context,{ isSearch = false }) => ConditionalBuilderRec(
  condition: list.isNotEmpty,
  builder: (context)=> ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context,index)=> buildArticleItem(list[index],context),
      separatorBuilder: (context,index)=> dividerBuilder(),
      itemCount: list.length
  ),
  fallback: (context)=> isSearch ? Container() : const Center(child: CircularProgressIndicator()),
);
void navigateTo(context,widget) => Navigator.push(context,
    MaterialPageRoute( builder:(context) => widget)
);




