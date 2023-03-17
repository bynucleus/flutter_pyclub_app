import 'package:flutter/material.dart';
import '../components.dart';
import '../models/food.dart';
import '../models/order.dart';
import '../screens/account.dart';
import '../screens/home.dart';
import '../screens/select_table.dart';
import '../styles.dart';

import '../api.dart';
import '../globals.dart';
import '../utils.dart';

class Restauration extends StatefulWidget {
  const Restauration({key});

  @override
  State<Restauration> createState() => _RestaurationState();
}

class _RestaurationState extends State<Restauration> {
  @override
  void initState() {
    super.initState();

    if (globalUser != null) {
      Api.getOrders().then((value) {
        setState(() {
          _orders = value;
        });
      });
    }
  }

  List<Order> _orders = [];


  @override
  Widget build(BuildContext context) {
    List<Widget> orderList = [];
    for (var order in _orders) {
      orderList.add(orderCard(order));
    }
    return (globalUser == null)
        ? Center(
            child: Scaffold(
              backgroundColor: kwhite,
              appBar: backNavBar(context, "RESTAURATION", kPrimaryColor),
              body: msgCard(
                  context,
                  "veuillez vous authentifier pour acceder a cette fonctinnalité",
                  Padding(
                    padding: screenMargin,
                    child: RectBtn(
                      label: const Text('SE CONNECTER',
                          style: whiteBoldLabelStyle),
                      bgColor: kPrimaryColor,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Account()),
                        );
                      },
                    ),
                  )),
            ),
          )
        : const OrderHistory();
  }
}

class OrderHistory extends StatefulWidget {
  const OrderHistory({key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  void initState() {
    super.initState();
    if (globalUser != null) {
      Api.getOrders().then((value) {
        setState(() {
          _orders = value;
        });
      });
    }
  }

  List<Order> _orders = [];

  @override
  Widget build(BuildContext context) {
    List<Widget> orderList = [];
    for (var order in _orders) {
      orderList.add(orderCard(order));
    }
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
        return false;
      },
      child: Scaffold(
        appBar: backNavBar(context, "RESTAURATION", kPrimaryColor, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        }),
        floatingActionButton: FloatingActionButton(
            backgroundColor: kPrimaryColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StartOrder()),
              );
            },
            child: const Icon(
              Icons.add,
              color: kwhite,
            )),
        body: (_orders.isEmpty)
            ? msgCard(
                context,
                "vous n'avez passé aucune commande. \n Cliquez sur le bouton (+) ci-dessous pour commander.",
                const SizedBox())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: orderList),
                ),
              ),
      ),
    );
  }
}

class StartOrder extends StatefulWidget {
  const StartOrder({key});

  @override
  State<StartOrder> createState() => _StartOrderState();
}

class _StartOrderState extends State<StartOrder> {
  @override
  void initState() {
    super.initState();
    Api.getFoodsbyType('ACCOMPAGNEMENT').then((value) {
      setState(() {
        _foodAccompagnements = value;
        _selectAccompagnement = _foodAccompagnements.first;
      });
    });
    Api.getFoodsbyType('VIANDE').then((value) {
      setState(() {
        _foodViandes = value;
        _selectViande = _foodViandes.first;
      });
    });
    Api.getFoodsbyType('BOISSONS').then((value) {
      setState(() {
        _foodBoissons = value;
        _selectBoisson = _foodBoissons.first;
      });
    });
  }


