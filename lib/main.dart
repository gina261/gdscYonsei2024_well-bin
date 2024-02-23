import 'package:flutter/material.dart';
import 'package:well_bin01/home.dart';
// import 'camera.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Test",
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  void showPopup(context, title) {
    showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 200),
          child: Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "I'm going to eat",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  debugPrint("I'm going to eat");
                },
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "I'm done eating",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  debugPrint("I'm done eating");
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xff49c14e),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 300),
                  // const Text(
                  //   'Well-bin',
                  //   style: TextStyle(
                  //     fontSize: 35,
                  //     fontWeight: FontWeight.w500,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 100,
                      ),
                      Image.asset('images/well-bin-logo.png'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // TextButton(
                  //   style: TextButton.styleFrom(
                  //     backgroundColor: Colors.white,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     minimumSize:
                  //         Size(MediaQuery.of(context).size.width * 0.94, 70),
                  //     maximumSize:
                  //         Size(MediaQuery.of(context).size.width * 0.94, 70),
                  //   ),
                  //   child: const Text(
                  //     'Upload a photo',
                  //     style: TextStyle(
                  //       fontSize: 20,
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     showPopup(context, 'Upload a Photo');
                  //   },
                  // ),
                  // const SizedBox(height: 10),
                  TextButton(
                    style: TextButton.styleFrom(
                      // backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.99, 500),
                    ),
                    child: const Text(
                      'Click here to start',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
