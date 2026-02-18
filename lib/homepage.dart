import 'package:flutter/material.dart';
import 'widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      // place navigation at top and keep the rest of the page content below
      body: Column(
        children: [
          const AppNavigation(bannerText: 'Free delivery on orders over £30'),
          Expanded(
            child: Center(
              child: Text(
                'Homepage content',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ],
=======
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text('Hello! This is the dashboard.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content:
                          Text('Here you can view nutrition information and meal plans!')),
                );
              },
              child: const Text('View Nutrition Information and Meal Plans'),
            ),
          ],
        ),
>>>>>>> origin/main
      ),
    );
  }
}
