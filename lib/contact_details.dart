import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'contact_list_model.dart';

class ContactDetails extends StatefulWidget {
  const ContactDetails({Key? key, required this.name}) : super(key: key);
  final ContactListModel name;

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
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
        automaticallyImplyLeading: true,
        title: Text(widget.name.name ?? ''),
      ),
      body: Column(
        children: [
          CircleAvatar(
            radius: 60,
            child: Text(
              widget.name.name?.substring(0, 1).toUpperCase() ?? '',
              style: TextStyle(fontSize: 40),
            ),
          ),
          Text(
            widget.name.name ?? '',
            style: TextStyle(fontSize: 25),
          ),
          Row(
            children: [
              Text(widget.name.mobile ?? ''),
              SizedBox(width: 10,),
              GestureDetector(
                onTap: () {
                  _makeSms(widget.name.mobile ?? '');
                },
                child: CircleAvatar(
                  child: Icon(
                    Icons.message,
                    size: 20.0,
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  _makePhoneCall(widget.name.mobile ?? '');
                },
                child: CircleAvatar(
                  child: Icon(
                    Icons.call,
                    size: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
