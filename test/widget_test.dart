import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kal/main.dart'; // Update the import to your main.dart path
import 'package:kal/kalender.dart'; // Update the import to your kalender.dart path
import 'package:intl/intl.dart';

void main() {
  testWidgets('Kalender page smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the calendar page is displayed with the title of the current month and year.
    final currentMonthYear = DateFormat.yMMMM().format(DateTime.now());
    expect(find.text(currentMonthYear), findsOneWidget);

    // Verify that the days of the week are displayed.
    expect(find.text('Min'), findsOneWidget);
    expect(find.text('Sen'), findsOneWidget);
    expect(find.text('Sel'), findsOneWidget);
    expect(find.text('Rab'), findsOneWidget);
    expect(find.text('Kam'), findsOneWidget);
    expect(find.text('Jum'), findsOneWidget);
    expect(find.text('Sab'), findsOneWidget);

    // Tap the 'arrow_forward' icon to go to the next month and trigger a frame.
    await tester.tap(find.byIcon(Icons.arrow_forward));
    await tester.pump();

    // Verify that the calendar page title has changed to the next month.
    final nextMonth = DateTime.now().month + 1;
    final nextMonthYear = DateFormat.yMMMM().format(DateTime(DateTime.now().year, nextMonth));
    expect(find.text(nextMonthYear), findsOneWidget);

    // Verify that the event detail is displayed.
    expect(find.text('Blue Day'), findsOneWidget);
    expect(find.text('Lorem ipsum dolor sit amet, consectetur'), findsOneWidget);
  });
}
