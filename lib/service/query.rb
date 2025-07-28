# frozen_string_literal: true

require_relative "../log"
require 'byebug'

module Service
  class Query
    def initialize(conn, value)
      @conn = conn
      @value = value
    end

    def execute
      return false unless value

      begin
        result = @conn.exec(value)

        return render(result) if result.cmd_status.split(" ")[0] == "SELECT" && result.nfields.positive?

        Log.new.call(self.class.name, :info, result.cmd_status)
      rescue PG::UndefinedTable => e
        error_message(e.message)
      rescue PG::SyntaxError => e
        error_message(e.message)
      rescue => e
        error_message(e.message)
      ensure
        @conn&.close
      end
    end

    private

    def render(value)
      return [] if value.ntuples.zero?

      puts value.fields.join(" | ")
      puts "-" * value.fields.join(" | ").length

      value.each do |row|
        puts row.values.join(" | ")
        puts "\n"
      end
    end

    def error_message(message)
      Log.new.call(self.class.name, :error, message)
    end

    attr_reader :value
  end
end
