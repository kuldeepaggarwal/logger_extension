require 'logger'
require 'logger_extension/multiple_devise'

module LoggerExtension
  class MultiIOLogger < Logger

    def initialize(*targets)
      super(MultipleDevise.new(*targets))
    end
  end
end
