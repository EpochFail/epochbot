require "rubot"

# super hax to make testing use a test db instead of blowing away the dev one
Object.send :remove_const, :DB
DB = Sequel.sqlite("db/test.db")
Sequel.extension :migration
Sequel::Migrator.apply(DB, "db/migrations")

Dir["resources/**/*.rb", "controllers/**/*.rb"].each { |f| require File.expand_path(f) }

# blow away the database!
DB.transaction do
  [:point_transactions, :users].each { |table| DB[table].delete }
end