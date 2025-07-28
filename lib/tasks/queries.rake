# frozen_string_literal: true

require_relative "../log"
require_relative "../service/queries/default"

CHOOSE_DATABASE_MESSAGE = "Choose a database using palantir database"
USE_COMMAND_PALANTIR_QUERY_MESSAGE = "Use: rake palantir:query query_name=name"
USE_COMMAND_PALANTIR_EDIT_QUERY_MESSAGE = "Use: rake palantir:edit_query query_name=name"
USE_COMMAND_PALANTIR_EXCLUDE_QUERY_MESSAGE = "Use: rake palantir:exclude_query query_name=name"

namespace :palantir do
  def config
    return unless File.exist?("lib/config/config.json")

    JSON.parse(File.read("lib/config/config.json"))
  end

  def with_query_name(message)
    name = ENV["query_name"]
    if name.nil?
      Log.new.call(self.class, :info, message)
      return
    end
    yield(name)
  end

  desc "List database queries"
  task :queries do
    if File.exist?("lib/config/config.json")
      puts Service::FileUtils::Queries.new(config["database"]).list
    else
      Log.new.call(self.class, :info, CHOOSE_DATABASE_MESSAGE)
    end
  end

  desc "Edit query"
  task :edit_query do
    with_query_name(USE_COMMAND_PALANTIR_EDIT_QUERY_MESSAGE) do |name|
      path = "lib/config/queries/#{config['database']}/#{name}.sql"

      ::FileUtils.mkdir_p("lib/config/queries/#{config['database']}")

      File.open(path, "w") {} unless File.exist?(path)

      editor = ENV["EDITOR"] || "vi"
      system("#{editor} #{path}")
    end
  end

  desc "Delete query"
  task :delete_query do
    with_query_name(USE_COMMAND_PALANTIR_EXCLUDE_QUERY_MESSAGE) do |name|
      path = "lib/config/queries/#{config['database']}/#{name}.sql"

      if File.exist?(path)
        File.delete(path)
        Log.new.call(self.class, :info, "Query #{name} deleted")
      else
        Log.new.call(self.class, :error, Log::NOT_FOUND_MESSAGE)
      end
    end
  end

  desc "Execute a SQL query"
  task :query do
    with_query_name(USE_COMMAND_PALANTIR_QUERY_MESSAGE) do |name|
      if File.exist?("lib/config/config.json")
        query = Service::FileUtils::Queries.new(config["database"]).show(name)

        if query.nil?
          Log.new.call(self.class, :error, Log::NOT_FOUND_MESSAGE)
        else
          Log.new.call(self.class, :info, query)
          Palantir.new(config["database"]).execute("query", query)
        end
      else
        Log.new.call(self.class, :info, CHOOSE_DATABASE_MESSAGE)
      end
    end
  end

  desc "List all tables"
  task :tables do
    if File.exist?("lib/config/config.json")
      query = Service::Queries::Default::TABLES
      Log.new.call(self.class, :info, query)
      Palantir.new(config["database"]).execute("query", query)
    else
      Log.new.call(self.class, :error, Log::NOT_FOUND_MESSAGE)
    end
  end

  desc "List all views"
  task :views do
    if File.exist?("lib/config/config.json")
      query = Service::Queries::Default::VIEWS
      Log.new.call(self.class, :info, query)
      Palantir.new(config["database"]).execute("query", query)
    else
      Log.new.call(self.class, :error, Log::NOT_FOUND_MESSAGE)
    end
  end

  desc "List all functions"
  task :functions do
    if File.exist?("lib/config/config.json")
      query = Service::Queries::Default::FUNCTIONS
      Log.new.call(self.class, :info, query)
      Palantir.new(config["database"]).execute("query", query)
    else
      Log.new.call(self.class, :error, Log::NOT_FOUND_MESSAGE)
    end
  end
end
