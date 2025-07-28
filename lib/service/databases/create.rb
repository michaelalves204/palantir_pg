# frozen_string_literal: true

require 'json'
require 'fileutils'
require_relative '../../log'

module Service
  module Databases
    class Create
      DATABASE_PATH = 'lib/config/databases'

      def initialize(dbname:, username:, password:, port:, host:, sslmode:)
        @dbname = dbname
        @username = username
        @password = password
        @port = port
        @host = host
        @sslmode = sslmode
      end

      def create
        ::FileUtils.mkdir_p(DATABASE_PATH)

        File.open("#{DATABASE_PATH}/#{@dbname}.json", 'w') do |file|
          file.puts JSON.pretty_generate(content)
        end

        true
      rescue StandardError => e
        Log.new.call(self.class.name, :error, e.message)
      end

      private

      def content
        {
          host: @host,
          dbname: @dbname,
          username: @username,
          password: @password,
          port: @port.to_i,
          sslmode: @sslmode
        }
      end
    end
  end
end
