import 'package:being_u/common.dart';
import 'package:being_u/common_widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

class AddActivity extends StatefulWidget {
  const AddActivity({Key? key}) : super(key: key);

  @override
  State<AddActivity> createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  TextEditingController? _taskName, _taskDescription, _taskReference;
  int _selectedIndex = 0;
  String tod = "morning";
  bool isInstructionSeen = false;
  bool isError = false;
  bool isLoading = true;
  bool isShowNameSelected = true;

  void initializer() async {
    SharedPreferences instructionSeen = await SharedPreferences.getInstance();
    if (instructionSeen.getBool("seen") == true) {
      setState(() {
        isInstructionSeen = true;
        isLoading = false;
      });
    } else {
      setState(() {
        isInstructionSeen = false;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializer();
    _taskName = new TextEditingController();
    _taskDescription = new TextEditingController();
    _taskReference = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading ? Center(
          child: UniversalPlatform.isIOS ?
          CupertinoActivityIndicator() : CircularProgressIndicator(),
        ) : isInstructionSeen ? _form() : _instruction(),
      ),
    );
  }

  Widget _instruction() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/blogging.png",
              height: 200, width: 200,),
            SizedBox(height: 10,),
            SizedBox(
              width: MediaQuery.of(context).size.width * .75,
              child:
              Text("Have a routine you follow to keep yourself motivated?",
                style: Theme.of(context).textTheme.bodyText1,),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .75,
              child: Text(
                "We are giving you the ability to share it with other users of"
                    " the application",
                style: Theme.of(context).textTheme.bodyText1,),
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              visible: !UniversalPlatform.isIOS,
              child: ElevatedButton(
                onPressed: () async {
                  SharedPreferences instructionSeen =
                  await SharedPreferences.getInstance();
                  instructionSeen.setBool("seen", true);
                  setState(() {
                    isInstructionSeen = true;
                  });
                },
                child: Text("Continue"),
              ),
            ),
            Visibility(
              visible: UniversalPlatform.isIOS,
              child: CupertinoButton(
                onPressed: () async {
                  SharedPreferences instructionSeen =
                  await SharedPreferences.getInstance();
                  instructionSeen.setBool("seen", true);
                  setState(() {
                    isInstructionSeen = true;
                  });
                },
                child: Text("Continue"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _form() {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.all(20),
      children: [
        CustomTextField(_taskName!, "Task Name", "", "", false,
            TextInputType.text, false, false),
        SizedBox(
          height: 10,
        ),
        CustomTextField(
            _taskDescription!,
            "Task Description",
            "Instruction on how to perform the task",
            "",
            false,
            TextInputType.text,
            false,
            true),
        SizedBox(
          height: 10,
        ),
        CustomTextField(_taskReference!, "Reference", "Link to tutorial", "",
            false, TextInputType.url, false, false),
        SizedBox(
          height: 10,
        ),
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 5,
          runSpacing: 5,
          children: [
            ChoiceChip(
              onSelected: (bool value) {
                if (value) {
                  setState(() {
                    _selectedIndex = 0;
                    tod = "morning";
                  });
                } else {
                  setState(() {
                    _selectedIndex = 0;
                    tod = "morning";
                  });
                }
              },
              selectedColor: Color.fromRGBO(0, 128, 128, 1),
              selected: _selectedIndex == 0,
              label: Text("Morning"),
              labelStyle: TextStyle(
                  color: _selectedIndex == 2 ? Colors.white : Colors.white),
            ),
            ChoiceChip(
              onSelected: (bool value) {
                if (value) {
                  setState(() {
                    _selectedIndex = 1;
                    tod = "afternoon";
                  });
                } else {
                  setState(() {
                    _selectedIndex = 0;
                    tod = "morning";
                  });
                }
              },
              selectedColor: Color.fromRGBO(0, 128, 128, 1),
              selected: _selectedIndex == 1,
              label: Text(
                "Afternoon",
              ),
              labelStyle: TextStyle(
                  color: _selectedIndex == 2 ? Colors.white : Colors.white),
            ),
            ChoiceChip(
              onSelected: (bool value) {
                if (value) {
                  setState(() {
                    _selectedIndex = 2;
                    tod = "evening";
                  });
                } else {
                  setState(() {
                    _selectedIndex = 0;
                    tod = "morning";
                  });
                }
              },
              selectedColor: Color.fromRGBO(0, 128, 128, 1),
              selected: _selectedIndex == 2,
              label: Text(
                "Evening",
              ),
              labelStyle: TextStyle(
                  color: _selectedIndex == 2 ? Colors.white : Colors.white),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Text("Display your name?"),
        SizedBox(height: 10,),
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 5,
          runSpacing: 5,
          children: [
            ChoiceChip(
              onSelected: (bool value) {
                if (value) {
                  setState(() {
                    isShowNameSelected = value;
                  });
                }
              },
              selectedColor: Color.fromRGBO(0, 128, 128, 1),
              selected: isShowNameSelected,
              label: Text("Yes"),
              labelStyle: TextStyle(
                  color: isShowNameSelected ? Colors.white : Colors.white),
            ),
            ChoiceChip(
              onSelected: (bool value) {
                if (value) {
                  setState(() {
                    isShowNameSelected = !value;
                  });
                }
              },
              selectedColor: Color.fromRGBO(0, 128, 128, 1),
              selected: !isShowNameSelected,
              label: Text("No"),
              labelStyle: TextStyle(
                  color: !isShowNameSelected ? Colors.white : Colors.white),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Visibility(
          visible: isError,
          child: Text("Name and Description cannot be empty",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
        ),
        SizedBox(height: 10,),
        Visibility(
          visible: !UniversalPlatform.isIOS,
          child: ElevatedButton(
            onPressed: (){
              submitFunc();
              final snackBar = SnackBar(
                content: isError ? Text("Name and Description are required",
                  style: TextStyle(color: Colors.white),)
                    : Text("Success"),
                backgroundColor: isError ? Colors.red : Colors.white,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: Text("Post"),
          ),
        ),
        Visibility(
          visible: UniversalPlatform.isIOS,
          child: CupertinoButton(
            onPressed: (){
              submitFunc();
              final snackBar = SnackBar(
                content: isError ? Text("Name and Description are required",
                    style: TextStyle(color: Colors.white))
                    : Text("Success"),
                backgroundColor: isError ? Colors.red : Colors.white,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: Text("Post"),
            color: Color.fromRGBO(0, 128, 128, 1),
          ),
        ),
      ],
    );
  }

  void submitFunc() {
    if(_taskName!.text.isEmpty || _taskDescription!.text.toString().isEmpty){
      setState(() {
        isError = true;
      });
    }
    else{
      fStore.collection("content").add({
        "detail": _taskDescription!.text,
        "imgAsset": "",
        "reference": _taskReference!.text,
        "timeOfDay": tod,
        "title": _taskName!.text,
        "uid": user?.uid,
        "name": user?.displayName,
        "displayName": isShowNameSelected,
      }).whenComplete(() => {
        _taskName?.clear(),
        _taskReference?.clear(),
        _taskDescription?.clear(),
      });
    }
  }
}