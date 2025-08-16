# frozen_string_literal: true

require_relative "../../log"
require "json"

module Service
  module FileUtils
    class Databases
      DATABASE_PATH = "lib/config"

      def self.list
        databases = Dir.glob("#{DATABASE_PATH}/databases/*.json").map do |file|
          File.basename(file, ".json")
        end

        databases.map { |item| item == database ? "* #{item}" : item }
      rescue => e
        Log.new(self.class.name, :error, e.message)
      end

      def self.database
        path = "#{DATABASE_PATH}/config.json"

        return "" unless File.exist?(path)

        JSON.parse(File.read(path))["database"]
      end
    end
  end
end
