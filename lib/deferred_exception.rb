require_relative 'deferred_exception/version'
require_relative 'deferred_exception/enumerator'
require_relative 'deferred_exception/exception_set'

module Enumerable
  def defer_exceptions
    DeferredException::Enumerator.new(self)
  end
end
