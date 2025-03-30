## Setup instructions

To run the application:

```sh
# setup your env file
cp .env.example .env

# Run the app
docker compose up -d

# Run migrations and seed the db with some sample data
docker compose exec ecommerce bundle exec db:migrate db:setup
```

You can view and interact with the API endpoints via the Swagger page, at http://localhost:3000/api-docs

## Tests

Run API rswag tests:

```sh
docker compose exec -e RAILS_ENV=test ecommerce bundle exec rspec
```


### Problem Statement
You have been tasked with designing an inventory and promotions engine for an ecommerce software platform. As a business-to-business software platform, customers of your product can use the promotions engine to create promotions for items in their inventory.

### Item Requirements:
- Items can be sold by quantity
- Items can have a brand
- Items can be sold by weight
- Items can be **grouped** into categories
- More than one item of each type of item can be added to the cart (you can buy multiple of the same item, i.e. quantity)
(- Items do not have taxes for this problem.)

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
