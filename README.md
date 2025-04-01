## Setup instructions

To run the application:

```sh
# setup your env file
cp .env.example .env

# Run the app
docker compose up -d

# Run migrations and seed the db with some sample data
docker compose exec ecommerce bundle exec db:setup db:migrate
```

You can view and interact with the API endpoints via the Swagger page, at http://localhost:3000/api-docs

## Tests

Run API rswag tests:

```sh
docker compose exec -e RAILS_ENV=test ecommerce bundle exec rspec
```


## Problem

### Problem Statement
You have been tasked with designing an inventory and promotions engine for an ecommerce software platform. As a business-to-business software platform, customers of your product can use the promotions engine to create promotions for items in their inventory.

### Item Requirements:
- [x] Items can be sold by quantity
- [x] Items can have a brand
- [x] More than one item of each type of item can be added to the cart
- [ ] Items can be sold by weight
- [ ] Items can be grouped into categories
- [x] Items do not have taxes for this problem.

### Promotion Requirements:

Promotions can have the following types:
- [x] Flat fee discount (ex: 20 dollars off of an item)
- [x] Percentage discount (ex: 10% of off an item)
- [ ] Buy X Get Y discount (ex: Buy 1 get one free, buy 3 get 1 50% off)
  - [x] Buy 1 Get 1 free
- [ ] Weight threshold discounts (ex: buy more than 100 grams and get 50% off the item)
- [ ] Promotions can be valid for individual items, or categories (ex: 50% off of all products of X category)
- [x] Promotions must have a start time
- [x] Promotions may have an end time
- [ ] Multiple promotions can be applied to a cart if they both have a valid set of items
- [x] Each item is only valid for one promotion
- [ ] Only one instance of a promotion can be applied at a time

### Your solution must contain:
- [x] The ability to add, remove, and view items in a cart
- [x] Every time an item is added to the cart the best possible price given the valid promotions must be shown.

