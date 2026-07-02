///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'locale.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';

// Path: <root>
class TranslationsVi with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsVi({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.vi,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <vi>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsVi _root = this; // ignore: unused_field

	@override 
	TranslationsVi $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsVi(meta: meta ?? this.$meta);

	// Translations
	@override String get hello => 'Xin chào';
	@override late final _TranslationsHomeVi home = _TranslationsHomeVi._(_root);
	@override late final _TranslationsSplashVi splash = _TranslationsSplashVi._(_root);
	@override late final _TranslationsGameListVi gameList = _TranslationsGameListVi._(_root);
	@override late final _TranslationsGameplayVi gameplay = _TranslationsGameplayVi._(_root);
	@override late final _TranslationsPauseVi pause = _TranslationsPauseVi._(_root);
	@override late final _TranslationsHowToPlayVi howToPlay = _TranslationsHowToPlayVi._(_root);
	@override late final _TranslationsSettingsVi settings = _TranslationsSettingsVi._(_root);
}

// Path: home
class _TranslationsHomeVi implements TranslationsHomeEn {
	_TranslationsHomeVi._(this._root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'ZIGLOOM';
	@override String get subtitle => 'Câu đố logic ngoại tuyến';
	@override String get settings => 'Cài đặt';
	@override String get play => 'Chơi';
	@override String get howToPlay => 'Cách chơi';
	@override String get privacyPolicy => 'Chính sách bảo mật';
	@override String get terms => 'Điều khoản';
	@override String get solvedProgress => '{solved} / {total} đã giải';
	@override String get nextPuzzle => 'Tiếp theo: Màn {number}';
	@override String get readyToStart => 'Sẵn sàng bắt đầu';
	@override String get puzzleNumber => 'Màn {number}';
	@override String get puzzleOpen => 'Màn {number} đang mở';
	@override String get inProgress => 'Màn {number} đang chơi';
	@override String get allPuzzlesDone => 'Đã hoàn thành tất cả';
	@override String get comingSoon => '{screen} sắp ra mắt';
}

// Path: splash
class _TranslationsSplashVi implements TranslationsSplashEn {
	_TranslationsSplashVi._(this._root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'ZIGLOOM';
	@override String get subtitle => 'Câu đố logic ngoại tuyến';
	@override String get loading => 'Đang tải';
}

// Path: gameList
class _TranslationsGameListVi implements TranslationsGameListEn {
	_TranslationsGameListVi._(this._root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Chọn màn';
	@override String get back => 'Quay lại';
	@override String get pauseDemo => 'Tạm dừng';
	@override String get solvedProgress => '{solved} / {total} đã giải';
	@override String get nextPuzzle => 'Tiếp: {number}';
	@override String get ready => 'Màn {number} đã sẵn sàng';
	@override String get puzzle => 'Màn {number}';
	@override String get comingSoon => '{puzzle} sắp ra mắt';
	@override String get loadFailed => 'Tải thất bại';
	@override String get retry => 'Thử lại';
}

// Path: gameplay
class _TranslationsGameplayVi implements TranslationsGameplayEn {
	_TranslationsGameplayVi._(this._root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get puzzle => 'Màn {number}';
	@override String get pause => 'Tạm dừng';
	@override String get moves => '{count} nước';
	@override String get nextClue => 'Tìm {number}';
	@override String get invalidMove => 'Ô này làm đứt đường đi';
	@override String get solved => 'Đã giải';
	@override String get winTitle => 'Qua màn';
	@override String get winMessage => 'Một đường đi hoàn chỉnh từ đầu đến cuối.';
	@override String get winTime => 'Thời gian';
	@override String get winMoves => 'Nước đi';
	@override String get nextLevel => 'Màn tiếp';
	@override String get chooseLevel => 'Chọn màn';
	@override String get playAgain => 'Chơi lại';
	@override String get undo => 'Hoàn tác';
	@override String get reset => 'Đặt lại';
	@override String get howToPlay => 'Cách chơi';
	@override String get settings => 'Cài đặt';
	@override String get settingsComingSoon => 'Cài đặt sắp ra mắt';
	@override String get loadFailed => 'Tải thất bại';
	@override String get retry => 'Thử lại';
}

// Path: pause
class _TranslationsPauseVi implements TranslationsPauseEn {
	_TranslationsPauseVi._(this._root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get puzzle => 'Màn {number}';
	@override String get paused => 'Tạm dừng';
	@override String get resume => 'Tiếp tục';
	@override String get replay => 'Chơi lại';
	@override String get settings => 'Cài đặt';
	@override String get returnHome => 'Về trang chủ';
	@override String get replayQuestion => 'Chơi lại màn?';
	@override String get replayDescription => 'Đường đi hiện tại của Màn {number} sẽ bị xóa.';
	@override String get replayPuzzle => 'Chơi lại màn';
	@override String get cancel => 'Hủy';
	@override String get comingSoon => '{action} sắp ra mắt';
}

// Path: howToPlay
class _TranslationsHowToPlayVi implements TranslationsHowToPlayEn {
	_TranslationsHowToPlayVi._(this._root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cách chơi';
	@override String get back => 'Quay lại';
	@override String get intro => 'Lấp đầy bàn bằng một đường đi liên tục.';
	@override String get rulesTitle => 'Luật chơi';
	@override String get ruleStart => 'Bắt đầu từ 1.';
	@override String get ruleOrder => 'Nối các số theo thứ tự.';
	@override String get ruleMove => 'Đi lên, xuống, trái hoặc phải.';
	@override String get ruleCover => 'Dùng mỗi ô đúng một lần.';
	@override String get avoidTitle => 'Tránh';
	@override String get avoidGaps => 'Bỏ trống ô';
	@override String get avoidRepeats => 'Lặp lại ô';
	@override String get avoidDiagonal => 'Đi chéo';
	@override String get avoidEarlyNumber => 'Đi vào số sau quá sớm';
	@override String get backToPuzzle => 'Quay lại màn chơi';
}

// Path: settings
class _TranslationsSettingsVi implements TranslationsSettingsEn {
	_TranslationsSettingsVi._(this._root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cài đặt';
	@override String get back => 'Quay lại';
	@override String get appearance => 'Giao diện';
	@override String get theme => 'Chủ đề';
	@override String get system => 'Hệ thống';
	@override String get light => 'Sáng';
	@override String get dark => 'Tối';
	@override String get play => 'Chơi';
	@override String get sound => 'Âm thanh';
	@override String get haptics => 'Rung';
	@override String get on => 'Bật';
	@override String get off => 'Tắt';
	@override String get language => 'Ngôn ngữ';
	@override String get english => 'Tiếng Anh';
	@override String get vietnamese => 'Tiếng Việt';
	@override String get howToPlay => 'Cách chơi';
	@override String get privacyPolicy => 'Chính sách bảo mật';
	@override String get terms => 'Điều khoản';
}

/// The flat map containing all translations for locale <vi>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsVi {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'hello' => 'Xin chào',
			'home.title' => 'ZIGLOOM',
			'home.subtitle' => 'Câu đố logic ngoại tuyến',
			'home.settings' => 'Cài đặt',
			'home.play' => 'Chơi',
			'home.howToPlay' => 'Cách chơi',
			'home.privacyPolicy' => 'Chính sách bảo mật',
			'home.terms' => 'Điều khoản',
			'home.solvedProgress' => '{solved} / {total} đã giải',
			'home.nextPuzzle' => 'Tiếp theo: Màn {number}',
			'home.readyToStart' => 'Sẵn sàng bắt đầu',
			'home.puzzleNumber' => 'Màn {number}',
			'home.puzzleOpen' => 'Màn {number} đang mở',
			'home.inProgress' => 'Màn {number} đang chơi',
			'home.allPuzzlesDone' => 'Đã hoàn thành tất cả',
			'home.comingSoon' => '{screen} sắp ra mắt',
			'splash.title' => 'ZIGLOOM',
			'splash.subtitle' => 'Câu đố logic ngoại tuyến',
			'splash.loading' => 'Đang tải',
			'gameList.title' => 'Chọn màn',
			'gameList.back' => 'Quay lại',
			'gameList.pauseDemo' => 'Tạm dừng',
			'gameList.solvedProgress' => '{solved} / {total} đã giải',
			'gameList.nextPuzzle' => 'Tiếp: {number}',
			'gameList.ready' => 'Màn {number} đã sẵn sàng',
			'gameList.puzzle' => 'Màn {number}',
			'gameList.comingSoon' => '{puzzle} sắp ra mắt',
			'gameList.loadFailed' => 'Tải thất bại',
			'gameList.retry' => 'Thử lại',
			'gameplay.puzzle' => 'Màn {number}',
			'gameplay.pause' => 'Tạm dừng',
			'gameplay.moves' => '{count} nước',
			'gameplay.nextClue' => 'Tìm {number}',
			'gameplay.invalidMove' => 'Ô này làm đứt đường đi',
			'gameplay.solved' => 'Đã giải',
			'gameplay.winTitle' => 'Qua màn',
			'gameplay.winMessage' => 'Một đường đi hoàn chỉnh từ đầu đến cuối.',
			'gameplay.winTime' => 'Thời gian',
			'gameplay.winMoves' => 'Nước đi',
			'gameplay.nextLevel' => 'Màn tiếp',
			'gameplay.chooseLevel' => 'Chọn màn',
			'gameplay.playAgain' => 'Chơi lại',
			'gameplay.undo' => 'Hoàn tác',
			'gameplay.reset' => 'Đặt lại',
			'gameplay.howToPlay' => 'Cách chơi',
			'gameplay.settings' => 'Cài đặt',
			'gameplay.settingsComingSoon' => 'Cài đặt sắp ra mắt',
			'gameplay.loadFailed' => 'Tải thất bại',
			'gameplay.retry' => 'Thử lại',
			'pause.puzzle' => 'Màn {number}',
			'pause.paused' => 'Tạm dừng',
			'pause.resume' => 'Tiếp tục',
			'pause.replay' => 'Chơi lại',
			'pause.settings' => 'Cài đặt',
			'pause.returnHome' => 'Về trang chủ',
			'pause.replayQuestion' => 'Chơi lại màn?',
			'pause.replayDescription' => 'Đường đi hiện tại của Màn {number} sẽ bị xóa.',
			'pause.replayPuzzle' => 'Chơi lại màn',
			'pause.cancel' => 'Hủy',
			'pause.comingSoon' => '{action} sắp ra mắt',
			'howToPlay.title' => 'Cách chơi',
			'howToPlay.back' => 'Quay lại',
			'howToPlay.intro' => 'Lấp đầy bàn bằng một đường đi liên tục.',
			'howToPlay.rulesTitle' => 'Luật chơi',
			'howToPlay.ruleStart' => 'Bắt đầu từ 1.',
			'howToPlay.ruleOrder' => 'Nối các số theo thứ tự.',
			'howToPlay.ruleMove' => 'Đi lên, xuống, trái hoặc phải.',
			'howToPlay.ruleCover' => 'Dùng mỗi ô đúng một lần.',
			'howToPlay.avoidTitle' => 'Tránh',
			'howToPlay.avoidGaps' => 'Bỏ trống ô',
			'howToPlay.avoidRepeats' => 'Lặp lại ô',
			'howToPlay.avoidDiagonal' => 'Đi chéo',
			'howToPlay.avoidEarlyNumber' => 'Đi vào số sau quá sớm',
			'howToPlay.backToPuzzle' => 'Quay lại màn chơi',
			'settings.title' => 'Cài đặt',
			'settings.back' => 'Quay lại',
			'settings.appearance' => 'Giao diện',
			'settings.theme' => 'Chủ đề',
			'settings.system' => 'Hệ thống',
			'settings.light' => 'Sáng',
			'settings.dark' => 'Tối',
			'settings.play' => 'Chơi',
			'settings.sound' => 'Âm thanh',
			'settings.haptics' => 'Rung',
			'settings.on' => 'Bật',
			'settings.off' => 'Tắt',
			'settings.language' => 'Ngôn ngữ',
			'settings.english' => 'Tiếng Anh',
			'settings.vietnamese' => 'Tiếng Việt',
			'settings.howToPlay' => 'Cách chơi',
			'settings.privacyPolicy' => 'Chính sách bảo mật',
			'settings.terms' => 'Điều khoản',
			_ => null,
		};
	}
}
