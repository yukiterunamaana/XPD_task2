// // class CacheEntry {
// //   final int key;
// //   final String value;
// //   int referrals;
// //   CacheEntry({required this.key, required this.value, this.referrals = 5});
// // }

// // class Cache {
// //   late List<CacheEntry> entries;
// //   Cache();

// //   void fill
// // }

// // void main() {}
// import 'dart:io';
// import 'dart:math';

// class Cache {
//   final List<CacheEntry> _entries = [];

//   void generate() {
//     final random = Random();
//     final key = random.nextInt(10);
//     final value = _generateRandomString(4);
//     _entries.add(CacheEntry(key: key, value: value));
//   }

//   void refer(int key) {
//     final entry = _entries.firstWhere((e) => e.key == key);
//     if (entry != null) {
//       print('Key: ${entry.key}, Value: ${entry.value}');
//       entry.referrals -= 1;
//       if (entry.referrals == 0) {
//         _entries.remove(entry);
//         generate();
//       }
//     } else {
//       print('Entry not found with key $key');
//     }
//   }

//   String _generateRandomString(int length) {
//     const availableChars =
//         'QWERTYUIOPASDFGHJKLZXCVBNM';
//     final random = Random();
//     final randomString = StringBuffer();

//     for (int i = 0; i < length; i++) {
//       final randomIndex = random.nextInt(availableChars.length);
//       randomString.write(availableChars[randomIndex]);
//     }

//     return randomString.toString();
//   }
//   void run() {
//     while (true) {
//       stdout.write('Enter a command (generate/refer <key>/exit): ');
//       final input = stdin.readLineSync() ?? '';
//       final parts = input.split(' ');

//       if (parts[0] == 'generate') {
//         generate();
//       } else if (parts[0] == 'refer') {
//         if (parts.length > 1) {
//           final key = int.tryParse(parts[1]);
//           if (key != null) {
//             refer(key);
//           } else {
//             print('Invalid key');
//           }
//         } else {
//           print('Missing key');
//         }
//       } else if (parts[0] == 'exit') {
//         break;
//       } else {
//         print('Unknown command');
//       }
//     }
//   }
// }

// class CacheEntry {
//   final int key;
//   final String value;
//   int referrals;

//   CacheEntry({required this.key, required this.value, this.referrals = 0});
// }

// void main() {
//   Cache cache = Cache();
//   cache.run();
// }

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

  // void run() {
  //   while (true) {
  //     stdout.write('Enter a command (generate/refer <key>/exit): ');
  //     final input = stdin.readLineSync() ?? '';
  //     final parts = input.split(' ');

  //     if (parts[0] == 'generate') {
  //       generate();
  //       _printCache();
  //     } else if (parts[0] == 'refer') {
  //       if (parts.length > 1) {
  //         final key = int.tryParse(parts[1]);
  //         if (key != null) {
  //           refer(key);
  //         } else {
  //           print('Invalid key');
  //         }
  //       } else {
  //         print('Missing key');
  //       }
  //       _printCache();
  //     } else if (parts[0] == 'exit') {
  //       break;
  //     } else {
  //       print('Unknown command');
  //       _printCache();
  //     }
  //   }
  // }

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
