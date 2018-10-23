# Little Shop of Orders, v2

BE Mod 2 Week 4/5 Group Project


## Background and Description

"Little Shop of Orders" is a ficticious e-commerge platform where users can register to place items into a shopping cart and 'check out'. Merchant users can mark items as 'fulfilled', and Admins can mark orders as 'complete'. Each user role will have access to some or all CRUD functionality for application models.

Students will be put into 3 or 4 person groups to complete the project.


## Learning Goals

- Advanced Rails routing (nested resources and namespacing)
- Advanced ActiveRecord for calculating statistics
- Average HTML/CSS layout and design for UX/UI
- Session management and use of POROs for shopping cart
- Authentication, Authorization, separation of user roles and permissions


## Requirements

- must use Rails 5.1.x
- must use PostgreSQL
- must use 'bcrypt' for authentication
- all controller and model code must be tested via feature tests and model tests, respectively
- must use good GitHub branching, team code reviews via GitHub comments, and use of a project planning tool like waffle.io
- must include a thorough README to describe their project

## Not Permitted

- do not use JavaScript for pagination or sorting controls

---

## User Roles

1. Visitor - this type of user is anonymously browsing our site and is not logged in
2. Registered User - this user is registered and logged in to the application while performing their work; can place items in a cart and create an order
3. Merchant User - a registered user who is also has access to merchant data and operations; user is logged in to perform their work
4. Admin User - a registered user (but cannot also be a merchant) who has "superuser" access to all areas of the application; user is logged in to perform their work


## User Stories

These user stories may be worked on in any order that makes sense to your team. The most optimal order may not be a top-to-bottom approach.


### Nothing is Deleted

In the user stories below, we talk about "CRUD" functionality. However, it's rare in a real production system to ever truly delete content, and instead we typically just 'enable' or 'disable' content. Users, items and orders can be 'enabled' or 'disabled' which blocks functionality (users whose accounts are disabled should not be allowed to log in, items which are disabled cannot be ordered, orders which are disabled cannot be processed, and so on)

Disabled content should also be restricted from showing up in the statistics pages. For example if a user is disabled they should not appear in a list of "users with most orders"; if an order is disabled it should not be considered as part of "top sales" and so on.


### Navigation

```
[ ] done

As a visitor
I see a navigation bar
This navigation bar includes links for the following:
- a link to return to the welcome / home page of the application ("/")
- a link to browse all items for sale ("/items")
- a link to see all merchants ("/merchants")
- a link to my shopping cart ("/cart")
- a link to log in ("/login")
- a link to the user registration page ("/register")
Next to the shopping cart link I see a count of the items in my cart
```

```
[ ] done

As a registered user
I see the same links as a visitor
Plus the following links
- a link to my profile page ("/profile")
- a link to see my orders ("/profile/orders")
- a link to log out ("/logout")
Minus the following links
- I do not see a link to log in or register
I also see text that says "Logged in as Ian Douglas" (or whatever my name is)
```

```
[ ] done

As a merchant user
I see the same links as a registered user
Plus the following links
- a link to my merchant dashboard ("/dashboard")
```

```
[ ] done

As an admin user
I see the same links as a registered user
Plus the following links
- a link to the admin dashboard ("/dashboard")
- a link to see all users ("/users")
```

### "User" CRUD

```
[ ] done

As a visitor
When I click on the 'register' link in the nav bar
Then I am on the user registration page
And I see a form where I input the following data:
- my name
- my street address
- my city
- my state
- my zip code
- my email address
- my preferred password
- a confirmation field for my password
When I fill in this form completely,
And with a unique email address not already in the system
My details are saved in the database
Then I am logged in as a registered user
I am taken to my profile page ("/profile")
I see a flash message indicating that I am now registered and logged in
```

```
[ ] done

As a visitor
When I visit the user registration page
If I fill out the registration form
But include an email address already in the system
Then I am returned to the registration page
My details are not saved and I am not logged in
The form is filled in with all previous data except the email field and password fields
I see a flash message telling me the email address is already in use
```

```
[ ] done

As a registered user, merchant, or admin
When I visit my own profile page
Then I see all of my profile data on the page except my password
And I see a link to edit my profile data
I also see statistics about my user account
If my account has ordered items
Then I also see a link to my orders page ("/orders")
```

```
[ ] done

As a registered user, merchant, or admin
When I visit my profile page
And I click on the link to edit my profile data
Then my current URI route is "/profile/edit"
I see a form like the registration page
The form contains all of my user information
The password fields are blank
I can change any or all of the information
When I submit the form
Then I am returned to my profile page
And I see a flash message telling me that my data is updated
And I see my updated information
```

