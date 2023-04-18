import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mini_budget/utilities/Transaction.dart';
import 'package:mini_budget/utilities/Category.dart';
import 'package:sorted_list/sorted_list.dart';

// Storage
// Categories:
// Others: constant category, cannot be changed

class Storage extends ChangeNotifier {
  SharedPreferences? storage;

  final SortedList<Transaction> _transactions = SortedList<Transaction>(
    (a, b) => b.date.compareTo(a.date),
  );
  SortedList<Transaction> get transactions => _transactions;

  Set<Category> _categories = {Category.others};
  Set<Category> get categories => _categories;

  static final Storage _instance = Storage();

  Storage() {
    SharedPreferences.getInstance().then((value) {
      storage = value;
      load();
    });
  }

  factory Storage.instanced() => _instance;

  Iterable<Transaction> get transactionsThisMonth {
    return _transactions.where((transaction) {
      return transaction.date.month == DateTime.now().month &&
          transaction.date.year == DateTime.now().year;
    });
  }

  Iterable<MapEntry<Category, double>> get categoriesWithAmountThisMonth {
    return (_categories.toList()
          ..sort(
              (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase())))
        .map((category) {
      return MapEntry(
        category,
        transactionsThisMonth
            .where((transaction) => transaction.category == category.name)
            .fold(0.0,
                (previousValue, element) => previousValue + element.amount),
      );
    });
  }

  double get amountThisMonth {
    return transactionsThisMonth.fold(
        0.0, (previousValue, element) => previousValue + element.amount);
  }

  void load() {
    String? value = storage!.getString('transactions');
    if (value != null) {
      _transactions.clear();
      _transactions.addAll(
          (jsonDecode(value) as Iterable).map((e) => Transaction.fromJson(e)));
    }

    value = storage!.getString('categories');
    if (value != null) {
      _categories = (jsonDecode(value) as Iterable)
          .map((e) => Category.fromJson(e))
          .toSet();

      if (!_categories.contains(Category.others)) {
        _categories.add(Category.others);
      }
    }

    notifyListeners();
  }

  Future<void> save() {
    _transactions.sort((a, b) => b.date.compareTo(a.date));
    return Future.wait([
      storage!.setString(
          'transactions',
          jsonEncode(_transactions.map((e) => e.toJson()).toList())),
      storage!.setString(
          'categories',
          jsonEncode(_categories.map((e) => e.toJson()).toList())),
    ]);
  }

  Future<void> clear() {
    return storage!.clear().then((value) => load()).then((value) => notifyListeners());
  }

  Future<void> addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    return save().then((value) => notifyListeners());
  }

  Future<void> removeTransaction(Transaction transaction) {
    _transactions.remove(transaction);
    return save().then((value) => notifyListeners());
  }

  Future<void> addCategory(Category category) {
    if (_categories.contains(category)) {
      return Future.error('Category already exists');
    }

    _categories.add(category);
    return save().then((value) => notifyListeners());
  }

  Future<void> removeCategory(Category category) {
    if (category == Category.others) {
      return Future.error('Other category cannot be removed');
    }

    _categories.remove(category);
    return save().then((value) => notifyListeners());
  }

  Future<void> updateTransaction(Transaction transaction) {
    _transactions.removeWhere((element) => element.id == transaction.id);
    _transactions.add(transaction);
    return save().then((value) => notifyListeners());
  }

  Future<void> updateCategory(Category category) {
    if (_categories.contains(category)) {
      return Future.error('Category already exists');
    }

    if (category == Category.others) {
      return Future.error('Others category cannot be updated');
    }

    _categories.removeWhere((element) => element.name == category.name);
    _categories.add(category);
    return save().then((value) => notifyListeners());
  }
}
