import 'package:bulmaca_motoru/bulmaca_motoru.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oyun_heyawake/oyun_heyawake.dart';
import 'package:studio_core/core/level_plan.dart';

void main() {
  test('33 dilde ad ve anlatım', () {
    expect(odalarConfig.title.length, 33);
    expect(odalarConfig.tagline.length, 33);
    for (final s in odalarConfig.tutorial) {
      expect(s.text.length, 33);
    }
  });

  test('bölümler üretilir, doğrulanır ve kaydedilip geri yüklenir', () {
    final planner = LevelPlanner(gameId: odalarId, optionalMechanics: const []);
    for (final lv in [1, 77, 1500, 33333, 99999]) {
      final gl = odalarRules.build(planner.spec(lv));
      expect(gl.validation.ok, isTrue, reason: 'bölüm $lv');
      final k = odalarRules.kindForLevel(gl.spec.difficulty);
      final start = k.initial(gl.puzzle);
      expect(PState.restore(start.serialize(), gl.puzzle), isNotNull);
      expect(PLevel.fromJson(gl.puzzle.toJson()).toJson().toString(), gl.puzzle.toJson().toString());
    }
  });
}