```
[ ] done

As a registered user, merchant, or admin
When I attempt to edit my profile data
I see a form like the registration page
The form contains all of my user information
If I try to change my email address to one that belongs to another user
When I submit the form
Then I am returned to the profile edit page
And I see a flash message telling me that email address is already in use
```

```
[ ] done

As an admin user
When I visit the user index page ("/users")
I see all users in the system
Each user's full name is a link to their respective show page
I see a "disable" button next to any users who are not yet disabled
I see an "enable" button next to any users whose accounts are disabled
```

```
[ ] done

As an admin user
When I visit the user index page
And I click on a "disable" button for a user
I am returned to the user index page
And I see a flash message that the user's account is now disabled
And I see that the user's account is now disabled
This user cannot log in
```

```
[ ] done

As an admin user
When I visit the user index page
And I click on an "enable" button for a user
I am returned to the user index page
And I see a flash message that the user's account is now enabled
And I see that the user's account is now enabled
This user can now log in
```

```
[ ] done

As an admin user
When I visit the user index page
And I click on any user's name
I am taken to that user's profile page
My current URI route is something like "/users/5"
(only admin users can use this route)
And I see their profile page
And I see a link to edit their profile data
```

```
[ ] done

As an admin user
When I visit a user's profile page ("/users/5")
And I click the link to edit a user's profile data
The same behaviors exist as if I were that user trying to change their own data
Except I am returned to the show page path of "/users/5" when I am finished
```

```
[ ] done

As an admin user
When I visit a user's profile page
And I click the link to see a user's orders
Then my URI route should be something like "/users/5/orders"
And I only see that user's orders
```


### "Session" CRUD

```
[ ] done

As a visitor
When I visit the login path
I see a field to enter my email address and password
When I submit valid information
I am directed to my profile page
And I see a flash message that I am logged in
```

```
[ ] done

As a registered user, merchant, or admin
When I visit the login path
I am redirected to my profile page
And I see a flash message that tells me I am already logged in
```

```
[ ] done

As a registered user, merchant, or admin
When I visit the login path
I am redirected to my profile page
And I see a flash message that tells me I am already logged in
```

```
[ ] done

As a registered user, merchant, or admin
When I visit the logout path
I am redirected to the welcome / home page of the application
And I see a flash message that indicates I am logged out
Any items I had in my shopping cart are deleted
```


### "Merchant" CRUD

```
[ ] done

As a merchant user
When I visit my dashboard ("/dashboard)
If any users have ordered items from me
Then I also see a link to my merchant orders ("/dashboard/orders")
```

```
[ ] done

As an admin user
When I visit the merchants index page ("/merchants")
I see all merchants in the system
Each merchant's name is a link to their respective show page
I see a "disable" button next to any merchants who are not yet disabled
I see an "enable" button next to any merchants whose accounts are disabled
```

```
[ ] done

As an admin user
When I visit the merchant index page
And I click on a "disable" button for a merchant
I am returned to the merchant index page
And I see a flash message that the merchant's account is now disabled
And I see that the merchant's account is now disabled
This merchant cannot log in
```

```
[ ] done

As an admin user
When I visit the merchant index page
And I click on an "enable" button for a merchant
I am returned to the merchant index page
And I see a flash message that the merchant's account is now enabled
And I see that the merchant's account is now enabled
This merchant can now log in
```

```
[ ] done

As an admin user
When I visit the merchant index page
And I click on any merchant's name
I am taken to that merchant's profile page
My current URI route is something like "/merchants/6"
Only admin users can use this route
And I see their profile page
And I see a link to edit their profile data
```

```
[ ] done

As an admin user
When I visit a merchant's dashboard page ("/merchants/6")
And I click the link to edit a merchant's profile data
The same behaviors exist as if I were that merchant trying to change their own data
Except I am returned to the show page path of "/merchants/6" when I am finished
```

```
[ ] done

As an admin user
When I visit a merchant's dashboard page
And I click the link to see that merchant's orders
Then my URI route should be something like "/merchants/6/orders"
And I only see the orders containing items from this merchant
```

### "MerchantUsers" CRUD

```
[ ] done

As an admin user
When I visit a user's profile page ("/users/5")
I see a link to "upgrade" the user's account to become a merchant
When I click on that link
I am redirected to ("/merchants/5") because the user is now a merchant
And I see a flash message indicating the user has been upgradeded
The next time this user logs in they are now a merchant
```

