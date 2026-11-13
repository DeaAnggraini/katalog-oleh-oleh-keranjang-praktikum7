import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:katalog_oleh_oleh/keranjang_cubit.dart';
import 'package:katalog_oleh_oleh/main.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('Membuka detail produk dari katalog', (tester) async {
    await tester.pumpWidget(
      BlocProvider(
        create: (_) => KeranjangCubit(),
        child: const KatalogApp(),
      ),
    );
    expect(find.text('Kopi Sidikalang'), findsOneWidget);

    await tester.tap(find.text('Kopi Sidikalang'));
    await tester.pumpAndSettle();

    expect(find.byType(ActionChip), findsOneWidget); // chip kategori di detail
    expect(find.byType(BackButton), findsOneWidget);
  });
}