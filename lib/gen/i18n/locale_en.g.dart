///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'locale.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations

	/// en: 'Hello'
	String get hello => 'Hello';

	late final TranslationsHomeEn home = TranslationsHomeEn._(_root);
	late final TranslationsSplashEn splash = TranslationsSplashEn._(_root);
	late final TranslationsGameListEn gameList = TranslationsGameListEn._(_root);
	late final TranslationsGameplayEn gameplay = TranslationsGameplayEn._(_root);
	late final TranslationsPauseEn pause = TranslationsPauseEn._(_root);
}

// Path: home
class TranslationsHomeEn {
	TranslationsHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'ZIGLOOM'
	String get title => 'ZIGLOOM';

	/// en: 'Offline logic puzzles'
	String get subtitle => 'Offline logic puzzles';

	/// en: 'Settings'
	String get settings => 'Settings';

	/// en: 'Play'
	String get play => 'Play';

	/// en: 'How To Play'
	String get howToPlay => 'How To Play';

	/// en: 'Privacy Policy'
	String get privacyPolicy => 'Privacy Policy';

	/// en: 'Terms'
	String get terms => 'Terms';

	/// en: '{solved} / {total} solved'
	String get solvedProgress => '{solved} / {total} solved';

	/// en: 'Next: Puzzle {number}'
	String get nextPuzzle => 'Next: Puzzle {number}';

	/// en: 'Ready to start'
	String get readyToStart => 'Ready to start';

	/// en: 'Puzzle {number}'
	String get puzzleNumber => 'Puzzle {number}';

	/// en: 'Puzzle {number} open'
	String get puzzleOpen => 'Puzzle {number} open';

	/// en: 'Puzzle {number} in progress'
	String get inProgress => 'Puzzle {number} in progress';

	/// en: 'All puzzles done'
	String get allPuzzlesDone => 'All puzzles done';

	/// en: '{screen} is coming soon'
	String get comingSoon => '{screen} is coming soon';
}

// Path: splash
class TranslationsSplashEn {
	TranslationsSplashEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'ZIGLOOM'
	String get title => 'ZIGLOOM';

	/// en: 'Offline logic puzzles'
	String get subtitle => 'Offline logic puzzles';

	/// en: 'Loading'
	String get loading => 'Loading';
}

// Path: gameList
class TranslationsGameListEn {
	TranslationsGameListEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Select Level'
	String get title => 'Select Level';

	/// en: 'Back'
	String get back => 'Back';

	/// en: 'Pause'
	String get pauseDemo => 'Pause';

	/// en: '{solved} / {total} solved'
	String get solvedProgress => '{solved} / {total} solved';

	/// en: 'Next: {number}'
	String get nextPuzzle => 'Next: {number}';

	/// en: 'Puzzle {number} is ready'
	String get ready => 'Puzzle {number} is ready';

	/// en: 'Puzzle {number}'
	String get puzzle => 'Puzzle {number}';

	/// en: '{puzzle} is coming soon'
	String get comingSoon => '{puzzle} is coming soon';

	/// en: 'Load Failed'
	String get loadFailed => 'Load Failed';

	/// en: 'Retry'
	String get retry => 'Retry';
}

// Path: gameplay
class TranslationsGameplayEn {
	TranslationsGameplayEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Puzzle {number}'
	String get puzzle => 'Puzzle {number}';

	/// en: 'Pause'
	String get pause => 'Pause';

	/// en: 'Moves {count}'
	String get moves => 'Moves {count}';

	/// en: 'Find {number}'
	String get nextClue => 'Find {number}';

	/// en: 'That square breaks the path'
	String get invalidMove => 'That square breaks the path';

	/// en: 'Solved'
	String get solved => 'Solved';

	/// en: 'Undo'
	String get undo => 'Undo';

	/// en: 'Reset'
	String get reset => 'Reset';

	/// en: 'Settings'
	String get settings => 'Settings';

