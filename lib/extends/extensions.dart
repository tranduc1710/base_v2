import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../config/style.dart';
import 'inherited.dart';

extension ObjectExtensions<O> on O {
  /// Tao bien voi kieu du lieu ValueNotifier
  ///
  /// Neu muon tao bien voi gia tri null thi ghi nhu sau:
  /// final variable = ValueNotifier<Object>(null);
  ValueNotifier<O> get vn => ValueNotifier<O>(this);
}

extension ObjectNullExtensions<O> on O? {
  /// Get bool tu bien
  bool getBool([bool value = false]) => this is bool? ? (this as bool?).value : bool.tryParse(toString()) ?? value;

  /// Get int tu bien
  double getDouble([double value = 0, double maxvalue = 2000000000]) {
    if (this is double?) {
      return (this as double?).value;
    }
    try {
      return toString().isEmpty ? value : double.parse(toString());
    } catch (e) {
      if (e.runtimeType == FormatException) {
        return maxvalue;
      }
      return value;
    }
  }

  /// Get int tu bien
  int getInt([int value = 0, int maxvalue = 2000000000]) {
    if (this is int?) {
      return (this as int?).value;
    }
    try {
      return toString().isEmpty ? value : int.parse(toString());
    } catch (e) {
      if (e.runtimeType == FormatException) {
        return maxvalue;
      }
      return value;
    }
  }
}

extension ValueNotifierListExtension<T> on ValueNotifier<List<T>?> {
  void refresh() {
    // Gán lại giá trị bằng một bản sao mới của danh sách
    value = value.getList.toList();
  }
}

extension ListNullExtensions<O> on List<O>? {
  /// Get list tu bien list co the null
  List<O> get getList => this is List<O> ? this! : <O>[];
}

extension ListExtensions<O> on List<O> {
  /// fake du lieu voi moi truong debug
  /// moi truong that lay gia tri mac dinh la list trong
  List<O> get fakeData => kDebugMode ? this : <O>[];
}

extension NumExtensions on num {
  /// Ham delay
  Future delayed([FutureOr Function()? computation]) async => await Future.delayed(
        Duration(milliseconds: (this * 1000).toInt()),
        computation,
      );
}

extension DoubleNullExtensions on double? {
  /// Get double tu bien null
  double get value => this ?? 0;
}

extension DoubleExtensions on double {
  /// fake du lieu voi moi truong debug
  /// moi truong that lay gia tri mac dinh la 0
  double get fakeData => kDebugMode ? this : 0;
}

extension DoubleFormatExtension on double {
  String formatWithComma({String? comma}) {
    final NumberFormat numberFormat = NumberFormat(comma ?? "#,###.##");
    return numberFormat.format(this);
  }
}

extension IntNullExtensions on int? {
  /// Get int tu bien null
  int get value => this ?? 0;

  String get valueString => "${this ?? 0}";

  /// Format ngày dạng Timestamp sang string với [format]
  String toDateStrFromTimestamp({String? format, bool? isUTC}) {
    if (this == null) return "";
    final date = DateTime.fromMillisecondsSinceEpoch(this!, isUtc: isUTC.value);
    final formattedDate = DateFormat(format ?? 'dd/MM/yyyy - HH:mm').format(date);
    return formattedDate;
  }
}

extension IntFormatExtension on int {
  String formatWithComma() {
    final NumberFormat numberFormat = NumberFormat("#,###");
    return numberFormat.format(this);
  }
}

extension IntExtensions on int {
  /// fake du lieu voi moi truong debug
  /// moi truong that lay gia tri mac dinh la 0
  int get fakeData => kDebugMode ? this : 0;
}

extension BoolNullExtensions on bool? {
  /// Get bool tu bien null
  bool get value => this ?? false;
}

extension FormatCurrencyEx on dynamic {
  /// ham chuyen doi so sang tien
  String toVND({String? unit = '', String thousandSeparator = ','}) {
    num number = this is String
        ? double.parse(this ?? 0)
        : this is num
            ? this
            : 0;
    unit = unit == 'đ' ? '₫' : unit;
    var vietNamFormatCurrency = NumberFormat.currency(locale: "vi-VN", symbol: unit);
    return vietNamFormatCurrency.format(number).trim().replaceAll('.', thousandSeparator);
  }
}

