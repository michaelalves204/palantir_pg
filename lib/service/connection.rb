# frozen_string_literal: true

require "pg"
require_relative "../log"

class Connection
  def initialize(dbname:, username:, password:, port:, host:, sslmode:)
    @dbname = dbname
    @username = username
    @password = password
    @port = port
    @host = host
    @sslmode = sslmode
  end

  def call
    PG.connect(
      host: @host,
      dbname: @dbname,
      user: @username,
      password: @password,
      port: @port
    )
  end
end
