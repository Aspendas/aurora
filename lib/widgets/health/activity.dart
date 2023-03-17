import 'package:flutter/material.dart';

class Activity extends StatelessWidget {
  const Activity({Key? key, this.data}) : super(key: key);

  final data;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      height: 150,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: Color.fromRGBO(247, 218, 200, 0.7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8),
                  child: Text(
                    "BAĞIMLILIĞI BIRAKIRKEN YEMEK YEMEK ÇOK ÖNEMLİ. UNUTMAAAA, AL SANA BASIC TARİF",
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.fastfood),
                          SizedBox(
                            width: 8,
                          ),
                          Text("See The Video"),
                          Icon(
                            Icons.play_arrow,
                            size: 28,
                          ),
                        ],
                      ),
                      const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 150,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Image.network(
                data['imageURL'].toString(),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
