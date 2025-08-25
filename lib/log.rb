# frozen_string_literal: true

require "logger"

class Log
  NOT_FOUND_MESSAGE = "not found"
  MISSING_MANDATORY_MESSAGE = "Missing mandatory parameters: "
  COLORS = {
    info: "\e[32m",
    error: "\e[31m",
    warn: "\e[33m",
    debug: "\e[34m",
    fatal: "\e[35m",
    unknown: "\e[37m"
  }.freeze

  RESET = "\e[0m"

  def initialize
    @logger = Logger.new("palantir.log", 0, 100 * 1024 * 1024)
    @logger.formatter = proc do |severity, datetime, _progname, msg|
      color = COLORS[severity.downcase.to_sym] || RESET
      "#{color}[#{datetime}] #{severity}: #{msg}#{RESET}\n"
    end
  end

  def call(klass, type, message)
    return if type.nil? || message.nil? || klass.nil?
    return unless COLORS.include?(type.to_sym)

    puts message

    @logger.send(type, message)
  end
end
