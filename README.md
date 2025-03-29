### Problem Statement
You have been tasked with designing an inventory and promotions engine for an ecommerce software platform. As a business-to-business software platform, customers of your product can use the promotions engine to create promotions for items in their inventory.

### Item Requirements:
- Items can be sold by weight or quantity
- Items can be grouped into categories
- Items can have a brand
- More than one item of each type of item can be added to the cart
- Items do not have taxes for this problem.

### Promotion Requirements:
- Promotions can have the following types:
- Flat fee discount (ex: 20 dollars off of an item)
- Percentage discount (ex: 10% of off an item)
- Buy X Get Y discount (ex: Buy 1 get one free, buy 3 get 1 50% off)
- Weight threshold discounts (ex: buy more than 100 grams and get 50% off the item)
- Promotions can be valid for individual items, or categories (ex: 50% off of all products of X category)
- Promotions must have a start time
- Promotions may have an end time
- Multiple promotions can be applied to a cart if they both have a valid set of items
- Each item is only valid for one promotion
- Only one instance of a promotion can be applied at a time

### Your solution must contain:
- The ability to add, remove, and view items in a cart
- Every time an item is added to the cart the best possible price given the valid promotions must be shown.
