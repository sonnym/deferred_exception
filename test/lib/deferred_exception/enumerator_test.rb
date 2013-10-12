require_relative '../../test_helper'

describe DeferredException::Enumerator do
  it 'is an enumerable' do
    enumerator = DeferredException::Enumerator.new([:foo, :bar, :baz])
    assert_kind_of Enumerable, enumerator
  end

  it 'returns the original enumerable after processing' do
    original = [:foo, :bar, :baz]
    enumerator = DeferredException::Enumerator.new(original)
    assert_equal original, enumerator.each {}
  end

  it 'raises ExceptionSet if exceptions occur' do
    items = [-> { raise StandardError(:foo) },
             -> { raise StandardError(:bar) },
             -> { raise StandardError(:baz) }]

    enumerator = DeferredException::Enumerator.new(items)

    assert_raises(DeferredException::ExceptionSet) do
      enumerator.each { |fn| fn.call }
    end
  end

  it 'contiues processing elements after an exception is encountered' do
    mock = MiniTest::Mock.new
    mock.expect(:bar, true)

    items = [-> { raise StandardError(:foo) },
             -> { mock.send(:bar) }]

    
    enumerator = DeferredException::Enumerator.new(items)

    begin
      enumerator.each { |fn| fn.call }
    rescue
    end
  end
end

