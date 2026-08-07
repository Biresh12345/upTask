import 'dart:io';

import 'package:UpTask/Screens/settingpage.dart';
import 'package:UpTask/Screens/taskpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:UpTask/Screens/aboutpage.dart';
import 'package:UpTask/Screens/helpandsupportpage.dart';
import 'package:UpTask/Screens/remaindarpage.dart';

import '../widget/profileCard.dart';

class Profilepage extends ConsumerWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              ProfileCard(),

              const SizedBox(height: 20),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [

                    profileTile(
                      icon: Icons.notifications_active,
                      title: "Reminders",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Remaindarpage(),
                          ),
                        );
                      },
                    ),

                    const Divider(height: 1),

                    profileTile(
                      icon: Icons.backup,
                      title: "Backup & Restore",
                      onTap: () {},
                    ),

                    const Divider(height: 1),

                    profileTile(
                      icon: Icons.settings,
                      title: "Settings",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const Settingpage(),
                          ),
                        );
                      },
                    ),

                  ],
                ),
              ),

              const SizedBox(height: 20),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [

                    profileTile(
                      icon: Icons.help_outline,
                      title: "Help & Support",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const Helpandsupportpage(),
                          ),
                        );
                      },
                    ),

                    const Divider(height: 1),

                    profileTile(
                      icon: Icons.info_outline,
                      title: "About App",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const Aboutpage(),
                          ),
                        );
                      },
                    ),

                  ],
                ),
              ),

              const SizedBox(height: 20),

              Card(
                color: Colors.red.withOpacity(.08),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ),
                  title: const Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,size:18),
                  onTap: () {
                    // Logout Dialog
                  },
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                "Version 1.0.0",
                style: TextStyle(color: Colors.grey),
              )

            ],
          ),
        )
    );
  }


  Widget profileTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Color? iconColor,
  }) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.blue.withOpacity(.1),
        child: Icon(icon, color: iconColor ?? Colors.blue),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 18,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
}
