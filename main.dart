import 'dart:io';
import 'dart:math';

class Cache {
  final List<CacheEntry> _entries = [];

  void generate() {
    final random = Random();
    final key = random.nextInt(10);
    final value = _generateRandomString(4);
    _entries.add(CacheEntry(key: key, value: value));
  }

  void fill() {
    for (var i = 0; i < 6; i++) {
      generate();
    }
  }

  void refer(int key) {
    final entry = _entries.firstWhere((e) => e.key == key);
    if (entry != null) {
      print('Key: ${entry.key}, Value: ${entry.value}');
      entry.referrals -= 1;
      if (entry.referrals == 0) {
        _entries.remove(entry);
        generate();
      } else {
        _printCache();
      }
    } else {
      print('Entry not found with key $key');
      _printCache();
    }
  }

  String _generateRandomString(int length) {
    const availableChars = 'qwertyuiopasdfghjklzxcvbnm';
    final random = Random();
    final randomString = StringBuffer();

    for (int i = 0; i < length; i++) {
      final randomIndex = random.nextInt(availableChars.length);
      randomString.write(availableChars[randomIndex]);
    }

    return randomString.toString();
  }

  void _printCache() {
    print('Cache contents:');
    for (final entry in _entries) {
      print('${entry.key}:${entry.value}, ${entry.referrals}');
    }
  }

  Cache() {
    fill();
  }
}

class CacheEntry {
  final int key;
  final String value;
  int referrals;

  CacheEntry({required this.key, required this.value, this.referrals = 5});
}

void main() {
  Cache cache = Cache();
  cache._printCache();

  cache.refer(6);
  var line = stdin.readLineSync();
  print(line.toString());
}