extension DateTimeExtensions on DateTime {
  /// Chuyển đổi một đối tượng `DateTime` sang `String` với định dạng tùy chỉnh.
  ///
  /// - **Định dạng mặc định:** `"dd/MM/yyyy"`.
  /// - **Tham số:**
  ///   - `format` (String): Định dạng chuỗi đầu ra. Mặc định là `"dd/MM/yyyy"`.
  ///   - `includeTimeZone` (bool): Nếu `true`, thêm múi giờ vào kết quả.
  ///     - Nếu là UTC, kết quả sẽ chứa ký hiệu `Z`.
  ///     - Nếu là local time, múi giờ sẽ ở định dạng `+HH:mm` hoặc `-HH:mm`.
  ///
  /// ### Ví dụ:
  ///
  /// - **Không có múi giờ:**
  ///   ```dart
  ///   print(DateTime.now().withFormat());
  ///   // Kết quả: "21/11/2024"
  ///   ```
  ///
  /// - **Định dạng tùy chỉnh với múi giờ:**
  ///   ```dart
  ///   print(DateTime.now().withFormat(format: "yyyy-MM-ddTHH:mm:ss", includeTimeZone: true));
  ///   // Kết quả: "2024-11-21T15:30:45+07:00"
  ///   ```
  ///
  /// - **Thời gian UTC:**
  ///   ```dart
  ///   print(DateTime.now().toUtc().withFormat(format: "yyyy-MM-ddTHH:mm:ss", includeTimeZone: true));
  ///   // Kết quả: "2024-11-21T08:30:45Z"
  ///   ```
  String withFormat({String format = "dd/MM/yyyy", bool includeTimeZone = false}) {
    var formattedDate = DateFormat(format).format(this);
    if (!includeTimeZone) {
      return formattedDate;
    }

    // Tính toán múi giờ (ví dụ: "+07:00")
    final timeZoneOffset = isUtc ? "Z" : _formatTimeZoneOffset();

    return "$formattedDate$timeZoneOffset";
  }

  /// Format múi giờ dưới dạng "+HH:mm" hoặc "-HH:mm"
  String _formatTimeZoneOffset() {
    final duration = timeZoneOffset; // Lấy thông tin múi giờ
    final hours = duration.inHours.abs().toString().padLeft(2, '0'); // Số giờ offset
    final minutes = (duration.inMinutes.abs() % 60).toString().padLeft(2, '0'); // Số phút offset
    final sign = duration.isNegative ? '-' : '+'; // Dấu của múi giờ
    return "$sign$hours:$minutes";
  }

  /// doi sang String dinh dang gio:phut
  String withTimeFormat([String? format]) {
    format ??= "HH:mm";
    return DateFormat(format).format(this);
  }

  DateTime? get fakeData => kDebugMode ? this : null;
}

extension StringExtensions on String {
  /// fake du lieu voi moi truong debug
  /// moi truong that lay gia tri mac dinh la trong
  String get fakeData => kDebugMode ? this : '';

  String maxLength(int max) => length > max ? substring(0, max) : this;

  /// tao widget tu String
  Widget wText({TextStyle? style, int? maxLength, TextAlign? textAlign, int? maxLines, TextOverflow? overflow, bool? softWrap}) => Text(
        maxLength == null || maxLength == 0 || length > maxLength.abs() ? this : '${substring(0, maxLength.abs())}...',
        style: style ?? AppStyle.normal,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        softWrap: softWrap,
      );

  /// Tao widget text voi required
  Widget wTextRequired({TextStyle? style}) => RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: this,
              style: style ?? AppStyle.normal,
            ),
            TextSpan(
              text: " *",
              style: (style ?? AppStyle.normal).copyWith(color: Colors.red),
            ),
          ],
        ),
      );

  /// tao widget text voi 2 cham va required
  Widget wTextColonRequired({TextStyle? style}) => RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$this:",
              style: style ?? AppStyle.normal,
            ),
            TextSpan(
              text: " *",
              style: (style ?? AppStyle.normal).copyWith(color: Colors.red),
            ),
          ],
        ),
      );

  /// Them hai cham vao string
  String get colon => "$this: ";

  /// Them * vao string
  String get required => "$this *";
}

extension StringNullExtensions on String? {
  /// Get String tu bien co the null
  String get value => this ?? '';

  /// Doi String sang dinh dang ngay thang
  String toDateTime({String? format}) {
    if (this == null) return "";
    final dateTime = DateTime.tryParse(this!);
    format ??= "dd/MM/yyyy";
    return dateTime?.withFormat(format: format) ?? '';
  }
}

extension FunctionExtensions on Function() {
  void postFrame() => WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) => this());
}

