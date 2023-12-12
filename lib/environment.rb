# frozen_string_literal: true

require_relative "./helpers"

# First, we setup the dependencies.
# We use inline Gemfile for that and make it possible to extend it from examples
# by using the GemsInline helper module
require "bundler/inline"

retried = false
begin
  gemfile(retried, quiet: true) do
    source "https://rubygems.org"

    gem "rails", "7.1.1"
    gem "activerecord", "7.1.1"

    # Use Puma as a web server (so we can reload the app without reloading the server)
    gem "puma", "~> 6.0.1"
    # Rails is not fully compatible with Rack 3 yet
    gem "rack", "< 3"
    # We use in-memory sqlite as our database
    gem "sqlite3", "1.6.0"
    # Debugger could be used to dig deeper into some code examples
    gem "debug", "1.7.0"
    # Highlight code in the terminal
    gem "rouge", "4.2.0"

    # Freeze default gem versions to avoid Bundler conflicts
    require "timeout"
    gem "timeout", Timeout::VERSION

    require "stringio"
    gem "stringio", StringIO::VERSION

    require "psych"
    gem "psych", Psych::VERSION

    require "net/protocol"
    gem "net-protocol", Net::Protocol::VERSION

    ChapterHelpers.extend!(:gemfile, self)
  end
rescue Gem::MissingSpecError, Bundler::SolveFailure
  raise if retried

  retried = true
  retry
end

# Then, load the Rails application
require_relative "./application"
