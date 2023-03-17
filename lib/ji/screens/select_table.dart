import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../api.dart';
import '../components.dart';
import '../globals.dart';
import '../styles.dart';
import 'restauration.dart';

class SelectTable extends StatefulWidget {
  const SelectTable({key});

  @override
  State<SelectTable> createState() => _SelectTableState();
}

class _SelectTableState extends State<SelectTable> {

  @override
  void initState() {
    super.initState();

    Api.getTables().then((value) {
      setState(() {
        _listTable = value;
      });
    });
  }
  List<String> _listTable = [];

  selectThisTable(String table) {
    gblTable = table;
    showSuccess("table $table selectionnée");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StartOrder()),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listTableWid = [];
    for (var table in _listTable) {
      listTableWid.add(InkWell(
        onTap: () {
          selectThisTable(table);
        },
        child: Container(
          margin: screenMargin,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(table, style: minLabelStyle),
              ]),
              const Icon(Icons.arrow_forward_ios_outlined)
            ],
          ),
        ),
      ));
    }
    return Scaffold(
      appBar: closeNavBar(context, "", kPrimaryColor),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                color: kPrimaryColor.withOpacity(0.2),
                height: gblSize.height,
                child: SingleChildScrollView(
                    child: Column(
                  children: listTableWid,
                ))),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: RectBtn(
                label: const Text('SCANNER LE QR CODE',
                    style: primaryButtonTextStyle),
                bgColor: Colors.black,
                press: () async {
                  String barcodeScanRes =
                      await FlutterBarcodeScanner.scanBarcode(
                          "#000000", "RETOUR", false, ScanMode.QR);
                  if (barcodeScanRes != '-1') {
                    selectThisTable(barcodeScanRes);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
