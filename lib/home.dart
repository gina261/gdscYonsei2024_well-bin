import 'package:flutter/material.dart';
import 'camera.dart';
import 'history.dart';
import 'community.dart';
import 'profile.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
                  Navigator.push(
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
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home, size: 32), label: 'Home'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 70),
              const Text(
                '  GDSC_Yonsei',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 320,
                width: double.infinity,
                color: const Color(0xfff7f7f7),
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "GDSC_Yonsei's tree is..",
                        style: TextStyle(fontSize: 22),
                      ),
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'the seed',
                            style: TextStyle(
                                color: Color(0xff49c14e),
                                fontSize: 25,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            ' stage.',
                            style: TextStyle(color: Colors.black, fontSize: 22),
                          ),
                        ],
                      ),
                      Image.asset(
                        'images/seed.png',
                        height: 100,
                        width: 450,
                      ),
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'You saved ',
                            style: TextStyle(color: Colors.black, fontSize: 22),
                          ),
                          Text(
                            '0.1kg',
                            style: TextStyle(
                                color: Color(0xff49c14e),
                                fontSize: 25,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            ' of carbon!',
                            style: TextStyle(color: Colors.black, fontSize: 22),
                          ),
                        ],
                      ),
                      const Text(
                        "You have 0.9kg left until the next stage.",
                        style: TextStyle(fontSize: 22),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                height: 250,
                width: double.infinity,
                color: const Color(0xff49c14e).withOpacity(0.5),
                child: Center(
                  child: Text(
                    'Scheduled to open',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
              // Center(
              //   child: Container(
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       color: const Color(0xff49c14e).withOpacity(0.5),
              //     ),
              //     padding: const EdgeInsetsDirectional.all(10),
              //     height: 80,
              //     width: 250,
              //     child: const Center(
              //         child: Text(
              //       'Scheduled to open',
              //       style: TextStyle(fontSize: 20),
              //     )),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
