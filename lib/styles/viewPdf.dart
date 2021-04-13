import 'package:eschool360/loading.dart';
import 'package:eschool360/styles/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class Viewpdf extends StatefulWidget {
  @override
  _ViewpdfState createState() => _ViewpdfState();
}

class _ViewpdfState extends State<Viewpdf> {
  PDFDocument pdf;
  showAlertDialog(context, String message) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/wrapper', (route) => false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Message"),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    String data = ModalRoute.of(context).settings.arguments;
    print(data);
    ViewNow() async {
      try {
        pdf = await PDFDocument.fromURL(data);
      } catch (e) {
        showAlertDialog(context, 'Error in Opening the PDF');
      }

      setState(() {});
    }

    Widget loadPdf() {
      ViewNow();
      if (pdf == null) {
        return Loading();
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bluecolor,
        title: Text('Homework'),
      ),
      body: pdf == null ? loadPdf() : PDFViewer(document: pdf),
    );
  }
}
