
# Art Thieves

'Art Thieves' is a fictitious e-commerce platform consisting of users, merchants, and admins. Site visitors can log in as a User, Merchant, or Admin. Users and visitors can add items to a cart. Users can 'checkout' their cart to create an order. Merchants can fulfill items in an order, and admins can access functionality of both users and merchants.

A project that demonstrates CRUD and implements the MVC model.

## Requirements
- must use Rails 5.1.x
- must use PostgreSQL

# To Begin

Clone the repo on your local machine from your terminal

    git clone git@github.com:DavisC0801/little_shop_v2.git

Enter the newly created directory and run bundle install and bundle update

    cd little_shop-v2
    bundle install
    bundle update

Set up your environment

    rake db:{create, migrate, seed}

Initialize your server

    rails s

Navigate to 'localhost:3000' in your browser

Once you reach the site you can access login, registration, and other visitor functionality via the navigation bar at the top of the screen.

# Features

FactoryBot was used to provide test data to RSpec

Faker Gem was implemented to create a vast seed.rb file with minimal work

New users can be created through the 'Register' link in the navigation bar.

Merchant and Admin capabilities with login and checkout.

# Database Visualization

![Database Visualization](/database_schema.png?raw=true)

# How to Test

 RSpec was implemented for testing. To run the full test suite, type 'rspec' from the terminal.

    rspec

Individual tests can be run by specifying the desired file path and line number.

    rspec spec/models/cart_spec.rb:34


# Built With

- Ruby on Rails Framework

# Authors

View the [Little Shop Rubric](LittleShopRubric.pdf)
- Chris Davis
- Andrew Johnson
- Martin Mercer
- Logan Pile
- Martha Troubh
