import "dart:io" as io;

const GroceriesPriceMenu = {
  1: ("milk (ounce)", 5.5),
  2: ("egg (dozen)", 3.0),
  3: ("honey (jar)", 5.0),
  4: ("sugar (packet)", 1.0),
  5: ("soap (bar)", 3.5)
};

const TaxRate = .1;

// program entry point
main()
{
  // this variable will store the final result
  var totalPriceExcludingTax = 0.0;

  //print the welcome message
  print(
"""
enter groceries list according to the following format:
{item code} * {item quantity}\\enter
(preserve the spaces)
once you are done, type:
0\\enter

codes for available items:
  milk (ounce):   1
  egg (dozen):    2
  honey (jar):    3
  sugar (packet): 4
  soap (bar):     5
""");

  while (true)
  {
    // get input line
    final String line = io.stdin.readLineSync() ?? "";

    // check if customer asked to check out
    if (line == '0')
    {
      break;
    }

    // disect input line
    final lineParts = line.split(' ');
    if (lineParts.length != 3)
    {
      print('invalid input');
      continue;
    }

    final int itemIndex;
    final String asteriskPlaceholder;
    final double quantity;

    try {
      itemIndex = int.parse(lineParts[0]);
      asteriskPlaceholder = lineParts[1];
      quantity = double.parse(lineParts[2]);
      if (asteriskPlaceholder != '*')
      {
        throw FormatException();
      }
    } catch (exception) {
      print('invalid input');
      continue;
    }

    // check whether item index is valid
    if (!GroceriesPriceMenu.keys.contains(itemIndex))
    {
      print("invalid item index");
      continue;
    }

    final chosenItem = GroceriesPriceMenu[itemIndex]!.$1;
    final chosenItemPrice = GroceriesPriceMenu[itemIndex]!.$2;

    print('you bought ${chosenItem} whose unit price is ${chosenItemPrice} with a quantity of ${quantity}');

    // update total price
    totalPriceExcludingTax += quantity * chosenItemPrice;

    print('total price so far (excluding tax) = ${totalPriceExcludingTax}');
  }

  // print final result
  print('you successfuly checked out');
  print('total price (excluding tax) = ${totalPriceExcludingTax}');
  print('total tax = ${totalPriceExcludingTax * TaxRate}');
  print('total price (including tax) = ${totalPriceExcludingTax * (1 + TaxRate)}');
}