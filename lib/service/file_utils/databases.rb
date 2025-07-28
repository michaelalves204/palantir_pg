# frozen_string_literal: true

require_relative "../../log"

module Service
  module FileUtils
    class Databases
      DATABASE_PATH = "lib/config/databases"

      def self.list
        Dir.glob("#{DATABASE_PATH}/*.json").map do |file|
          File.basename(file, ".json")
        end
      rescue => e
        Log.new(self.class.name, :error, e.message)
      end
    end
  end
end
