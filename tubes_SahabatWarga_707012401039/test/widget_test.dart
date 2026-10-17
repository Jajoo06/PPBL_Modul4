import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tubes_sahabatwarga_707012401039/main.dart';

void main() {
  testWidgets('laporan dari form tampil di daftar laporan', (tester) async {
    await tester.pumpWidget(const AplikasiSahabatWarga());

    await tester.ensureVisible(find.text('Buat laporan'));
    await tester.tap(find.text('Buat laporan'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('judul-laporan')),
      'Lampu jalan mati',
    );
    await tester.enterText(
      find.byKey(const Key('lokasi-laporan')),
      'Jalan Melati',
    );
    await tester.enterText(
      find.byKey(const Key('deskripsi-laporan')),
      'Lampu di ujung jalan mati sejak tadi malam.',
    );
    await tester.scrollUntilVisible(
      find.byKey(const Key('persetujuan-laporan')),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.byKey(const Key('persetujuan-laporan')));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.byKey(const Key('kirim-laporan')),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.byKey(const Key('kirim-laporan')));
    await tester.pumpAndSettle();

    expect(find.text('1 laporan sudah kamu kirim'), findsOneWidget);

    await tester.pump(const Duration(seconds: 6));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Laporan'));
    await tester.pumpAndSettle();

    expect(find.text('Lampu jalan mati'), findsOneWidget);
    expect(find.textContaining('Jalan Melati'), findsOneWidget);
  });

  testWidgets('pesan chat berubah melalui Provider dan tampil di beranda', (
    tester,
  ) async {
    await tester.pumpWidget(const AplikasiSahabatWarga());

    await tester.tap(find.byTooltip('Buka chat'));
    await tester.pumpAndSettle();
    expect(find.text('Chat Sahabat Warga'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Butuh bantuan warga');
    await tester.pump();
    await tester.tap(find.byKey(const Key('kirim-pesan')));
    await tester.pumpAndSettle();

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is RichText &&
            widget.text.toPlainText().contains('Butuh bantuan warga'),
      ),
      findsOneWidget,
    );

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('3'), findsOneWidget);
  });
}
