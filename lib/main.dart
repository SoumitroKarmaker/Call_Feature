import 'package:flutter/material.dart';
import 'package:untitled/contact_details.dart';
import 'package:untitled/contact_list_model.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Gridview',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _makeSms(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );

    await launchUrl(launchUri);
    print('Data');
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Contacts'),
        ),
        body: ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (_, index) {
              return ListTile(
                contentPadding: EdgeInsets.all(4.0),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ContactDetails(name: contacts[index]))),
                leading: CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.indigoAccent,
                  child: Text(
                    contacts[index].name?.substring(0, 1).toUpperCase() ?? '',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(
                  contacts[index].name ?? '',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  contacts[index].mobile ?? '',
                  style: TextStyle(color: Colors.grey, fontSize: 18.0),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () => _makePhoneCall(contacts[index].mobile!),
                      child: CircleAvatar(
                          child: Icon(
                        Icons.call,
                        size: 20.0,
                      )),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    GestureDetector(
                      onTap: () => _makeSms(contacts[index].mobile!),
                      child: CircleAvatar(
                          child: Icon(
                        Icons.sms,
                        size: 20.0,
                      )),
                    )
                  ],
                ),
              );
            }));
  }
}
