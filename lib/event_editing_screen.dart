import 'package:calender/event.dart';
import 'package:calender/event_provider.dart';
import 'package:calender/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventEditingScreen extends StatefulWidget {
  final Event? event;

  const EventEditingScreen(this.event);

  @override
  _EventEditingScreenState createState() => _EventEditingScreenState();
}

class _EventEditingScreenState extends State<EventEditingScreen> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fromDate = DateTime.now();
    toDate = DateTime.now().add(Duration(hours: 2));
  }

  @override
  void dispose() {
    titleController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        actions: buildEdtingActions(),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [buildTitle(), buildDateTimePickers()],
          ),
        ),
      ),
    );
  }

  List<Widget> buildEdtingActions() => [
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                primary: Colors.transparent, shadowColor: Colors.transparent),
            onPressed: saveForm,
            icon: Icon(Icons.done),
            label: Text("Save"))
      ];

  Widget buildTitle() => TextFormField(
        style: TextStyle(fontSize: 24),
        decoration: InputDecoration(
            border: UnderlineInputBorder(), hintText: "Add title"),
        onFieldSubmitted: (_) => saveForm(),
        validator: (title) =>
            title != null && title.isEmpty ? 'Title Can not be empty' : null,
        controller: titleController,
      );

  Widget buildDateTimePickers() => Column(
        children: [
          buildForm(),
          buildTo(),
        ],
      );

  Widget buildForm() => buildHeader(
        header: "From",
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                  text: Utils.toDate(fromDate),
                  onClicked: () => pickFromDatetime(pickdate: true)),
            ),
            Expanded(
              child: buildDropdownField(
                  text: Utils.toTime(fromDate),
                  onClicked: () => pickFromDatetime(pickdate: false)),
            )
          ],
        ),
      );

  Widget buildTo() => buildHeader(
        header: "To",
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                  text: Utils.toDate(toDate),
                  onClicked: () => pickToDatetime(pickdate: true)),
            ),
            Expanded(
              child: buildDropdownField(
                  text: Utils.toTime(toDate),
                  onClicked: () => pickToDatetime(pickdate: false)),
            )
          ],
        ),
      );

  Widget buildDropdownField(
          {required String text, required VoidCallback onClicked}) =>
      ListTile(
        title: Text(text),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Widget buildHeader({required String header, required Widget child}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          child
        ],
      );

  Future pickFromDatetime({required bool pickdate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickdate);
    if (date == null) {
      return;
    }
    if (date.isAfter(toDate)) {
      toDate = DateTime(
          date.year, date.month, date.minute, toDate.hour, toDate.minute);
    }
    setState(() {
      fromDate = date;
    });
  }

  Future pickToDatetime({required bool pickdate}) async {
    final date = await pickDateTime(toDate,
        pickDate: pickdate, firstDate: pickdate ? fromDate : null);
    if (date == null) {
      return;
    }
    // if (date.isAfter(toDate)) {
    //   toDate = DateTime(
    //       date.year, date.month, date.minute, toDate.hour, toDate.minute);
    // }
    setState(() {
      toDate = date;
    });
  }

  Future<DateTime?> pickDateTime(
    DateTime intialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: intialDate,
        firstDate: firstDate ?? DateTime(2015, 8),
        lastDate: DateTime(2101),
      );

      if (date == null) return null;
      final time = Duration(hours: intialDate.hour, minutes: intialDate.minute);
      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(intialDate));

      if (timeOfDay == null) return null;

      final date = DateTime(
        intialDate.year,
        intialDate.month,
        intialDate.day,
      );
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }

  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final event = Event(
          title: titleController.text,
          description: "description here",
          from: fromDate,
          to: toDate,
          isAllDay: false);

      final provider = Provider.of<EventProvider>(context, listen: false);
      provider.addEvents(event);
      Navigator.of(context).pop();
    }
  }
}
