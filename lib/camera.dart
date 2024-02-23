import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'camera_before_eat.dart';
import 'food_detail.dart';
import 'home.dart';
import 'history.dart';
import 'community.dart';
import 'profile.dart';
import './http_request.dart';
import './camera_after_eat.dart';

class CameraHome extends StatefulWidget {
  const CameraHome({Key? key}) : super(key: key);

  @override
  _CameraHomeState createState() => _CameraHomeState();
}

class _CameraHomeState extends State<CameraHome> {
  String formattedDate = DateFormat('MMM dd, yyyy').format(DateTime.now());
  String? uploadedImageUrlbeforeEat;
  String? userId;
  Map<String, dynamic>? apiResult;
  String? uploadedImgUrlAfterEat;

  // Use fast api to get food list
  // Future<String>
  Future getFoodListData() async {
    String? modifiedUrl;

    // url modifying
    int startIdx = uploadedImageUrlbeforeEat!.indexOf('&token=');
    if (startIdx != -1) {
      modifiedUrl = uploadedImageUrlbeforeEat!
          .replaceRange(startIdx, startIdx + 1, '%26');
      debugPrint("Modified: $modifiedUrl");
    } else {
      debugPrint('URL does not contain "&token="');
    }

    // food detection
    try {
      debugPrint("tryDoubleCheck: $modifiedUrl");
      apiResult =
          await httpGetFoodList(path: '/food_detection/?img_path=$modifiedUrl');
      if (apiResult != null && apiResult!['statusCode'] == 200) {
        debugPrint("apiResult: ${apiResult!}");
        // return '결과: ${apiResult!}';
        return apiResult;
      } else {
        // Handle the case when the condition is not met
        return 'Data not available.\n$apiResult\n$userId';
      }
    } catch (e) {
      // Handle any errors that occur during the request
      debugPrint("Error fetching data: $e");
      return 'Error fetching data';
    }
  }

  Future getRecycleListData() async {
    String? modifiedUrl;

    // url modifying
    int startIdx = uploadedImgUrlAfterEat!.indexOf('&token=');
    if (startIdx != -1) {
      modifiedUrl =
          uploadedImgUrlAfterEat!.replaceRange(startIdx, startIdx + 1, '%26');
      debugPrint('Modified: $modifiedUrl');
    } else {
      debugPrint('URL does not contain "&token="');
    }

    // recycle detection
    try {
      debugPrint("tryDoubleCheck: $modifiedUrl");
      apiResult = await httpGetRecycleList(path: "$modifiedUrl");
      if (apiResult != null && apiResult!['statusCode'] == 200) {
        debugPrint("apiResult: ${apiResult!}");

        return apiResult;
      } else {
        return 'Data not available.\n$apiResult\n$userId';
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
      return 'Error fetching data';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color(0xff49c14e),
            onTap: (int index) {
              switch (index) {
                case 0:
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const Home(),
                      transitionDuration:
                          const Duration(seconds: 0), // 애니메이션 시간을 0으로 설정
                    ),
                  );
                  break;
                case 1:
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const History(),
                      transitionDuration:
                          const Duration(seconds: 0), // 애니메이션 시간을 0으로 설정
                    ),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const CameraHome(),
                      transitionDuration:
                          const Duration(seconds: 0), // 애니메이션 시간을 0으로 설정
                    ),
                  );
                  break;
                case 3:
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const Community(),
                      transitionDuration:
                          const Duration(seconds: 0), // 애니메이션 시간을 0으로 설정
                    ),
                  );
                  break;
                case 4:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Profile(),
                    ),
                  );
                  break;
                default:
                  break;
              }
            },
            currentIndex: 2,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 32,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.article, size: 32), label: 'History'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.camera_alt_sharp,
                    size: 50,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.language, size: 32), label: 'Community'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person, size: 32), label: 'Profile'),
            ],
          ),
          Positioned(
            top: 0,
            left: MediaQuery.of(context).size.width / 2.4,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const CameraHome(),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              },
              child: Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff49c14e),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff49c14e),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.camera_alt_sharp,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            formattedDate,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Before Eating',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (uploadedImageUrlbeforeEat != null)
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                uploadedImageUrlbeforeEat!,
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 20),
                            SizedBox(
                              width: 130,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FutureBuilder(
                                    future: getFoodListData(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasData) {
                                          Map<String, dynamic> foodList =
                                              snapshot.data!;
                                          List<dynamic> data = foodList['data'];

                                          if (data[1] == 'Yes') {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Food List:',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                for (var item in data[0])
                                                  Text(
                                                    '• $item',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                // Text('Result: ${data[1]}')
                                              ],
                                            );
                                          } else {
                                            return const Text(
                                              'No food found',
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            );
                                          }
                                        } else {
                                          return const Text(
                                              'No data available');
                                        }
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.black.withOpacity(0.15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            fixedSize: const Size(360, 50),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // builder: (context) => const FoodDetail(),
                                builder: (context) =>
                                    FoodDetail(foodList: apiResult),
                              ),
                            );
                          },
                          child: const Text(
                            'Details',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        )
                      ],
                    )
                  else
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black.withOpacity(0.15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        fixedSize: const Size(150, 150),
                      ),
                      child: Text(
                        "⊕",
                        style: TextStyle(
                          fontSize: 50,
                          color: Colors.black.withOpacity(0.15),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      onPressed: () async {
                        List<String>? imageUrl = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GetImageBeforeEat(),
                          ),
                        );

                        if (imageUrl != null) {
                          setState(() {
                            uploadedImageUrlbeforeEat = imageUrl[0];
                          });
                        }
                      },
                    ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'After Eating',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (uploadedImgUrlAfterEat != null)
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                uploadedImgUrlAfterEat!,
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 20),
                            SizedBox(
                              width: 130,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FutureBuilder(
                                    future: getRecycleListData(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasData) {
                                          Map<String, dynamic> recycleList =
                                              snapshot.data!;
                                          List<dynamic> data =
                                              recycleList['data'];

                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              for (var item in data)
                                                Text(
                                                  '$item',
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                            ],
                                          );
                                        } else {
                                          return const Text(
                                            'No object found',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          );
                                        }
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  else
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black.withOpacity(0.15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        fixedSize: const Size(150, 150),
                      ),
                      child: Text(
                        "⊕",
                        style: TextStyle(
                          fontSize: 50,
                          color: Colors.black.withOpacity(0.15),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      onPressed: () async {
                        List<String>? imageUrlAfterEat = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GetImageAfterEat(),
                          ),
                        );

                        if (imageUrlAfterEat != null) {
                          setState(() {
                            uploadedImgUrlAfterEat = imageUrlAfterEat[0];
                          });
                        }
                      },
                    ),
                  SizedBox(
                    height: 80,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
