require 'logger'
require 'singleton'

require 'pqueue'

module GoSim
  module Base
    # TODO: Figure out what we want to do for a logging framework.
    @@log = Logger.new(STDERR)
    @@log.level = Logger::FATAL

    # So that all derived classes have an easy accessor
    def log
      @@log
    end

    # Turn down logging all the way (nice for unit tests etc...)
    def quiet
      @@log.level = Logger::FATAL
    end

    def verbose
      @@log.level = Logger::DEBUG
    end
  end
end

require 'gosim/simulation'
require 'gosim/network'
require 'gosim/data'

# Make the logger report simulation time instead of real-time.
class Logger #:nodoc:
  @@sim = GoSim::Simulation.instance

  private
  alias old_format_message format_message

  def format_message(severity, timestamp, progname, msg)
    "#{@@sim.time}: #{msg}\n"
  end
end