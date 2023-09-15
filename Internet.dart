import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tester/main.dart';

class Internet
{
  static late StreamSubscription<ConnectivityResult> _dinleyici;

  static bool servis = false;

  static bool internet = true;

  static bool dialogDurum = false;

  static void control() async
  {
    internet = await InternetConnectionChecker().hasConnection;
    dialog(internet);
  }

  static void baslat()
  {
    control();
    if(!servis)
    {
      _dinleyici = Connectivity().onConnectivityChanged.listen((sonuc)
      {
        internet = (sonuc == ConnectivityResult.mobile || sonuc == ConnectivityResult.wifi);
        dialog(internet);
      });
      servis = true;
    }
  }

  static void durdur()
  {
    _dinleyici?.cancel();
    servis = false;
  }

  static void dialog(bool internet)
  {
    if(!internet)
    {
      dialogDurum = true;
      showDialog(
          context: navKey.currentState!.context,
          barrierDismissible: false,
          builder: (BuildContext context)
          {
            return AlertDialog(
              title: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    Icon(
                      Icons.wifi_off_rounded,
                      size: 50,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 15),
                        "Lütfen internet bağlantınızı kontrol edin.")
                  ],
                ),
              ),
              backgroundColor: Colors.deepPurple,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            );
          }
      );
    }
    else
    {
      if(dialogDurum)
      {
        Navigator.of(navKey.currentState!.context).pop();
      }
    }
  }
}