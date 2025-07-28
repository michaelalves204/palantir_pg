# frozen_string_literal: true

require_relative 'lib/service/file_utils/databases'
require_relative 'lib/service/file_utils/queries'
require_relative 'lib/service/databases/create'
require_relative 'lib/palantir'
Dir.glob('lib/tasks/**/*.rake').each { |r| import r }

namespace :palantir do
  desc 'Palantir'
  task :logo do
    puts <<~ASCII
      ▗▄▄▖  ▗▄▖ ▗▖    ▗▄▖ ▗▖  ▗▖▗▄▄▄▖▗▄▄▄▖▗▄▄▖
      ▐▌ ▐▌▐▌ ▐▌▐▌   ▐▌ ▐▌▐▛▚▖▐▌  █    █  ▐▌ ▐▌
      ▐▛▀▘ ▐▛▀▜▌▐▌   ▐▛▀▜▌▐▌ ▝▜▌  █    █  ▐▛▀▚▖
      ▐▌   ▐▌ ▐▌▐▙▄▄▖▐▌ ▐▌▐▌  ▐▌  █  ▗▄█▄▖▐▌ ▐▌
    ASCII
  end

  desc 'Documentation'
  task :doc do
    puts File.open("doc.txt").read
  end
end

task Pdoc: 'palantir:doc'
task Plogo: 'palantir:logo'
task Pdatabase: 'palantir:database'
task Pset_database: 'palantir:set_database'
task Pdatabases: 'palantir:databases'
task Ptables: 'palantir:tables'
task Pviews: 'palantir:views'
task Pfunctions: 'palantir:functions'
task Pqueries: 'palantir:queries'
task Pedit_query: 'palantir:edit_query'
task Pdelete_query: 'palantir:delete_query'
task Pquery: 'palantir:query'
task Pcreate_db: 'palantir:create_database'
task Plogs: 'palantir:logs'