```
[ ] done

As an admin user
When I visit a merchant's profile page ("/merchants/6")
I see a link to "downgrade" the user's account to become a regular user
When I click on that link
I am redirected to ("/users/6") because the merchant is now a regular user
And I see a flash message indicating the user has been upgradeded
The next time this user logs in they are now a merchant
```

```
[ ] done

As an admin user
If I visit a profile page for a user, but that user is a merchant
Then I am redirected to the appropriate merchant dashboard page.

eg, if I visit "/users/7" but that user is a merchant
then I am redirected to "/merchants/7" and see their merchant dashboard page
```

```
[ ] done

As an admin user
If I visit a profile page for a merchant, but that merchant is a regular user
Then I am redirected to the appropriate user profile page.

eg, if I visit "/merchants/8" but that account is just a regular user
then I am redirected to "/users/8" and see their user profile page
```

### "Items" CRUD

```
[ ] done

As a merchant
When I visit my dashboard page ("/dashboard")
I see a link to view my own items
When I click that link
My URI route should be "/dashboard/items"
```

```
[ ] done

As a merchant
When I visit my items page
I see a link to add a new item to the system
I see each item I have already added to the system, including:
- the ID of the item
- the name of the item
- a thumbnail image for that item
- the price of that item
- my current inventory count for that item
- a link or button to edit the item
If the item is enabled, I see a button or link to disable the item
If the item is disabled, I see a button or link to enable the item
```

```
[ ] done

As a merchant
When I visit my items page
And I click on a "disable" button or link for an item
I am returned to my items page
I see a flash message indicating this item is no longer for sale
I see the item is now disabled
```

```
[ ] done

As a merchant
When I visit my items page
And I click on an "enable" button or link for an item
I am returned to my items page
I see a flash message indicating this item is now available for sale
I see the item is now enabled
```

```
[ ] done

As a merchant
When I visit my items page
And I click on the link to add a new item
My URI route should be "/dashboard/items/new"
I see a form where I can add new information about an item, including:
- the name of the item, which cannot be blank
- a description for the item, which cannot be blank
- a thumbnail image URL string, which CAN be left blank
- a price which must be greater than $0.00
- my current inventory count of this item which is 0 or greater
When I submit valid information and save the form
I am taken back to my items page
I see a flash message indicating my new item is saved
I see the new item on the page, and it is enabled and available for sale
If I left the image field blank, I see a placeholder image for the thumbnail
```

```
[ ] done

As a merchant
When I try to add a new item
If any of my data is incorrect
Then I am returned to the form
I see one or more flash messages indicating each error I caused
All fields are re-populated with my previous data
```

```
[ ] done

As a merchant
When I visit my items page
And I click the edit button or link next to any item
Then I am taken to a form similar to the 'new item' form
My URI route will be something like "/items/15/edit" (if the item's ID was 15)
The form is re-populated with all of this item's information
I can change any information, but all of the rules for adding a new item still apply:
- name and description cannot be blank
- price cannot be less than $0.00
- inventory must be 0 or greater
When I submit the form
I am taken back to my items page
I see a flash message indicating my item is updated
I see the item's new information on the page, and it maintains its previous enabled/disabled state
If I left the image field blank, I see a placeholder image for the thumbnail
```

```
[ ] done

As a merchant
When I try to edit an existing item
If any of my data is incorrect
Then I am returned to the form
I see one or more flash messages indicating each error I caused
All fields are re-populated with my previous data
```

```
[ ] done

As an admin user
When I visit a merchant's profile page
I can click on the merchant's items link
And have access to all functionality the merchant does, including
- adding new items
- editing existing items
- enabling/disabling items
All content rules still apply (eg, item name cannot be blank, etc)
```

```
[ ] done

As any kind of user on the system
I can visit the items catalog ("/items")
I see all items in the system except disabled items
Each item will display the following information:
- the name of the item
- a small thumbnail image for the item
- the merchant name who sells the item
- how many of the item the merchant has in stock
- the merchant's current price for the item
Each item's name and thumbnail image are links to that item's show page
```

```
[ ] done

As any kind of user on the system
When I visit an item's show page from the items catalog
My URI route is something like "/items/18"
I see all information for this item, including:
- the name of the item
- the description of the item
- a larger image of the item
- the merchant name who sells the item
- how many of the item the merchant has in stock
- the merchant's current price for the item
I also see a link to add this item to my cart
```


### "Cart" CRUD

