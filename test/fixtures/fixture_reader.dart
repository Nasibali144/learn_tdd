/// TODO: todo20 - create reader function: fixture
import 'dart:io';

String fixture(String name) => File('test/fixtures/$name').readAsStringSync();