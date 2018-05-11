# checkout_system

Example of a checkout system implementation with a few deals done in Ruby

| SKU     | Name        | Price    |
| --------|:-----------:| --------:|
| ipd     | iPad  | $549.99  |
| mbp     | MacBook Pro | $1399.99 |
| atv     | Apple TV    | $109.50  |
| vga     | VGA adapter | $30.00   |

- 3 for 2 deal on Apple TVs. For example, if you buy 3 Apple TVs, you will pay the price of 2 only
- the brand new iPad will have a bulk discounted applied, where the price will drop to $499.99 each, if someone buys more than 4
- A free VGA adapter with every MacBook Pro sold

The checkout system can scan items in any order.

The checkout system interface (shown in java):

```java
  Checkout co = new Checkout(pricingRules);
  co.scan(item1);
  co.scan(item2);
  co.total();
```

Example scenarios
-----------------

SKUs Scanned: atv, atv, atv, vga
Total expected: $249.00

SKUs Scanned: atv, ipd, ipd, atv, ipd, ipd, ipd
Total expected: $2718.95

SKUs Scanned: mbp, vga, ipd
Total expected: $1949.98


