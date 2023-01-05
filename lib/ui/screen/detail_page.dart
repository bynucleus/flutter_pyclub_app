import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:myclub/model/listePresence.dart';
import 'package:myclub/model/note.dart';
import 'package:myclub/model/seance.dart';
import 'package:myclub/services/http_service.dart';
import 'package:myclub/util/constant.dart';
import 'package:myclub/util/info.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailPage extends StatefulWidget {
  SeanceModel seance;
  DetailPage(this.seance, {Key key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<Note> _notes;
  bool _isLoading = true;
  List<ListeModel> _liste;
  bool _isLoadingListe = true;
  String texte = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    setState(() {
      // print(missionController.fetchData());
    });
  }

  Future<void> getData() async {
    _notes = await API_Manager.getNoteBySeance(widget.seance.id);
    _liste = await API_Manager.geListePBySeance(widget.seance.id);
    print(_liste);
    setState(() {
      _isLoading = false;
      _isLoadingListe = false;
    });
  }

  Future<void> sendEtRefresh(String contenu) async {
    ProgressDialog progressDialog = ProgressDialog(
      context,
      dismissable: false,
      title: const Text('Traitement'),
      message: const Text('en cours ...'),
    );
    progressDialog.show();

    await API_Manager.addNote(Info.nom, widget.seance.id, contenu);
    print(contenu);
    await getData();
    progressDialog.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 34),
        child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              _contentHeader(),
              const SizedBox(
                height: 30,
              ),
              Text(
                'resumé de la seance fait par vous et pour vous',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(
                height: 50,
              ),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        for (var item in _notes ?? [])
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                _contentOverView(context, item),
                                const SizedBox(
                                  height: 50,
                                ),
                              ])
                      ],
                    ),
            ])),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 110,
          decoration: BoxDecoration(
            color: const Color(0xFF212330),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {});
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    child: IconButton(
                      icon: Icon(Icons.add),
                      color: Colors.white,
                      onPressed: () {
                        showDialog(
                            // barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              final contenu =
                                  TextEditingController(text: texte);
                              return AlertDialog(
                                content: Stack(
                                  // overflow: Overflow.visible,
                                  children: <Widget>[
                                    Positioned(
                                      right: -40.0,
                                      top: -40.0,
                                      child: InkResponse(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: CircleAvatar(
                                          child: Icon(Icons.close),
                                          backgroundColor: Colors.red,
                                        ),
                                      ),
                                    ),
                                    Form(
                                      // key: _formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: TextField(
                                              onChanged: (text) {
                                                texte = text;
                                              },
                                              controller: contenu,
                                              maxLines: 5,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              decoration: InputDecoration.collapsed(
                                                  hintText:
                                                      "Entrez votre resumé ici"),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ElevatedButton(
                                              child: Text("Valider"),
                                              onPressed: () async {
                                                Navigator.pop(context, true);
                                                contenu.text != ""
                                                    ? sendEtRefresh(
                                                        contenu.text)
                                                    : null;

                                                // if (_formKey.currentState.validate()) {
                                                //   _formKey.currentState.save();
                                                // }
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffFFAC30),
                      borderRadius: BorderRadius.circular(10),
                      // boxShadow: shadowList,
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor: Theme.of(context).cardColor,
                          context: context,
                          builder: (context) {
                            return SingleChildScrollView(
                                child: Wrap(
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                ListTile(
                                  // leading: Icon(Icons.person),
                                  title: Text("Liste de presence"),
                                  trailing:
                                      Text(_liste?.length.toString() ?? "0"),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                for (var value in _liste ?? [])
                                  ListTile(
                                    leading: Icon(Icons.person),
                                    title: Text(value.nom ?? " "),
                                    trailing: Text(value.date ?? " "),
                                  ),
                                // Center(
                                //   child: ElevatedButton(
                                //       child: Text('Marquer ma presence'),
                                //       // style: ButtonStyle(backgroundColor:  COLOR_BACKGROUND),
                                //       onPressed: () {
                                //         API_Manager.addPresence(
                                //             Info.nom, widget.seance.id);
                                //         Fluttertoast.showToast(
                                //             msg:
                                //                 "votre presence à bien été marqué !");
                                //         Navigator.pop(context, false);
                                //         // Navigator.pop(context, false);
                                //         getData();
                                //       }),
                                // ),
                                ListTile(
                                  title: Text(""),
                                ),
                              ],
                            ));
                          });
                    },
                    child: Container(
                      height: 50,
                      // width: 50,
                      child: Center(
                        child: Text(
                          'liste de presence',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffFFAC30),
                        borderRadius: BorderRadius.circular(10),
                        // boxShadow: shadowList,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _contentHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              'Seance du ' + widget.seance.date,
              style: Theme.of(context).textTheme.headline3,
            )
          ],
        ),
      ],
    );
  }

  Widget _contentOverView(BuildContext context, Note note) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 18, right: 18, top: 22, bottom: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor,
        // color: const Color(0xffF1F3F6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'resumé fait par ' + note.nom,
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            note.contenu,
            style: Theme.of(context).textTheme.headline4.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
              // crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  note?.date ?? "h ",
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        fontSize: 10,
                        // fontWeight: FontWeight.w400,
                      ),
                ),
              ])
        ],
      ),
    );
  }
}
