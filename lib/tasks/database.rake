# frozen_string_literal: true

require_relative "../log"

DATABASE_USE_FIELDS_MESSAGE = "Use: rake palantir:create_database dbname=... username=... password=... host=... [port=...] [sslmode=...]"
SUCCESSFULLY_CREATED_MESSAGE = " successfully created "
CONFIGURATION_FILE_DATABASE_MESSAGE = "Configuration file for the database "

namespace :palantir do
  def config
    return unless File.exist?("lib/config/config.json")

    JSON.parse(File.read("lib/config/config.json"))
  end

  desc "Displays the databases"
  task :databases do
    puts Service::FileUtils::Databases.list
  end

  desc "List the database that is in use"
  task :database do
    if File.exist?("lib/config/config.json")
      puts config["database"]
    else
      Log.new.call(self.class.name, :info, Log::NOT_FOUND_MESSAGE)
    end
  end

  desc "Set a database"
  task :set_database do
    database_name = ENV["database_name"]

    databases = Service::FileUtils::Databases.list

    if !databases.include?(database_name)
      Log.new.call(self.class, :error, "#{database_name} #{Log::NOT_FOUND_MESSAGE}")
    else
      File.open("lib/config/config.json", "w") do |file|
        file.puts JSON.pretty_generate({ database: database_name })
      end
    end
  end

  desc "Register a database"
  task :create_database do
    required = %w[dbname username password host]
    missing = required.select { |key| ENV[key].nil? }

    if missing.any?
      Log.new.call(self.class, :error, Log::MISSING_MANDATORY_MESSAGE + missing.join(", "))
      Log.new.call(self.class, :info, DATABASE_USE_FIELDS_MESSAGE)
      next
    end

    creator = Service::Databases::Create.new(
      dbname: ENV["dbname"],
      username: ENV["username"],
      password: ENV["password"],
      port: ENV["port"] || "5432",
      host: ENV["host"],
      sslmode: ENV["sslmode"] || "prefer"
    )

    creator.create
    Log.new.call(self.class, :info, CONFIGURATION_FILE_DATABASE_MESSAGE + ENV["dbname"] + SUCCESSFULLY_CREATED_MESSAGE)
  end
end
