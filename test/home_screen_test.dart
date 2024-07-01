import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_app/screens/screens.dart';

void main() {
  testWidgets('Initial data loading test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // Pastikan data awal terpanggil dengan benar
    // expect(find.byType(const ContactTile()), findsWidgets);

    // Pastikan tidak ada teks 'User tidak ditemukan' yang ditampilkan
    expect(find.text('User tidak ditemukan'), findsNothing);
  });
}
