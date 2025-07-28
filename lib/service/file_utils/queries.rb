# frozen_string_literal: true

require_relative "../../log"

module Service
  module FileUtils
    class Queries
      QUERIES_PATH = "lib/config/queries"
      def initialize(database)
        @database = database
      end

      def list
        Dir.glob("#{QUERIES_PATH}/#{@database}/*.sql").map { |file| File.basename(file) }
      rescue => e
        Log.new(self.class.name, :error, e.message)
      end

      def show(query)
        return unless list.include?("#{query}.sql")

        File.open("#{QUERIES_PATH}/#{@database}/#{query}.sql").read
      rescue => e
        Log.new(self.class.name, :error, e.message)
      end
    end
  end
end
