import 'package:btk_project/product/extension/context_extesion.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String chatNumber; // Her kartın numarasını tutmak için yeni bir alan
  final VoidCallback? onTap;

  const CategoryCard({
    required this.title,
    required this.chatNumber, // Numarayı zorunlu hale getiriyoruz
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Color(0XFF98FB98),
        child: Column(
          // Kartın içeriğini dikey olarak hizalamak için Column ekliyoruz
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                chatNumber, // Sohbet numarasını göster
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: context.dynamicHeight(0.04)),
            Center(
              child: Text(title),
            ),
          ],
        ),
      ),
    );
  }
}
