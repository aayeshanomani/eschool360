import 'package:eschool360/hostel/utils/config.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../utils/utils.dart';
import '../utils/api.dart';
import '../utils/models.dart';

class FoodActivity extends StatefulWidget {
  FoodActivity();

  @override
  State<StatefulWidget> createState() {
    return new FoodActivityState();
  }
}

class FoodActivityState extends State<FoodActivity> {
  bool loading = false;

  String foodDateShow = '';
  DateTime foodDate;

  TextEditingController breakfast = new TextEditingController();
  TextEditingController lunch = new TextEditingController();
  TextEditingController dinner = new TextEditingController();

  FoodActivityState();

  Food food;

  @override
  void initState() {
    super.initState();
    foodDate = new DateTime.now().add(new Duration(days: 1));
    foodDateShow = headingDateFormat.format(foodDate);
    fillData();
  }

  void fillData() {
    print("filldata");
    checkInternet().then((internet) {
      if (internet == null || !internet) {
        oneButtonDialog(context, "No Internet connection", "", true);
        setState(() {
          loading = false;
        });
      } else {
        Future<Foods> data = getFoods(Map.from(
            {'hostel_id': hostelID, 'date': dateFormat.format(foodDate)}));
        data.then((response) {
          if (response != null) {
            if (response.foods != null && response.foods.length > 0) {
              setState(() {
                food = response.foods[0];
                breakfast.text = food.breakfast;
                lunch.text = food.lunch;
                dinner.text = food.dinner;
              });
            }
            if (response.meta != null && response.meta.messageType == "1") {
              oneButtonDialog(context, "", response.meta.message,
                  !(response.meta.status == STATUS_403));
            }
            setState(() {
              loading = false;
            });
          } else {
            new Timer(Duration(milliseconds: random.nextInt(5) * 1000), () {
              setState(() {
                fillData();
              });
            });
          }
        });
      }
    });
  }

  void nextDate() {
    foodDate = foodDate.add(new Duration(days: 1));
    setState(() {
      breakfast.text = '';
      lunch.text = '';
      dinner.text = '';
      foodDateShow = headingDateFormat.format(foodDate);
    });
    fillData();
  }

  void previousDate() {
    foodDate = foodDate.subtract(new Duration(days: 1));
    setState(() {
      breakfast.text = '';
      lunch.text = '';
      dinner.text = '';
      foodDateShow = headingDateFormat.format(foodDate);
    });
    fillData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: new Text(
          "Food",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 4.0,
      ),
      body: ModalProgressHUD(
        child: new Container(
          margin: new EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.1,
              25,
              MediaQuery.of(context).size.width * 0.1,
              0),
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              new GestureDetector(
                onTap: () {},
                child: new Container(
                  height: 50,
                  margin: new EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new IconButton(
                        onPressed: () {
                          previousDate();
                        },
                        icon: new Icon(Icons.arrow_back_ios),
                      ),
                      new Text(
                        foodDateShow,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      new IconButton(
                        onPressed: () {
                          nextDate();
                        },
                        icon: new Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
              ),
              new Container(
                height: 50,
                margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: new Container(
                        child: new TextField(
                          controller: breakfast,
                          maxLines: 1,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: Icon(Icons.local_dining),
                            border: OutlineInputBorder(),
                            labelText: 'Breakfast',
                            hintText: 'Puri, Tea',
                          ),
                          onSubmitted: (String value) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                height: 50,
                margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: new Container(
                        child: new TextField(
                          controller: lunch,
                          maxLines: 1,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: Icon(Icons.local_dining),
                            border: OutlineInputBorder(),
                            labelText: 'Lunch',
                            hintText: 'Dal, Aloo Fry, Rice, Chapati',
                          ),
                          onSubmitted: (String value) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                height: 50,
                margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: new Container(
                        child: new TextField(
                          controller: dinner,
                          maxLines: 1,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: Icon(Icons.local_dining),
                            border: OutlineInputBorder(),
                            labelText: 'Dinner',
                            hintText: 'Sambar, Brinjal Curry, Chapati, Rice',
                          ),
                          onSubmitted: (String value) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                margin: new EdgeInsets.only(top: 50),
                child: new MaterialButton(
                  color: Colors.blue,
                  height: 40,
                  child: new Text(
                    "SAVE",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      loading = true;
                    });

                    checkInternet().then((internet) {
                      if (internet == null || !internet) {
                        oneButtonDialog(
                            context, "No Internet connection", "", true);
                        setState(() {
                          loading = false;
                        });
                      } else {
                        Future<bool> load;
                        if (food != null) {
                          load = update(
                            API.FOOD,
                            Map.from({
                              "breakfast": breakfast.text,
                              "lunch": lunch.text,
                              "dinner": dinner.text,
                            }),
                            Map.from({
                              'hostel_id': hostelID,
                              "date": dateFormat.format(foodDate)
                            }),
                          );
                        } else {
                          load = add(
                            API.FOOD,
                            Map.from({
                              'hostel_id': hostelID,
                              "date": dateFormat.format(foodDate),
                              "breakfast": breakfast.text,
                              "lunch": lunch.text,
                              "dinner": dinner.text,
                            }),
                          );
                        }
                        load.then((onValue) {
                          setState(() {
                            loading = false;
                          });
                        });
                      }
                    });
                  },
                ),
              )
            ],
          ),
        ),
        inAsyncCall: loading,
      ),
    );
  }
}
