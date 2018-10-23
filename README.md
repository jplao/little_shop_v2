# Little Git Shop

We have built an online e-commerce platform to sell local artisan goods. Our site allows users to add items to a cart and check out to purchase them from merchants. Merchants may log in to purchase items, add items to their own inventories, enable and disable items, fulfill orders, and edit existing items available.  Admin users have access to change user status from merchants to regular users and vice versa, disable and enable users and merchants, have access to additional analytics, and cancel orders.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

From GitHub clone down repository using the following commands in terminal:
* git clone git@github.com:jplao/little_shop_v2.git
* cd little_shop_v2

### Prerequisites

You will need Rails installed and verify that it is version 5.1 and NOT 5.2

To check your version using terminal run: rails -v in the command line.
If you have not installed rails, in terminal run: gem install rails -v 5.1 in the command line.


### Installing

Open terminal and run these commands:
* bundle
* bundle update
* rake db:{drop,create,migrate,seed}
* rails s

Open up a web browser (preferably Chrome)

Navigate to localhost:3000 (a landing page should be displayed)


## Running the tests

* Note: Before running RSpec, ensure you're in the project root directory.

From terminal run: rspec

After RSpec has completed, you should see all tests passing as GREEN.  Any tests that have failed or thrown an error will display RED.  Any tests that have been skipped will be displayed as YELLOW.


### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```


## Built With

* Rails
* RSpec
* ShouldaMatchers
* Capybara
* Launchy
* Pry
* SimpleCov
* FactoryBot
* BCrypt
* Blood
* Sweat
* Tears

## Versioning

GitHub

## Authors

* Bailey Diveley - Github: BDiveley
* Jennifer Lao - Github: jplao
* Preston Jarnagin - Github: PrestonJarnagin
* Ryan McNeil - Github: ryan-mcneil


## Acknowledgments

* Ian Douglas
* Dione Wilson
* Sal Espinosa
* Brian Zanti
* Megan McMahon
* coffee
