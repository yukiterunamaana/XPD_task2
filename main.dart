import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

class Cache {
  final List<CacheEntry> _entries = [];

  void generate() {
    final random = Random();
    final key = random.nextInt(10);

    final value = StringBuffer();
    const asciiDecoder = AsciiDecoder();
    for (int i = 0; i < 5; i++) {
      final randomIndex = random.nextInt(26) + 65;
      value.write(asciiDecoder.convert([randomIndex]));
    }
    _entries.add(CacheEntry(key: key, value: value.toString()));
  }

  void fill() {
    for (var i = 0; i < 5; i++) {
      generate();
    }
  }

  void refer(int key) {
    final entry = _entries.firstWhere((e) => e.key == key);
    print('Key: ${entry.key}, Value: ${entry.value}');
    entry.referrals -= 1;
    if (entry.referrals == 0) {
      _entries.remove(entry);
      generate();
    } else {
      _printCache();
    }
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

  //cache.refer(6);
  var line = stdin.readLineSync();
  print(line.toString());
}