```
[ ] done

As any kind of user on the system
When I visit an item's show page from the items catalog
And I click its link to add the item to my cart
I see a flash message indicating the item has been added to my cart
The navigation bar increments my cart counter
```

```
[ ] done

As any kind of user on the system
When I visit my cart ("/cart")
I see all items I've added to my cart
And I see a link to empty my cart
Each item in my cart shows the following information:
- the name of the item
- a small thumbnail image of the item
- the merchant I'm buying this item from
- the price of the item
- my desired quantity of the item
- a subtotal (price multiplied by quantity)
I also see a grand total of what everything in my cart will cost
```

```
[ ] done

As any kind of user on the system
When I visit my cart ("/cart")
And I click the link to empty my cart
Then I am returned to my cart
All items have been completely removed from my cart
The navigation bar shows 0 items in my cart
```

```
[ ] done

As any kind of user on the system
When I visit my cart
Next to each item in my cart
I see a button or link to remove that item from my cart
- clicking this button will remove the item but not other items
I see a button or link to increment the count of items I want to purchase
I see a button or link to decrement the count of items I want to purchase
- I cannot increment the count beyond the merchant's inventory size
- If I decrement the count to 0 the item is immediately removed from my cart
```

```
[ ] done

As a visitor
When I visit my cart
I see information telling me I must reigster or log in to finish the checkout process
The word "register" is a link to the registration page
The words "log in" is a link to the login page
```

```
[ ] done

As a registered user, merchant, or admin
When I visit my cart
I see a button or link indicating that I can check out
```

### "Order" CRUD

```
[ ] done

As a registered user, merchant, or admin
When I visit my cart
And I click the button or link to check out
An order is created in the system, which has a status of "pending"
I am taken to my orders page ("/profile/orders")
```

```
[ ] done

As a registered user, merchant, or admin
When I visit my orders page
I see every order I've made, including the following information:
- the ID of the order, which is a link to the order show page
- the date the order was made
- the date the order was last updated
- the current status of the order
- the total quantity of items in the order
- the grant total of all items for that order
If the order is still "pending", I see a button or link to cancel the order
If I click that cancellation button I am returned to my orders page
And I see that order has an updated status of "cancelled"
```

```
[ ] done

As a merchant
When I visit my dashboard
And I click the link or button to view my merchant orders
Then I see a list of all orders containing items being purchased from me
Each order will show the following information:
- the ID of the order, which is a link to the order show page
- the date the order was made
- the date the order was last updated
- the current status of the order
```

```
[ ] done

As a merchant
When I visit my merchant orders page
And I click on an order ID
I am taken to that order's show page ("/orders/12")
```

```
[ ] done

As a merchant
When I visit an order show page
I see the customer's name an address, but only the items in the order that are being purchased from me
I do not see any items in the order being purchased from other merchants
For each item, I see the following information:
- the name of the item, which is a link to my item's show page
- a small thumbnail of the item
- my price for the item
- the quantity the user wants to purchase

If the user's desired quantity is equal to or less than my current inventory quantity for that item
And I have not already "fulfilled" that item:
- Then I see a button or link to "fulfill" that item
- When i click on that link or button I am returned to the order show page
- I see the item is now fulfilled
- I also see a flash message indicating that I have fulfilled that item
- My inventory quantity is permanently reduced by the user's desired quantity

If the user's desired quantity is greater than my current inventory quantity for that item
Then I do not see a "fulfill" button or link
Instead I see a big red notice next to the item indicating I cannot fulfill this item
```

```
[ ] done

When all items in an order have been "fulfilled" by their merchants
The order status changes from "pending" to "complete"
```

```
[ ]  done

As an admin
When I visit the orders index page ("/orders")
I see a "cancel" button next to each order which has not yet "complete"
If I click on the "cancel" button
Each row in the "order items" table is given a status of "canceled"
The order itself is given a status of "canceled"
Merchants and users can no longer take any additional action on this order
Admins cannot reset an order back to pending or completed states
```

### Statistics

```
[ ] done

As a merchant
When I visit my dashboard, I see an area with statistics:
- total items I've sold, and as a percentage against total remaining inventory
  (total item count will be current inventory plus sold items)
- top 3 states where my items were shipped
- top 3 cities in each state where my items were shipped
- most active user who has ordered items from me
- largest order (by quantity of items of mine)
- top 3 biggest spending users who have bought my items
```

```
[ ] done

As an admin user
When I visit my dashboard, I see an area with statistics:
- top 3 states where orders were shipped
- top 3 cities in each state where orders were shipped
- top 3 most active users by largest total order spending
- top 3 orders by quantity of items
- top 3 selling merchants
```

