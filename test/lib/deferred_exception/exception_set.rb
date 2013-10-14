require_relative '../../test_helper'

describe DeferredException::ExceptionSet do
  it 'should return a compound message' do
    exceptions = [StandardError.new('foo'), StandardError.new('bar')]
    exception_set = DeferredException::ExceptionSet.new(exceptions)
    assert_equal "foo\n=====\nbar", exception_set.message
  end
end
