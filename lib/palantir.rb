# frozen_string_literal: true

require_relative "service/connection"
require_relative "service/query"
require_relative "log"
require "json"

class Palantir
  PREFER = "prefer"
  FILE_PATH = "lib/config/databases"

  def initialize(database)
    @database = database
  end

  def execute(command, value = nil)
    @value = value

    send(command)
  rescue => e
    Log.new(self.class.name, :error, e.message)
  end

  private

  def query
    Service::Query.new(connection, @value).execute
  end

  def connection
    @connection ||= Connection.new(
      dbname: config["dbname"],
      username: config["username"],
      password: config["password"],
      host: config["host"],
      port: config["port"],
      sslmode: config["sslmode"] || PREFER
    ).call
  rescue => e
    Log.new.call(self.class.name, :error, e.message)
    nil
  end

  def config
    @config ||=
      JSON.parse(File.read("#{FILE_PATH}/#{@database}.json"))
  end
end
