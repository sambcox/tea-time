# Tea Time (Back End)

## Description

Tea Time is an API application that tracks Teas, Customers, and Customer Subscriptions to Teas, allowing customers to recieve subscriptions to teas at different frequencies.

## Getting Started

This is a Ruby on Rails application which establishes API endpoints. To run the application locally, clone the application and you will be able to call endpoints after this setup:

### Installation

To install gems, run:

```bash
bundle install
```

Then to establish a database, run:

```bash
rails db:create
```

Because this is the back end repository, database migration is also necessary, run:

```bash
rails db:migrate
```

Inspect the `/db/schema.rb` and compare to the 'Schema' section below to ensure this migration has been done successfully.

### RSpec Suite

Once `tea-time` is correctly installed, run tests locally to ensure the repository works as intended.

To test the entire spec suite, run:

```bash
bundle exec rspec
```

All tests should be passing if installation is successful.

### Calling APIs

- APIs can be called locally using a program like [Postman](https://www.postman.com).

## Available Endpoints

*Note:* Necessary parameters marked with {}

### Create a New Customer
*Note:* pass `first_name`, `last_name`, `address`, & `email` in request body

```bash
POST '/api/v1/customers'
```

Response:
```bash
{
  "data":
  {
    "id":"CUSTOMER_ID",
    "type":"customer",
    "attributes":
    {
      "first_name":"CUSTOMER_FIRST_NAME",
      "last_name":"CUSTOMER_LAST_NAME",
      "email":"CUSTOMER_EMAIL",
      "address":"CUSTOMER_ADDRESS"
    }
  }
}
```

### Create a New Tea
*Note:* pass `title`, `description`, `temperature`, & `brew_time` in request body

```bash
POST '/api/v1/teas'
```

Response:
```bash
{
  "data":
  {
    "id":"TEA_ID",
    "type":"tea",
    "attributes":
    {
      "title":"TEA_TITLE",
      "description":"TEA_DESCRIPTION",
      "temperature":"TEA_TEMPERATURE",
      "brew_time":"TEA_BREW_TIME"
    }
  }
}
```

### Create a New Subscription
*Note:* pass `title`, `price`, `frequency`, `customer_id`, & `tea_id` in request body
*Note:* `status` will automatically be set to `active`, if this subscription is not active, please specify `status: inactive` in request body
*Note:* `frequency` is weeks between deliveries, and `temperature` is in degrees Fahrenheit

```bash
POST '/api/v1/subscriptions'
```

Response:
```bash
{
  "data":
  {
    "id":"SUBSCRIPTION_ID",
    "type":"subscription",
    "attributes":
    {
      "title":"SUBSCRIPTION_TITLE",
      "price":"SUBSCRIPTION_PRICE",
      "status":"SUBSCRIPTION_STATUS",
      "frequency":"SUBSCRIPTION_FREQUENCY"
      "customer_id":"SUBSCRIPTION_CUSTOMER_ID"
      "tea_id":"SUBSCRIPTION_TEA_ID"
    }
  }
}
```

### Update a Subscription's Status
*Note:* pass `status` in request body

```bash
PATCH '/api/v1/subscriptions/{SUBSCRIPTION_ID}'
```

Response:
```bash
{
  "data":
  {
    "id":"SUBSCRIPTION_ID",
    "type":"subscription",
    "attributes":
    {
      "title":"SUBSCRIPTION_TITLE",
      "price":"SUBSCRIPTION_PRICE",
      "status":"SUBSCRIPTION_STATUS",
      "frequency":"SUBSCRIPTION_FREQUENCY"
      "customer_id":"SUBSCRIPTION_CUSTOMER_ID"
      "tea_id":"SUBSCRIPTION_TEA_ID"
    }
  }
}
```

### Return all subscriptions for customer

```bash
GET '/api/v1/customers/{customer_id}/subscriptions'
```

Response:
```bash
{
  "data":
  [{
    "id":"SUBSCRIPTION_ID",
    "type":"subscription",
    "attributes":
    {
      "title":"SUBSCRIPTION_TITLE",
      "price":"SUBSCRIPTION_PRICE",
      "status":"SUBSCRIPTION_STATUS",
      "frequency":"SUBSCRIPTION_FREQUENCY"
      "customer_id":"SUBSCRIPTION_CUSTOMER_ID"
      "tea_id":"SUBSCRIPTION_TEA_ID"
    },
  },
  ...
  ]
}
```

## Goals

Tea Time was produced to satisfy the requirements of the Turing School of Software and Design's Module 4 Solo Project, **Take Home**. See official [project requirements](https://mod4.turing.edu/projects/take_home/take_home_be).

### Demonstration Goals

- A strong understanding of Rails
- Ability to create restful routes
- Demonstration of well-organized code, following OOP
- Test Driven Development
- Clear documentation

## Database & Schema

upload schema image here

## Completed By

:bust_in_silhouette: **Samuel Cox**
- samc1253@gmail.com
- [GitHub](https://github.com/sambcox)
- [LinkedIn](https://www.linkedin.com/in/samuel-bingham-cox/)
