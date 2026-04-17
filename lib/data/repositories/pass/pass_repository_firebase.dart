import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ux_final_project/config/firebase_config.dart';
import 'package:ux_final_project/data/repositories/pass/pass_repository.dart';
import 'package:ux_final_project/models/pass/pass_model.dart';
import 'package:ux_final_project/models/pass/pass_plan_model.dart';

class PassRepositoryFirebase implements PassRepository {
	final Uri passPlansUri = FirebaseConfig.baseUri.replace(path: '/passPlans.json');
	Pass? _activePass;

	@override
	Future<List<PassPlan>> fetchPassPlans() async {
		final response = await http.get(passPlansUri);

		if (response.statusCode != 200) {
			throw Exception('Failed to load pass plans');
		}

		final body = json.decode(response.body);
		if (body == null) return [];

		final plansJson = body as Map<String, dynamic>;
		final plans = plansJson.values.map((planJson) {
			final plan = planJson as Map<String, dynamic>;
			return PassPlan(
				type: PassType.values.firstWhere(
					(type) => type.name == plan['type'] as String,
				),
				title: plan['title'] as String,
				price: plan['price'] as String,
				validityLabel: plan['validityLabel'] as String,
			);
		}).toList();

		plans.sort((a, b) => a.type.index.compareTo(b.type.index));
		return plans;
	}

	@override
	Future<Pass?> getActivePass() async {
		return _activePass;
	}

	static Duration _durationFor(PassType type) {
		switch (type) {
			case PassType.day:
				return const Duration(days: 1);
			case PassType.monthly:
				return const Duration(days: 30);
			case PassType.annual:
				return const Duration(days: 365);
		}
	}

	@override
	Future<void> buyPass(PassType pass) async {
		final now = DateTime.now();
		_activePass = Pass(
			type: pass,
			startDate: now,
			expirationDate: now.add(_durationFor(pass)),
		);
	}

	@override
	Future<void> cancelPass() async {
		_activePass = null;
	}
}
