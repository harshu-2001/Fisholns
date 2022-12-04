import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  String s = "";
  Details({
    Key? key,
    required this.s,
  }) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String info = '';
  var img = '';
  var size = '';

  void detail(String str) {
    if (str == " Shrimp") {
      img = "assets/images/shrimp.png";
      size = "about 2 cm - 25 cm";
      info =
          "Shrimp are characterized by a semitransparent body flattened from side to side and a flexible abdomen terminating in a fanlike tail.";
    } else if (str == " Black Sea Sprat") {
      img = "assets/images/black.jpg";
      size = "typical size is 10 cm";
      info =
          "The Black Sea sprat is a small fish of the herring family, Clupeidae. It is found in the Black Sea and Sea of Azov and rivers of its basins: Danube, Dnister, Dnipro (Ukraine), Southern Bug, Don, Kuban. It has white-grey flesh and silver-grey scales.";
    } else if (str == " Gilt-Head Bream") {
      size = " about 35 cm - 70 cm";
      img = "assets/images/gilt.jpg";
      info =
          'The gilt-head (sea) bream (Sparus aurata), known as Orata in antiquity and still today in Italy and Tunisia (known as "Dorada" in Spain, "Dourada" in Portugal and "Dorade Royale" in France), is a fish of the bream family Sparidae found in the Mediterranean Sea and the eastern coastal regions of the North Atlantic Ocean.';
    } else if (str == " Hourse Mackerel") {
      size = " about 25 cm - 60 cm";
      img = "assets/images/horse.jpg";
      info =
          'Horse mackerel is a vague vernacular term for a range of species of fish throughout the English-speaking world. It is commonly applied to pelagic fishes, especially of the Carangidae (jack mackerels and scads) family, most commonly those of the genera Trachurus or Caranx';
    } else if (str == " Red Mullet") {
      size = " about 25 cm - 40 cm";
      img = "assets/images/Red.jpg";
      info =
          'The red mullets or surmullets are two species of goatfish, Mullus barbatus and Mullus surmuletus, found in the Mediterranean Sea, east North Atlantic Ocean, and the Black Sea. Both "red mullet" and "surmullet" can also refer to the Mullidae in general.';
    } else if (str == " Red Sea Bream") {
      size = " Upto 120 cm";
      img = "assets/images/sea.jpg";
      info =
          'Red seabream is a name given to at least two species of fish of the family Sparidae, Pagrus major and Pagellus bogaraveo.';
    } else if (str == " Sea Bass") {
      size = " about 60 cm-70 cm";
      img = "assets/images/seabass.jpeg";
      info =
          'sea bass, (family Serranidae), any of the numerous fishes of the family Serranidae (order Perciformes), most of which are marine, found in the shallower regions of warm and tropical seas.';
    } else if (str == " Striped red mullet") {
      size = " about 25 cm - 40 cm";
      img = "assets/images/Red.jpg";
      info =
          'The striped red mullet or surmullet (Mullus surmuletus) is a species of goatfish found in the Mediterranean Sea, eastern North Atlantic Ocean, and the Black Sea.';
    } else if (str == " Trout") {
      size = " about 39 cm - 72 cm";
      img = "assets/images/trout.jpg";
      info =
          'Trout are species of freshwater fish belonging to the genera Oncorhynchus, Salmo and Salvelinus, all of the subfamily Salmoninae of the family Salmonidae.';
    } else {
      size = "";
      img = "";
      info = "";
    }
  }

  @override
  void initState() {
    super.initState();
    detail(widget.s);
  }

  @override
  Widget build(BuildContext context) {
    detail(widget.s);
    // print(widget.s);
    // print("$img $size");
    return Scaffold(
        appBar: AppBar(
          title: const Text("Details"),
          backgroundColor: Colors.blueGrey.withOpacity(0.6),
          elevation: 10.0,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.gif"),
                  fit: BoxFit.fill)),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 50,
              height: MediaQuery.of(context).size.height - 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Card(
                elevation: 10.0,
                color: Colors.grey.shade400,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      img != ''
                          ? SizedBox(
                              width: 300,
                              height: 300,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset(
                                  img,
                                  fit: BoxFit.fill,
                                ),
                              ))
                          : Container(),
                      const SizedBox(
                        height: 20,
                      ),
                      size != ''
                          ? Text(
                              "Size : $size",
                              style: const TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          : Container(),
                      const SizedBox(
                        height: 20,
                      ),
                      info != ''
                          ? Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                "About : $info",
                                style: const TextStyle(
                                  overflow: TextOverflow.clip,
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : Container(),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
