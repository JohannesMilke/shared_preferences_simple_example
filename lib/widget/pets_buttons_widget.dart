import 'package:flutter/material.dart';

class PetsButtonsWidget extends StatelessWidget {
  final List<String> pets;
  final ValueChanged<String> onSelectedPet;

  const PetsButtonsWidget({
    Key key,
    @required this.pets,
    @required this.onSelectedPet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final background = Theme.of(context).unselectedWidgetColor;
    final allPets = ['Dog', 'Cat', 'Other'];

    return Container(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: background,
        ),
        child: ToggleButtons(
          isSelected: allPets.map((pet) => pets.contains(pet)).toList(),
          selectedColor: Colors.white,
          color: Colors.white,
          fillColor: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(10),
          renderBorder: false,
          children: allPets.map(buildPet).toList(),
          onPressed: (index) => onSelectedPet(allPets[index]),
        ),
      ),
    );
  }

  Widget buildPet(String text) => Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Text(text),
      );
}