	/// en: 'Settings is coming soon'
	String get settingsComingSoon => 'Settings is coming soon';

	/// en: 'Load Failed'
	String get loadFailed => 'Load Failed';

	/// en: 'Retry'
	String get retry => 'Retry';
}

// Path: pause
class TranslationsPauseEn {
	TranslationsPauseEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Puzzle {number}'
	String get puzzle => 'Puzzle {number}';

	/// en: 'Paused'
	String get paused => 'Paused';

	/// en: 'Resume'
	String get resume => 'Resume';

	/// en: 'Reset'
	String get reset => 'Reset';

	/// en: 'Settings'
	String get settings => 'Settings';

	/// en: 'Return Home'
	String get returnHome => 'Return Home';

	/// en: 'Reset puzzle?'
	String get resetQuestion => 'Reset puzzle?';

	/// en: 'Your current path for Puzzle {number} will be cleared.'
	String get resetDescription => 'Your current path for Puzzle {number} will be cleared.';

	/// en: 'Reset Puzzle'
	String get resetPuzzle => 'Reset Puzzle';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: '{action} is coming soon'
	String get comingSoon => '{action} is coming soon';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'hello' => 'Hello',
			'home.title' => 'ZIGLOOM',
			'home.subtitle' => 'Offline logic puzzles',
			'home.settings' => 'Settings',
			'home.play' => 'Play',
			'home.howToPlay' => 'How To Play',
			'home.privacyPolicy' => 'Privacy Policy',
			'home.terms' => 'Terms',
			'home.solvedProgress' => '{solved} / {total} solved',
			'home.nextPuzzle' => 'Next: Puzzle {number}',
			'home.readyToStart' => 'Ready to start',
			'home.puzzleNumber' => 'Puzzle {number}',
			'home.puzzleOpen' => 'Puzzle {number} open',
			'home.inProgress' => 'Puzzle {number} in progress',
			'home.allPuzzlesDone' => 'All puzzles done',
			'home.comingSoon' => '{screen} is coming soon',
			'splash.title' => 'ZIGLOOM',
			'splash.subtitle' => 'Offline logic puzzles',
			'splash.loading' => 'Loading',
			'gameList.title' => 'Select Level',
			'gameList.back' => 'Back',
			'gameList.pauseDemo' => 'Pause',
			'gameList.solvedProgress' => '{solved} / {total} solved',
			'gameList.nextPuzzle' => 'Next: {number}',
			'gameList.ready' => 'Puzzle {number} is ready',
			'gameList.puzzle' => 'Puzzle {number}',
			'gameList.comingSoon' => '{puzzle} is coming soon',
			'gameList.loadFailed' => 'Load Failed',
			'gameList.retry' => 'Retry',
			'gameplay.puzzle' => 'Puzzle {number}',
			'gameplay.pause' => 'Pause',
			'gameplay.moves' => 'Moves {count}',
			'gameplay.nextClue' => 'Find {number}',
			'gameplay.invalidMove' => 'That square breaks the path',
			'gameplay.solved' => 'Solved',
			'gameplay.undo' => 'Undo',
			'gameplay.reset' => 'Reset',
			'gameplay.settings' => 'Settings',
			'gameplay.settingsComingSoon' => 'Settings is coming soon',
			'gameplay.loadFailed' => 'Load Failed',
			'gameplay.retry' => 'Retry',
			'pause.puzzle' => 'Puzzle {number}',
			'pause.paused' => 'Paused',
			'pause.resume' => 'Resume',
			'pause.reset' => 'Reset',
			'pause.settings' => 'Settings',
			'pause.returnHome' => 'Return Home',
			'pause.resetQuestion' => 'Reset puzzle?',
			'pause.resetDescription' => 'Your current path for Puzzle {number} will be cleared.',
			'pause.resetPuzzle' => 'Reset Puzzle',
			'pause.cancel' => 'Cancel',
			'pause.comingSoon' => '{action} is coming soon',
			_ => null,
		};
	}
}