extension BuildContextExtensions on BuildContext {
  /// hien thi toast
  void toast({
    required String message,
    TextStyle? textStyle,
    Color? backgroundColor,
    double? borderRadius,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      padding: EdgeInsets.all(30),
      elevation: 0,
      content: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(borderRadius ?? 17),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            borderRadius: BorderRadius.circular(borderRadius ?? 17),
          ),
          child: message.wText(
            style: textStyle ?? AppStyle.normal,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
    ));
  }

  /// Goi InheritedWidget tu context
  T inherited<T extends InheritedWidget>() => AppInherited.of<T>(this);
}

extension WidgetExtensions on Widget {
  /// padding widget
  Widget wPadding([EdgeInsets? edgeInsets]) => Padding(
        padding: edgeInsets ?? EdgeInsets.zero,
        child: this,
      );

  /// center widget
  Widget wCenter() => Center(child: this);

  /// Expanded widget
  Widget wExpanded([int flex = 1]) => Expanded(
        flex: flex,
        child: this,
      );

  /// add unfocus into widget
  Widget wUnFocus() => GestureDetector(
        child: this,
        onTap: () => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(),
        onHorizontalDragCancel: () => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(),
      );

  /// add function click into widget
  Widget wOnTap(
    Function()? onTap, {
    Decoration? decoration,
    double? width,
    BorderRadius? borderRadius,
    Function()? onLongPress,
  }) =>
      Ink(
        width: width,
        decoration: decoration,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: borderRadius ?? BorderRadius.circular(7),
          child: this,
        ),
      );
}

extension ScafoldExtensions on Scaffold {
  Widget removeFocus(BuildContext context) => Scaffold(
        appBar: appBar,
        floatingActionButton: floatingActionButton,
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        bottomNavigationBar: bottomNavigationBar,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: SafeArea(
            bottom: false,
            child: body ??
                Container(
                  color: Colors.transparent,
                ),
          ),
        ),
      );
}

extension AppBarExtensions on AppBar {
  PreferredSizeWidget get gradientBackground => AppBar(
        title: title,
        actions: actions,
        centerTitle: centerTitle,
        leadingWidth: leadingWidth,
        leading: leading,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: <Color>[Color(0xFF074CBE), Color(0xFF0C4199), Color(0xFF0C4199)]),
          ),
        ),
      );
}

extension MapExtensions<K, V> on Map<K, V> {
  /// Loai bo cac thuoc tinh null trong Map
  Map<K, V> get withOutNull {
    final valueMap = <K, V>{};

    for (final item in entries) {
      if (item.value != null) {
        valueMap[item.key] = item.value;
      }
    }

    return valueMap;
  }

  /// Loai bo cac thuoc tinh null trong Map
  Map<K, V> get withOutNullAll {
    final valueMap = <K, V>{};

    for (final item in entries) {
      if (item.value is Map) {
        valueMap[item.key] = (item.value as Map).withOutNullAll as V;
      } else if (item.value is List) {
        valueMap[item.key] = (item.value as List).map(
          (e) {
            if (e is Map) {
              return e.withOutNullAll;
            } else {
              return e;
            }
          },
        ).toList() as V;
      } else if (item.value != null) {
        valueMap[item.key] = item.value;
      }
    }

    return valueMap;
  }

  /// Sap xep map theo bang chu cai
  Map<K, V> get sort {
    final list = entries.toList();
    list.sort(
      (a, b) => a.key.toString().compareTo(b.key.toString()),
    );

    final valueMap = <K, V>{};

    for (final item in list) {
      if (item.value is Map) {
        valueMap[item.key] = (item.value as Map<K, V>).sort as V;
      } else {
        valueMap[item.key] = item.value;
      }
    }

    return valueMap;
  }
}

extension IterableExtensions<T> on Iterable<T> {
  /// Merge list va list ben trong
  Iterable<TRes> mapMany<TRes>(Iterable<TRes>? Function(T item) selector) sync* {
    for (var item in this) {
      final res = selector(item);
      if (res != null) yield* res;
    }
  }
}

extension ValueListenableNumToString<T> on ValueListenable<T> {
  Widget toStringText({
    TextStyle? style,
    int? maxLength,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
  }) {
    return ValueListenableBuilder(
      valueListenable: this,
      builder: (context, value, child) => value.toString().wText(
            style: style,
            textAlign: textAlign,
            maxLines: maxLines,
            maxLength: maxLength,
            overflow: overflow,
            softWrap: softWrap,
          ),
    );
  }

  Widget toWidget(Widget Function(BuildContext context, T value) builder) {
    return ValueListenableBuilder(
      valueListenable: this,
      builder: (context, value, child) => builder(context, value),
    );
  }
}
