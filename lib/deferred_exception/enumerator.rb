module DeferredException
  class Enumerator
    include Enumerable

    attr_accessor :enumerator

    def initialize(enumerator)
      self.enumerator = enumerator
    end

    def each(&block)
      enumerator.each do |item|
        begin
          block.call(item)
        rescue StandardError => e
          exceptions.push(e)
        end
      end

      unless exceptions.empty?
        raise DeferredException::ExceptionSet.new(exceptions)
      end

      enumerator
    end

    def exceptions
      @exceptions ||= []
    end
  end
end
