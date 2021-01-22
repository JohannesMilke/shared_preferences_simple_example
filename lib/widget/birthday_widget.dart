import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BirthdayWidget extends StatefulWidget {
  final DateTime birthday;
  final ValueChanged<DateTime> onChangedBirthday;

  const BirthdayWidget({
    Key key,
    @required this.birthday,
    @required this.onChangedBirthday,
  }) : super(key: key);

  @override
  _BirthdayWidgetState createState() => _BirthdayWidgetState();
}

class _BirthdayWidgetState extends State<BirthdayWidget> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    setDate();
  }

  @override
  void didUpdateWidget(covariant BirthdayWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    setDate();
  }

  void setDate() => setState(() {
        controller.text = widget.birthday == null
            ? ''
            : DateFormat.yMd().format(widget.birthday);
      });

  @override
  Widget build(BuildContext context) => FocusBuilder(
        onChangeVisibility: (isVisible) {
          if (isVisible) {
            selectDate(context);
            //
          } else {
            FocusScope.of(context).requestFocus(FocusNode());
          }
        },
        focusNode: focusNode,
        builder: (hasFocus) => TextFormField(
          controller: controller,
          validator: (value) => value.isEmpty ? 'Is Required' : null,
          decoration: InputDecoration(
            prefixText: ' ',
            hintText: 'Your birthday',
            prefixIcon: Icon(Icons.calendar_today_rounded),
            border: OutlineInputBorder(),
          ),
        ),
      );

  Future selectDate(BuildContext context) async {
    final birthday = await showDatePicker(
      context: context,
      initialDate: widget.birthday ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (birthday == null) return;

    widget.onChangedBirthday(birthday);
  }
}

class FocusBuilder extends StatefulWidget {
  final FocusNode focusNode;
  final Widget Function(bool hasFocus) builder;
  final ValueChanged<bool> onChangeVisibility;

  const FocusBuilder({
    @required this.focusNode,
    @required this.builder,
    @required this.onChangeVisibility,
    Key key,
  }) : super(key: key);

  @override
  _FocusBuilderState createState() => _FocusBuilderState();
}

class _FocusBuilderState extends State<FocusBuilder> {
  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => widget.onChangeVisibility(true),
        child: Focus(
          focusNode: widget.focusNode,
          onFocusChange: widget.onChangeVisibility,
          child: widget.builder(widget.focusNode.hasFocus),
        ),
      );
}
