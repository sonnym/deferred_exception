module DeferredException
  class ExceptionSet < StandardError
    attr_accessor :exceptions
    
    def initialize(exceptions)
      self.exceptions = exceptions
    end

    def message
      exceptions.map { |exception| individual_message(exception) }.join("\n#{'=' * 5}\n") 
    end

    private
    def individual_message(exception)
      "#{exception.message}#{"\n#{exception.backtrace.join("\n")}" unless exception.backtrace.nil?}"
    end
  end
end
