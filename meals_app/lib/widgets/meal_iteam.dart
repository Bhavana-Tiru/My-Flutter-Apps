import 'package:flutter/material.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectedImg});

  final Meal meal;
  final void Function(Meal meal) onSelectedImg;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
    //The substring of this string from [start], inclusive, to [end], exclusive.
    // Example:
    // const string = 'dartlang';
    // var result = string.substring(1); // 'artlang'
    // result = string.substring(1, 4); // 'art'
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      //Clip.hardEdge:this simply clips this widget, removing any content of child widgets
      // that would go outside of the shape boundaries of this Card widget.
      child: InkWell(
        onTap: () {
          onSelectedImg(meal);
        },
        // child: const Stack(),
        //Stack():- the non-positioned children of the stack are aligned by their top left corners.
        //this is a widget that can be used to position multiple widgets above each other,
        //they are rendered, directly above each other along the Z-axis.
        // Example we can have a img on back have  txt on top of it.

        child: Stack(
          children: [
            //Hero is used to animate widgets across different widgets.
            Hero(
              tag: meal.id,
              // will be used for identifying a widget on this screen and on the target screen.
              //It should be a tag that is unique per widget.

              //It should be given again in steps.dart sam by wraping up
              //the Image with Hero and initializing tag with same meal.id
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            // FadeInImage():Creates a widget that displays a [placeholder] while an [image] is loading,
            //then fades-out the placeholder and fades-in the image.
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              // this Container should end 50pixels before this img here ends to the right.
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      // Very long text...(adds three dots)
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      width: 12,
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: meal.duration.toString() + "min",
                        ), // for label : '${meal.duration} min'
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(
                          icon: Icons.work,
                          label: '$complexityText min',
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
