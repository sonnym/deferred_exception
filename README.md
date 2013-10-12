# Deferred Exception

[![Build Status](https://travis-ci.org/sonnym/deferred_exception.png?branch=master)](https://travis-ci.org/sonnym/deferred_exception)
[![Code Climate](https://codeclimate.com/github/sonnym/deferred_exception.png)](https://codeclimate.com/github/sonnym/deferred_exception)

Have you ever found yourself writing code like this? Have you presumed that you
would notice a problem and go looking in your logs to find the problem?

```ruby
class EmailBlaster
  def self.process_all!
    all.each { |email| email.blast! }
  end

  def blast!
    begin
      # do some atomic work here
    rescue StandardError => e
      Logger.debug("Something went wrong #{e.message}")
    end
  end

  # &c.
end
```

Wouldn't it be nice, nay preferable, to accrue exceptions without stopping the
subsequent atomic operations?

## Installation

Add this line to your application's Gemfile:

    gem 'deferred_exception'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install deferred_exception

## Usage

Deferred Exception adds a `defer_exceptions` method to the `Enumerable` module
that wraps the enumberable object and stores any exceptions that are raised
during iteration.

```ruby
class EmailBlaster
  def self.process_all!
    all.defer_exceptions.each do { |email| email.blast! }
  end

  def blast!
    # important, atomic work here
  end
end
```

Any exceptions will be caught and queued into a `ExceptionSet` class, a
subclass of `StandardError` and will be raised once the iteration is complete.
`ExceptionSet#message` will be a string containing messages and backtraces from
all caught exceptions

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
