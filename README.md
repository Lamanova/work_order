# Work Orders
 Back-end of an app that has work orders and workers. A work order can be completed by one or more workers. The app has functionality of creating and deleting a worker, creating a work order and assigning a worker to it. Also all work orders can be fetched for a specific worker and sorted by deadline.

## Deployed service
This app is deployed in Heroku.
Instance: https://radiant-beach-22131.herokuapp.com/
Refer API guide below to interact with the application.

## API Documentation
https://documenter.getpostman.com/view/6993914/SVSPnmeV?version=latest

## Local Setup

### Prerequisites

1. Ruby > 2.3
2. Bundler
3. Postgres
Once ruby is installed, install bundler using
```
gem install bundler
brew install postgres
```

### Installing

Go to the project folder in terminal

Install the gems required for the project using bundler.
```
bundle install
```
create and migrate databse
```
bundle exec rake db:create db:migrate
```
run the server in dev environment
```
rails s
```

## Running the tests

Unit Tests are written in Rspec. This project has 100% code coverage.

### To run tests locally
Prepare the test database:
```
bundle exec rake db:test:prepare
```
Run the test suit:
```
bundle exec rspec
```

### Linters

Code quality is maintained using Rubocop.

Run Rubocop locally:
```
bundle exec rubocop
```
