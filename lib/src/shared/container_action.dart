import 'package:flutter/material.dart';

class ContainerAction extends StatelessWidget {
  final void Function()? onTap;
  final IconData? icon;
  final String text;
  const ContainerAction({
    required this.icon,
    required this.onTap,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 28),
              width: 60,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                border: Border.all(color: Colors.amber, width: 4),
                color: Colors.amberAccent,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 32),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.amber, width: 4),
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    offset: const Offset(1, 7),
                    blurRadius: 1,
                    spreadRadius: 1,
                  )
                ],
                color: Colors.white70,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      icon,
                      size: 72,
                    ),
                    Text(
                      text,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
