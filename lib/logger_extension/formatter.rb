module LoggerExtension
  class Formatter
    Format = "\n#{ '#' * 143 }\n[%s], [%s] %5s:\n %s\n#{ '#' * 143 }\n"
    DEFAULT_FORMAT = '%Y-%m-%d %H:%M:%S'

    attr_accessor :datetime_format

    def initialize(datetime_format = nil)
      @datetime_format = datetime_format || DEFAULT_FORMAT
    end

    def call(severity, time, progname, msg)
      Format % [progname, format_datetime(time), severity, msg2str(msg)]
    end

    private

    def msg2str(msg)
      case msg
      when ::String
        msg
      when ::Exception
        "#{ msg.message } (#{ msg.class })\n" <<
          (msg.backtrace || []).join("\n")
      else
        msg.inspect
      end
    end

    def format_datetime(time)
      time.strftime(@datetime_format)
    end
  end
end