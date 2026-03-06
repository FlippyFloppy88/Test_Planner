import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/home/home_screen.dart';
import '../screens/test_plans/test_plans_screen.dart';
import '../screens/test_plans/test_plan_detail_screen.dart';
import '../screens/test_plans/test_case_editor_screen.dart';
import '../screens/release_plans/release_plans_screen.dart';
import '../screens/release_plans/release_plan_detail_screen.dart';
import '../screens/execution/execution_screen.dart';
import '../screens/execution/execution_complete_screen.dart';
import '../screens/results/results_screen.dart';
import '../screens/results/result_detail_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),

        // Test Plans
        GoRoute(
          path: '/test-plans',
          name: 'test-plans',
          builder: (context, state) => const TestPlansScreen(),
          routes: [
            GoRoute(
              path: ':planId',
              name: 'test-plan-detail',
              builder: (context, state) => TestPlanDetailScreen(
                planId: state.pathParameters['planId']!,
              ),
              routes: [
                GoRoute(
                  path: 'case/:caseId',
                  name: 'test-case-editor',
                  builder: (context, state) => TestCaseEditorScreen(
                    planId: state.pathParameters['planId']!,
                    caseId: state.pathParameters['caseId']!,
                  ),
                ),
              ],
            ),
          ],
        ),

        // Release Plans
        GoRoute(
          path: '/release-plans',
          name: 'release-plans',
          builder: (context, state) => const ReleasePlansScreen(),
          routes: [
            GoRoute(
              path: ':planId',
              name: 'release-plan-detail',
              builder: (context, state) => ReleasePlanDetailScreen(
                planId: state.pathParameters['planId']!,
              ),
            ),
          ],
        ),

        // Test Execution
        GoRoute(
          path: '/execution',
          name: 'execution',
          builder: (context, state) => const ExecutionScreen(),
        ),
        GoRoute(
          path: '/execution/complete',
          name: 'execution-complete',
          builder: (context, state) => const ExecutionCompleteScreen(),
        ),

        // Results
        GoRoute(
          path: '/results',
          name: 'results',
          builder: (context, state) => const ResultsScreen(),
          routes: [
            GoRoute(
              path: ':runId',
              name: 'result-detail',
              builder: (context, state) => ResultDetailScreen(
                runId: state.pathParameters['runId']!,
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);

class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  static const _destinations = [
    (
      path: '/',
      label: 'Home',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home
    ),
    (
      path: '/test-plans',
      label: 'Test Plans',
      icon: Icons.checklist_outlined,
      selectedIcon: Icons.checklist
    ),
    (
      path: '/release-plans',
      label: 'Release Plans',
      icon: Icons.rocket_launch_outlined,
      selectedIcon: Icons.rocket_launch
    ),
    (
      path: '/results',
      label: 'Results',
      icon: Icons.bar_chart_outlined,
      selectedIcon: Icons.bar_chart
    ),
  ];

  int _selectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/results')) return 3;
    if (location.startsWith('/release-plans')) return 2;
    if (location.startsWith('/test-plans')) return 1;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final selected = _selectedIndex(context);
    final extended = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selected,
            extended: extended,
            onDestinationSelected: (idx) {
              context.go(_destinations[idx].path);
            },
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Icon(Icons.science,
                      color: Theme.of(context).colorScheme.primary, size: 32),
                  const SizedBox(height: 4),
                  if (extended)
                    Text(
                      'Test Planner',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                ],
              ),
            ),
            destinations: _destinations
                .map((d) => NavigationRailDestination(
                      icon: Icon(d.icon),
                      selectedIcon: Icon(d.selectedIcon),
                      label: Text(d.label),
                    ))
                .toList(),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: child),
        ],
      ),
    );
  }
}
