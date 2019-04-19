import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main(List<String> args) async{
  List data = await getJsonData();
  return runApp(new MaterialApp(
    title: 'Quakes app!',
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text('Quakes app!'),
      ), 
      body: new Center(
        child: new ListView.separated(
          itemCount: data.length,
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () => showDialogInfo(
                context,
                data[index]['last_name'],
                data[index]['first_name'],
                data[index]['avatar'],
                data[index]['city'],
                data[index]['country'],
                data[index]['phone'],
              ),
              title: Text('${data[index]['first_name']} ${data[index]['first_name']}'),
              subtitle: new Text('${data[index]['email']} - ${data[index]['phone']}'),  
              leading: CircleAvatar(
                child: new Image.network('${data[index]['avatar']}'),
                backgroundColor: Colors.transparent,
              ),            
            );
          },
        ),
      ),
    )
  ));
}

void showDialogInfo(BuildContext context, lastname, firstname, avatar, city, country, phone){
  var alert = new AlertDialog(
    title: new Text('$lastname $firstname', style: new TextStyle(fontSize: 24, color: Colors.blueAccent, fontWeight: FontWeight.w600),),
    content: SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          new Image.network('$avatar', width: 50, height: 50),
          new Padding(padding: EdgeInsets.only(top: 50),),
          Text('Country: $country',  style: new TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          Text('City: $city',  style: new TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          Text('Phone: $phone',  style: new TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          
        ],
      ),
    ),
    actions: <Widget>[
      Divider(color: Colors.blueGrey),
      new RaisedButton(
        onPressed: () => Navigator.pop(context),
        child: new Text('Close', style: new TextStyle(color: Colors.white),),
        color: Colors.blueGrey,
      )

    ],
  );
  showDialog(context: context, child: alert);
}

Future<List> getJsonData() async {
  String apiURL= "https://api.mockaroo.com/api/060e5510?count=20&key=0f7280f0";
  http.Response response = await http.get(apiURL);
  return jsonDecode(response.body);
}