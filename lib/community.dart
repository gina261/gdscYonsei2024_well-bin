import 'package:flutter/material.dart';
import 'camera.dart';
import 'home.dart';
import 'history.dart';
import 'profile.dart';

class Community extends StatelessWidget {
  const Community({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffa5e0a6),
      body: Center(
        child: Text(
          'Scheduled to open',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w400,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
      ),
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
            currentIndex: 3,
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
    );
  }
}
