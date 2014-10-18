require 'forwardable'
module LoggerExtension
  class MultipleDevise
    extend Forwardable

    class LogDeviceMutex
      include MonitorMixin
    end
    
    attr_reader :default_formatter
    attr_accessor :default_progname

    def initialize(*targets)
      @targets = targets.each { |target| target.sync = true if target.respond_to?(:sync=) }
      @default_formatter = ::LoggerExtension::Formatter.new
      @mutex = LogDeviceMutex.new
    end

    def_delegator :@default_formatter, :datetime_format
    def_delegator :@default_formatter, :datetime_format=

    def write(*arguments)
      @targets.each { |target|
         begin
          @mutex.synchronize do
            begin
              target.write(*arguments)
            rescue
              log_exception('WARN', 'log writing failed.--->', $!)
            end
          end
        rescue Exception => ignored
          log_exception('WARN', 'log writing failed.--->', ignored)
        end
      }
    end

    def close
      @targets.each do |target|
        begin
          @mutex.synchronize do
            target.close rescue nil
          end
        rescue Exception
          target.close rescue nil
        end
      end
    end

    private
      def log_exception(severity, message, exception)
        write_message(message.to_s + default_formatter.call(severity, Time.now, default_progname, exception).to_s)
      end

      def write_message(message)
        STDOUT.write message
      end
  end
end