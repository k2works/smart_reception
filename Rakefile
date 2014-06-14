%w{ bundler find rake/testtask}.each { |lib| require lib }

task :default => :spec

Rake::TestTask.new(:spec) do |t|
  t.test_files = FileList['spec/*_spec.rb']
end

namespace :db do
  desc "Run all migrations in db/migrate"
  task :migrate => :connect do
    Sequel.extension(:migration)
    Sequel::Migrator.apply(DB, "db/migrate")
  end

  task :connect => :environment do
    require "./config/initializers/database"
  end
end

namespace :app do |t|
  desc "Rakeタスク"
  task :something_rake do
    require "./config/initializers/application"
  end
end
