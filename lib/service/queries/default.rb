# frozen_string_literal: true

module Service
  module Queries
    class Default
      TABLES = <<~SQL
        SELECT tablename
        FROM pg_tables
        WHERE schemaname = 'public';
      SQL

      VIEWS = <<~SQL
        SELECT viewname
        FROM pg_views
        WHERE schemaname = 'public';
      SQL

      FUNCTIONS = <<~SQL
        SELECT routine_name
        FROM information_schema.routines
        WHERE routine_schema = 'public';
      SQL
    end
  end
end
