# PubliCV
PubliCV is the open source platform to help Jobseekers find their next Employer, and vice versa, _directly_ (with no intermediaries). See: https://publicv.org

The source code of the core service is released under the MIT license (see LICENSE and the [term of service](https://publicv.org/legal/terms) for more).

## Trademarks policy

"PubliCV", "publiCV", and the PubliCV logo are registered trademarks of Corsidia & Bluebash. You may not use these trademarks in a commercial setting to infer that your product or service is endorsed or associated with PubliCV without permission. You may use these marks to refer to PubliCV in a way where it's clear that you're simply referring to the project, not claiming endorsement or association.

You can request permission by emailing info@publicv.org.

## Requirements

Make sure you have installed:

* Ruby 2.4.0
* PostgreSQL (10+)
* Yarn (1.22.4)
* Node (12.16.2)

For Rails version and gems see the Gemfile.

## Setup

### Database
This is pretty standard to RoR apps, but always nice to remember: just set up the `config/database.yml` file with your local database credentials. Sample already exists at `config/database.yml.example` for reference

## Installation

So far so good. Now that you are all set up, you can begin to install it.

### Ruby on Rails Application

Run the standard RoR app setup commands:

1. `bundle install`
2. `rake db:create`
3. `rake db:schema:load`
4. `rake db:migrate`

Run additional setup commands:

1. `yarn install --check-files`

Run your local server:

`bin/rails s`

# Contributing

PubliCV is an open source project and we encourage contributions.
