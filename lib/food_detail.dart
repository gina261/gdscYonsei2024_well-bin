import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:well_bin01/http_request.dart';

class FoodDetail extends StatefulWidget {
  final Map<String, dynamic>? foodList;
  const FoodDetail({Key? key, this.foodList}) : super(key: key);

  @override
  _FoodDetailState createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  String formattedDate = DateFormat('MMM dd, yyyy').format(DateTime.now());
  String selectedFood = '';
  late Future<Map<String, dynamic>>? nutrientDataFuture;

  // _FoodDetailState({this.foodList});
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? foodList = widget.foodList;
    List<dynamic> data = foodList!['data'];
    List<dynamic> foods = data[0];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              const SizedBox(
                width: 60,
              ),
              Text(
                formattedDate,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(child: SingleChildScrollView(child: nutrientInfo(foods))),
    );
  }

  Widget nutrientInfo(List<dynamic> foods) {
    return Column(
      children: [
        // Text('Food List: $foods'),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: foods.map((food) {
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: buildFoodButton(food),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 15),
        selectedFood.isNotEmpty
            ? buildNutrientInfo(selectedFood)
            : Container(
                height: 600,
                width: 360,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.black.withOpacity(0.075),
                ),
                child: const Center(
                  child: Text(
                    "Click the button for nutritional information.\nNutrients are displayed based on 100 grams.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
        const SizedBox(height: 50),
      ],
    );
  }

  Widget buildFoodButton(String food) {
    return TextButton(
      onPressed: () {
        setState(() {
          selectedFood = food;
          nutrientDataFuture = fetchNutrientData(selectedFood);
        });
      },
      style: TextButton.styleFrom(
        backgroundColor:
            selectedFood == food ? const Color(0xff49c14e) : Colors.white,
        side: BorderSide(
            color:
                selectedFood == food ? const Color(0xff49c14e) : Colors.black),
      ),
      child: Text(food,
          style: TextStyle(
            color: selectedFood == food ? Colors.white : Colors.black,
          )),
    );
  }

  // 영양 정보를 가져옴.
  Future<Map<String, dynamic>> fetchNutrientData(String foodName) async {
    try {
      Map<String, dynamic> result =
          await httpGetNutrient(foodName: foodName) as Map<String, dynamic>;
      return result['data'];
    } catch (e) {
      debugPrint('Error fetching nutrient data: $e');
      rethrow;
    }
  }

  // 선택된 음식에 따라 다른 widget를 렌더링
  Widget buildNutrientInfo(String selectedFood) {
    return FutureBuilder<Map<String, dynamic>>(
      future: nutrientDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: 360,
            height: 600,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.black.withOpacity(0.075),
            ),
            child: const Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Text('No data available');
        } else {
          return buildNutrientInfoWidget(snapshot.data!);
        }
      },
    );
  }

  Container buildNutrientInfoWidget(Map<String, dynamic> nutrientData) {
    return Container(
      width: 360,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.black.withOpacity(0.075),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Text 위젯은 왼쪽 정렬
          children: [
            Text(
              'Calories: ${double.parse(nutrientData['calories'])} kcal',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            singleBar('Calcium', double.parse(nutrientData['calcium'] ?? '0'),
                700, 'mg'),
            const SizedBox(height: 20),
            singleBar('Carbohydrate',
                double.parse(nutrientData['carbohydrate'] ?? '0'), 324, 'g'),
            const SizedBox(height: 20),
            singleBar('Cholesterol',
                double.parse(nutrientData['cholesterol'] ?? '0'), 300, 'mg'),
            const SizedBox(height: 20),
            singleBar('Fat', double.parse(nutrientData['fat'] ?? '0'), 54, 'g'),
            const SizedBox(height: 20),
            singleBar(
                'Fiber', double.parse(nutrientData['fiber'] ?? '0'), 25, 'g'),
            const SizedBox(height: 20),
            singleBar(
                'Iron', double.parse(nutrientData['iron'] ?? '0'), 12, 'mg'),
            const SizedBox(height: 20),
            singleBar('Potassium',
                double.parse(nutrientData['potassium'] ?? '0'), 3500, 'mg'),
            const SizedBox(height: 20),
            singleBar('Protein', double.parse(nutrientData['protein'] ?? '0'),
                55, 'g'),
            const SizedBox(height: 20),
            singleBar('Saturated Fat',
                double.parse(nutrientData['saturated_fat'] ?? '0'), 15, 'g'),
            const SizedBox(height: 20),
            singleBar('Sodium', double.parse(nutrientData['sodium'] ?? '0'),
                2000, 'mg'),
            const SizedBox(height: 20),
            singleBar(
                'Sugar', double.parse(nutrientData['sugar'] ?? '0'), 100, 'g'),
            const SizedBox(height: 20),
            singleBar('Vitamin A',
                double.parse(nutrientData['vitamin_a'] ?? '0'), 700, '㎍ RAE'),
            const SizedBox(height: 20),
            singleBar('Vitamin C',
                double.parse(nutrientData['vitamin_c'] ?? '0'), 100, 'mg'),
          ],
        ),
      ),
    );
  }

  Column singleBar(
      String nutrient, double given, double suggested, String unit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              nutrient, // calories, protein
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xff49c14e),
              ),
            ),
            const Spacer(),
            Text('$given / $suggested $unit'), // 1200 / 1686 kcal
          ],
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 320,
          child: LinearProgressIndicator(
            value: given / suggested, // 1200 / 1686
            backgroundColor: Colors.black.withOpacity(0.15),
            minHeight: 14,
            borderRadius: BorderRadius.circular(6),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xff49c14e)),
          ),
        ),
      ],
    );
  }

  // Future getNutrientData(String foodName) async {
  //   try {
  //     apiResult = await httpGetNutrient(foodName: foodName)
  //   }
  // }
}
