# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [x] Use ActiveRecord for storing information in a database
      (Inherited from ActiveRecord::Migration and ActiveRecord::Base)
- [x] Include more than one model class (list of model class names e.g. User, Post, Category)
      (Models: User and Textbook)
- [x] Include at least one has_many relationship on your User model (x has_many y, e.g. User has_many Posts)
      (User has_many :texbooks)
- [x] Include at least one belongs_to relationship on another model (x belongs_to y, e.g. Post belongs_to User)
      (Textbook belongs_to :user)
- [x] Include user accounts
      (Log in and Sign up functionalities)
- [x] Ensure that users can't modify content created by other users
      (Removed buttons for non-owners and redirects to index page if a non-owner types in a url to view the edit forms)
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
      (Create listing, Show page for listing, Edit page for listing, and Delete button)
- [x] Include user input validations
      (Cannot edit with blank input fields)
- [x] Display validation failures to user with error message (example form URL e.g. /posts/new)
      (Utilized flash messages when failures occur)
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
