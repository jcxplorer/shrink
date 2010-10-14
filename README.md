# Shrink

Shrink is the most flexible notification collector.

Its flexibility comes from the fact that you can record any information you want regarding your exceptions. This makes it suitable for any programming language.

Shrink uses Ruby on Rails, any relational database supported by ActiveRecord, and MongoDB for storing the notifications themselves.


## Project status

At the moment, this is mostly a proof of concept developed for a course.

I do, however, plan to extend it in the future to something scalable and production ready.

The current iteration does not focus on performance, but only on checking the feasibility of such a product.


## Requirements

* Ruby 1.8.7+
* Rubygems
* Bundler 1.0+
* MongoDB 1.6.0+
* A database supported by ActiveRecord


## Getting started

Reading the whole README before starting is recommended, especially if you are not familiar with Rails applications.

The only configuration options you will need to edit are for the database connections. Once you have the source code, open config/database.yml and config/mongodb.yml and change them according to your environment.

The following commands should get you up and running:

    git clone git://github.com/jcxplorer/shrink.git
    cd shrink
    bundle
    rake db:setup
    unicorn

By default your application will be available on port 8080, so if you have encountered no errors, you can now open http://127.0.0.1:8080/ and start using Shrink.

The following user has been created for you:

    email:    user@getshrink.com
    password: getshrink


## API

At the moment only XML has been tested, but JSON should work as well.

A sample XML is provided and you can see it in spec/samples/notification.xml.

XML should be sent to /api/v1/notifications, via a POST request. Make sure the Content-Type header is set correctly for your request.
