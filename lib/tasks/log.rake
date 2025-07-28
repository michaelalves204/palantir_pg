# frozen_string_literal: true

namespace :palantir do
  desc "Displays logs"
  task :logs do
    puts File.open("palantir.log").read
  end
end
