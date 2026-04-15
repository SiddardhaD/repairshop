import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String toFormattedDate() {
    return DateFormat('dd MMM yyyy').format(this);
  }

  String toFormattedDateTime() {
    return DateFormat('dd MMM yyyy, hh:mm a').format(this);
  }

  String toFormattedTime() {
    return DateFormat('hh:mm a').format(this);
  }

  String toRelativeTime() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} ${(difference.inDays / 365).floor() == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} ${(difference.inDays / 30).floor() == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  String toExpectedDeliveryDate() {
    final now = DateTime.now();
    final diff = this.difference(now);

    if (diff.inDays == 0) {
      return 'Today';
    } else if (diff.inDays == 1) {
      return 'Tomorrow';
    } else if (diff.inDays < 7) {
      return 'in ${diff.inDays} days';
    } else {
      return toFormattedDate();
    }
  }

  bool isToday() {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }
}

extension StringExtensions on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String toTitleCase() {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  bool get isValidPhone {
    final phoneRegex = RegExp(r'^\d{10}$');
    return phoneRegex.hasMatch(this);
  }

  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$suffix';
  }
}

extension DoubleExtensions on double {
  String toPercentage({int decimals = 0}) {
    return '${(this * 100).toStringAsFixed(decimals)}%';
  }

  String toCurrency({String symbol = '₹'}) {
    return '$symbol${toStringAsFixed(2)}';
  }
}

extension ListExtensions on List {
  List<T> separatedBy<T>(T separator) {
    if (isEmpty) return [];
    final result = <T>[];
    for (int i = 0; i < length; i++) {
      result.add(this[i] as T);
      if (i < length - 1) {
        result.add(separator);
      }
    }
    return result;
  }
}
