import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web/web.dart' as web;

import '../core/fb.dart';

import '../features/admin/admin_portal.dart';
import '../features/vendor/vendor_portal.dart';
import 'theme.dart';

final appRouter = GoRouter(
  redirect: (c, s) {
    if (areaFor(s.uri.path) != Fb.area) {
      // Full page load so the target area starts with its own login session.
      web.window.location.assign(s.uri.toString());
    }
    return null;
  },
  routes: [
    GoRoute(path: '/', builder: (c, s) => const AdminPortal()),
    GoRoute(path: '/admin', builder: (c, s) => const AdminPortal()),
    GoRoute(path: '/vendor', builder: (c, s) => const VendorPortal()),
  ],
  errorBuilder: (c, s) => Scaffold(
    body: Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('🔒', style: TextStyle(fontSize: 64)),
        const SizedBox(height: 12),
        Text('Page not found', style: AppTheme.display(30)),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () => c.go('/'), child: const Text('Back to Dashboard')),
      ]),
    ),
  ),
);
