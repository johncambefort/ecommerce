## Foreword

Thanks for taking the time to look over my assignment! There is unfortunately no frontend, as this is purely an API -- however, I set up swagger so that you can look around the endpoints. I did not have time to add all the necessary endpoints either, so database seeding as well as the rails console will need to be used to create objects / explore.
The assignment is indeed not fully complete, though I'd be happy to do some pairing on it in any future sessions.

## Setup instructions

To run the application:

```sh
# setup your env file
cp .env.example .env

# Run the app
docker compose up -d
# You may need to run the above 1 more time. The database container has gone down on me due to a user setup issue.

# Run migrations and seed the db with some sample data
docker compose exec ecommerce bundle exec rails db:migrate db:setup db:seed

# To run the rails console later on
docker compose exec ecommerce bundle exec rails c
```

Your best bet for viewing the app will be to look at it via the Swagger API page and play around with the endpoints: http://localhost:3000/api-docs

## Tests

I tested a few things.

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
  - [x] Different products have their own promotion; the promotion is applied against the product and is valid regardless of the cart the product is placed in.
- [x] Each item is only valid for one promotion
- [ ] Only one instance of a promotion can be applied at a time
  - [ ] I think I did this one? Slightly confused.

### Your solution must contain:
- [x] The ability to add, remove, and view items in a cart
  - [ ] Re: adding & removing -- sorta. The methods exist (`add_product` & `remove_product`). I apologize for not having time to implement the create API routes for POSTing carts & products ^^'
- [x] Every time an item is added to the cart the best possible price given the valid promotions must be shown.