  void submitForm() async {
    setState(() {
      _loading = true;
    });
    List<Food> foods = [_selectAccompagnement, _selectBoisson];
    if (_selectViande != null) {
      foods = [_selectAccompagnement, _selectViande, _selectBoisson];
    }

    if (globalUser.invitationCode == null || globalUser.paid == false) {
      showDialog(
        context: context,
        builder: (context) => const CustomModal(
            message:
                "Cette fonctionnalité est reservée aux utilisateurs ayant payé leur JI.\nApparement ce n'est pas votre cas. c'est dommage! \n Mais pas de pannique vous serez quand meme servir."),
      );
      setState(() {
        _loading = false;
      });
    } else {
      Order order =
          Order(table: gblTable, foods: foods, orderedBy: globalUser.id);
      await Future.delayed(const Duration(seconds: 2), () {
        Future request = Api.passOrder(order);
        request.then((data) {
          if (data["success"]) {
            showSuccess(data["message"]);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Restauration()),
            );
          } else {
            showDialog(
              context: context,
              builder: (context) => CustomModal(message: data["message"]),
            );
          }
          setState(() {
            _loading = false;
          });
        });
      });
    }
  }

  bool _loading = false;
  List<Food> _foodAccompagnements = [];
  List<Food> _foodViandes = [];
  List<Food> _foodBoissons = [];

  Food _selectAccompagnement = Food();
  Food _selectViande;
  Food _selectBoisson = Food();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OrderHistory()),
        );
        return false;
      },
      child: Scaffold(
          appBar: backNavBar(context, "Nouvelle Commande", kPrimaryColor, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OrderHistory()),
            );
          }),
          body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "TABLE:",
                      style: blackBoldLabelStyle,
                    ),
                    RectBtn(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      iconRight: const Icon(Icons.arrow_drop_down),
                      label: Text(gblTable ?? "SELECTIONNER",
                          style: minLabelStyle),
                      bgColor: kwhite.withOpacity(0),
                      bordered: Border.all(
                        color: Colors.black,
                      ),
                      hasLoader: _loading,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SelectTable()),
                        );
                      },
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: screenMargin,
                    child: sectionTitle("ACCOMPAGNEMENT"),
                  ),
                  foodList(_foodAccompagnements, Axis.horizontal,
                      const SizedBox(), _selectAccompagnement),
                  Padding(
                    padding: screenMargin,
                    child: sectionTitle("VIANDES"),
                  ),
                  if (!_selectAccompagnement.full)
                    foodList(_foodViandes, Axis.horizontal, const SizedBox(),
                        _selectViande ?? Food()),
                  if (_selectAccompagnement.full)
                    Padding(
                      padding: screenMargin,
                      child: msgCard(context,
                          "ce repas ne nécessite pas de viande", const SizedBox()),
                    ),
                  Padding(
                    padding: screenMargin,
                    child: sectionTitle("BOISSONS"),
                  ),
                  foodList(_foodBoissons, Axis.horizontal, const SizedBox(),
                      _selectBoisson),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: RectBtn(
                    label: const Text('PASSER MA COMMANDE',
                        style: whiteBoldLabelStyle),
                    bgColor: kPrimaryColor,
                    hasLoader: _loading,
                    press: () {
                      if (gblTable != null) {
                        submitForm();
                      } else {
                        showSuccess("Veuillez selectionner une table");
                      }
                    },
                  ))
            ]),
          )),
    );
  }

  Widget orderList(
    List<Order> allOrder,
    Widget empty,
  ) {
    return Container(
      margin: screenMargin,
      height: 300,
      child: (allOrder.isEmpty)
          ? empty
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: allOrder.length,
              itemBuilder: (context, index) {
                return orderCard(allOrder[index]);
              }),
    );
  }

  Widget minFoodCard(Food food) {
    return Row(children: [
      Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(right: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(150),
          child: Image.network(
            '$ipAddress${food.image}',
            width: 35,
            fit: BoxFit.cover,
            errorBuilder: (BuildContext context, Object exception,
                  StackTrace stackTrace) {
                return Image.asset(
                  'assets/images/not-found.png',
                  fit: BoxFit.cover,
                  width: 35,
                );
              },
          ),
        ),
      ),
      Text("${food.name}".toUpperCase())
    ]);
  }

  Widget orderCard(Order order) {
    List<Widget> foodList = [];

    for (var food in order.foods) {
      foodList.add(minFoodCard(food));
      foodList.add(const Divider());
    }

    return shadowCard(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              threeDot("#CMD ${order.id}", 20).toUpperCase(),
              style: blackBoldLabelStyle,
            ),
            Wrap(children: foodList),
            getOrderStatus(order.status)
          ],
        ),
        15);
  }

  Widget foodList(
    List<Food> allfood,
    Axis axis,
    Widget empty,
    Food selection,
  ) {
    return Container(
      margin: screenMargin,
      height: 255,
      child: ListView.builder(
          scrollDirection: axis,
          itemCount: allfood.length,
          itemBuilder: (context, index) {
            return foodCard2(allfood[index], (selection == allfood[index]));
          }),
    );
  }

  Widget foodCard2(Food food, bool selected) {
    const nameStyle =
        TextStyle(fontSize: 20, color: kwhite, fontWeight: FontWeight.bold);
    const ingredientListStyle = TextStyle(
        fontSize: 18,
        color: kwhite,
        // fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic);

    return InkWell(
      onTap: () {
        switch (food.type) {
          case 'ACCOMPAGNEMENT':
            setState(() {
              _selectAccompagnement = food;
              if (food.full) {
                _selectViande = null;
              } else {
                _selectViande = (_selectViande == null)
                    ? _foodViandes.first
                    : _selectViande;
              }
            });
            break;
          case 'VIANDE':
            setState(() {
              _selectViande = food;
            });
            break;
          case 'BOISSONS':
            setState(() {
              _selectBoisson = food;
            });
            break;
          default:
        }
      },
      child: Container(
          margin: const EdgeInsets.only(right: 12),
          height: (gblSize.width * 0.6),
          width: gblSize.width * 0.6,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                '$ipAddress${food.image}',
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: const EdgeInsets.only(bottom: 15, right: 10, left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black.withOpacity(0.45),
              border: Border.all(
                  color: ksecondaryColor.withOpacity((selected) ? 1 : 0),
                  width: 5),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(food.name.toUpperCase(), style: nameStyle),
                Container(
                    constraints: const BoxConstraints(minHeight: 35),
                    child: Text("${food.stock} restant",
                        style: ingredientListStyle)),
              ],
            ),
          )),
    );
  }
}