```
[ ] done

As a registered user, merchant, or admin
When I visit the items index page ("/items")
I see an area with statistics:
- the top 5 most popular items
- the top 5 most popular merchants
- top 3 merchants who are fastest at fulfilling their orders
- worst 3 merchants who are slowest at fulfilling their orders
```


### Security

```
[ ] done

As an admin user
I should have basic CRUD functionality for all content
Except deleting content
```

```
[ ] done

As a merchant user
I can only view my own merchant dashboard
I can only view my own merchant orders
I can only add/edit/update and enable/disable my own items
```

```
[ ] done

As a registered user (who is not an admin, but may be a merchant)
I can only view my own dashboard
I can only change my own profile data
I can only cancel my own pending orders
```

## Extensions

Once all other work is 100% complete, you may add additional features to your code which are NOT already outlined in the [extensions](extensions.md) document. (those extensions are for your solo project in week 6)


## Rubric, Evaluations, and final Assessment

Each team will meet with an instructor at least two times before the project is due.

- At first team progress check-in, about 33% of the work is expected to be completed satisfactorally
- At second team progress check-in, about 66% of the work is expected to be completed satisfactorally
- Final submission will expect 100% completion

Each team will have a rubric uploaded to [https://github.com/turingschool/ruby-submissions](https://github.com/turingschool/ruby-submissions)


### Feature Completeness

4 - All user stories are complete and additional extension work was attempted.  
3 - All user stories are complete.  
2 - 75% of user stories are complete, but not all of them are fully implemented.  
1 - Fewer than 75% of the user stories are complete.

### MVC Responsibilities

4 - Views only display data and do not make additional calls to the database; they may include branch logic. Controllers request all data from Models except `.all` or `.find` calls and only do `.create` and `.delete` methods for writing data. Models read/write all other data using branch logic or smaller methods.  
3 - Views make some calls to the database for `.each` calls and branch logic. Controllers push almost all work to the Models for reading/writing. Models sufficiently process and retrieve data.  
2 - Views contain logic that make significant additional calls to the database including Model class methods. Controllers do a signficant amount of processing of data that should exist at a model level. Models process data in a way that is ineffcient, or contains work that determins presentation logic (how data might get viewed).  
1 - Views, Controllers, and Models do not have a clear sense of resonsibilities.

### Routing and Namespacing

4 - Routing limits exactly which routes should be exposed for the app and nothing more.  
3 - Routing and namespacing are used properly for the scope of the app.  
2 - Running `rake routes` shows some endpoints which do not have code implemented.  
1 - Routing is not complete.

### Testing

4 - Very clear test-driven development. Test files are extremely well organized and nested and utilize `before(:each)` blocks for sharing test setups. 100% test coverage for features, and 100% of all model methods is tested.  
3 - 98% or better test coverage for features, and all model methods are 100% tested.  
2 - Many portions of code are missing tests.  
1 - Testing is extremely poor, or not done.

### User Experience and Styling/Layout

4 - Extremely well styled and purposeful layout. Excellent color scheme and font usage. Easy to use and follow the application workflow. Utilizes additional tooling like SCSS.  
3 - Added a purposeful styling pattern and HTML layout using `/app/views/application.html.erb` and `/app/assets/stylesheets/application.css`. User workflow is easy to use with links to reach all areas of the site.  
2 - Styling is poor, or incomplete. Layout does not utilize good HTML patterns. User workflow has significant problems and URIs have to managed manually.  
1 - Little or no styling or layout. User workflow is significantly problematic.

### Authentication, Authorization

4 - All areas of permitted use within the app are above and beyond what we have taught.  
3 - Authentication and Authorization are implemented with clear responsibilities of each user type.  
2 - Authentication or Authorization are not implemented well (perhaps some users could impact data that they should not be permitted to access or change).  
1 - Authentication or Authorization was largely incomplete.

### Documentation and Workflow

4 - Team has built a robust README including screenshots of the app, clear explanation of what the app is used for. The team has additionally used a project tool like waffle.io that clearly shows an excellent workflow to be highly productive such as automating promotion/closing of stories as they are developed. PRs also include discussions between reviewers about the code.  
3 - Team has a README that describes the application to a satisfactory level. Team has also utilized a project management tool to track their work.  
2 - README is poor quality. Team has not utilized an effective project management tool to a productive level.  
1 - No README file exists. Team has not implemented any project management tool of any kind.
