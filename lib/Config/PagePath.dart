import 'package:chat_app/view/auth/Auth_view.dart';
import 'package:chat_app/view/chatroom/chat_room.dart';
import 'package:chat_app/view/homepage/chats/homepage.dart';
import 'package:chat_app/view/homepage/contacts/contact_view.dart';
import 'package:chat_app/view/profile/update_profile.dart';
import 'package:chat_app/view/profile/widget/profile_view.dart';
import 'package:chat_app/view/splash/splash_view.dart';
import 'package:chat_app/view/welcome/welcome.dart';
import 'package:get/route_manager.dart';

var pagePath = [
  GetPage(
      name: "/welcome",
      page: () => const WelcomeScreenView(),
      transition: Transition.rightToLeft),
  GetPage(
      name: "/home",
      page: () => const HomepageView(),
      transition: Transition.rightToLeft),
  GetPage(
      name: "/authpage",
      page: () => const AuthView(),
      transition: Transition.rightToLeft),
  GetPage(
      name: "/",
      page: () => const SplashView(),
      transition: Transition.rightToLeft),
  GetPage(
      name: "/chatroom",
      page: () => const ChatRoomView(),
      transition: Transition.rightToLeft),
  GetPage(
      name: "/profile",
      page: () => const ProfileView(),
      transition: Transition.rightToLeft),
  GetPage(
      name: "/updateprofile",
      page: () => const UpdateProfileView(),
      transition: Transition.rightToLeft),
  GetPage(
      name: "/contact",
      page: () => const ContactView(),
      transition: Transition.rightToLeft),
];
