import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simplyserve/views/recipes.dart';
import 'package:simplyserve/widgets/navbar.dart';

void main() {
  group('RecipesView Widget Tests', () {
    testWidgets('RecipesView renders correctly with NavBarScaffold',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: RecipesView(),
        ),
      );

      // Verify NavBarScaffold is present
      expect(find.byType(NavBarScaffold), findsOneWidget);

      // Verify AppBar title
      expect(find.text('Recipes'), findsAtLeastNWidgets(1));
    });

    testWidgets('RecipesView displays main content and icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: RecipesView(),
        ),
      );

      // Verify main heading
      expect(find.text('Recipes'), findsAtLeastNWidgets(1));

      // Verify description text
      expect(
        find.text(
            'Browse and discover delicious meal recipes tailored to your dietary needs.'),
        findsOneWidget,
      );

      // Verify restaurant icon is displayed
      expect(find.byIcon(Icons.restaurant_menu), findsAtLeastNWidgets(1));
    });

    testWidgets('RecipesView displays search button',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: RecipesView(),
        ),
      );

      // Find search button text
      expect(find.text('Search Recipes'), findsOneWidget);

      // Verify button has search icon
      expect(find.byIcon(Icons.search), findsOneWidget);

      // Tap the button to verify it works
      await tester.tap(find.text('Search Recipes'));
      await tester.pump();
    });

    testWidgets('Search button shows SnackBar when tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: RecipesView(),
        ),
      );

      // Tap the search button
      await tester.tap(find.text('Search Recipes'));
      await tester.pump(); // Start SnackBar animation

      // Verify SnackBar message
      expect(
        find.text('Recipe search coming soon!'),
        findsOneWidget,
      );
    });

    testWidgets('RecipesView uses correct theme color',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: RecipesView(),
        ),
      );

      // Find button using widgetPredicate that checks for ElevatedButton
      final buttonFinder = find.byWidgetPredicate(
        (widget) => widget is ElevatedButton,
      );
      expect(buttonFinder, findsOneWidget);

      final button = tester.widget<ElevatedButton>(buttonFinder);

      // Verify button uses the theme color (#74BC42)
      final buttonColor = button.style?.backgroundColor?.resolve({});
      expect(buttonColor, const Color(0xFF74BC42));
    });

    testWidgets('RecipesView icon uses correct color with transparency',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: RecipesView(),
        ),
      );

      // Find the restaurant icon in the content (not in drawer)
      final icons = tester.widgetList<Icon>(
        find.byIcon(Icons.restaurant_menu),
      );

      // Should have at least one icon with color
      bool hasColoredIcon = false;
      for (var icon in icons) {
        if (icon.color != null) {
          hasColoredIcon = true;
          // Check it's the green color with transparency
          expect(icon.color?.value,
              const Color(0xFF74BC42).withValues(alpha: 0.6).value);
          break;
        }
      }
      expect(hasColoredIcon, isTrue);
    });

    testWidgets('RecipesView has drawer with navigation items',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: RecipesView(),
        ),
      );

      // Open the drawer
      final ScaffoldState state = tester.firstState(find.byType(Scaffold));
      state.openDrawer();
      await tester.pumpAndSettle();

      // Verify drawer header
      expect(find.text('Simply Serve'), findsWidgets);
      expect(find.text('Smart Meal Planner'), findsOneWidget);

      // Verify navigation menu items
      expect(find.text('Dashboard'), findsOneWidget);
      expect(find.text('Recipes'), findsAtLeastNWidgets(1));
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('Recipes is highlighted as active route in drawer',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          routes: {
            '/recipes': (context) => const RecipesView(),
          },
          initialRoute: '/recipes',
        ),
      );

      // Open the drawer
      final ScaffoldState state = tester.firstState(find.byType(Scaffold));
      state.openDrawer();
      await tester.pumpAndSettle();

      // Find the Recipes ListTile in the drawer
      final recipesTiles = tester.widgetList<ListTile>(
        find.ancestor(
          of: find.text('Recipes'),
          matching: find.byType(ListTile),
        ),
      );

      // At least one Recipes tile should be selected (active route)
      expect(recipesTiles.any((tile) => tile.selected == true), isTrue);
    });

    testWidgets('RecipesView content is centered', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: RecipesView(),
        ),
      );

      // Verify Center widget is used
      expect(find.byType(Center), findsAtLeastNWidgets(1));

      // Verify Padding is applied
      expect(find.byType(Padding), findsAtLeastNWidgets(1));

      // Verify Column layout
      expect(find.byType(Column), findsAtLeastNWidgets(1));
    });
  });
}
