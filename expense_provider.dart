import 'package:flutter/foundation.dart';
import '../models/expense.dart';
import '../database/database_helper.dart';

class ExpenseProvider with ChangeNotifier {
  List<Expense> _expenses = [];
  
  List<Expense> get expenses => _expenses;
  
  double get totalExpenses {
    return _expenses.fold(0, (sum, expense) => sum + expense.amount);
  }
  
  Future<void> loadExpenses() async {
    _expenses = await DatabaseHelper().getExpenses();
    notifyListeners();
  }
  
  Future<void> addExpense(Expense expense) async {
    await DatabaseHelper().insertExpense(expense);
    await loadExpenses();
  }
  
  Future<void> updateExpense(Expense expense) async {
    await DatabaseHelper().updateExpense(expense);
    await loadExpenses();
  }
  
  Future<void> deleteExpense(int id) async {
    await DatabaseHelper().deleteExpense(id);
    await loadExpenses();
  }
  
  // Get expenses by category for chart
  Map<String, double> get expensesByCategory {
    Map<String, double> categoryMap = {};
    
    for (var expense in _expenses) {
      categoryMap.update(
        expense.category,
        (value) => value + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }
    
    return categoryMap;
  }
}
