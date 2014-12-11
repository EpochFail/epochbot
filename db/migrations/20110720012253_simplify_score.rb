Sequel.migration do
  up do
    drop_table :scores
    drop_table :point_events
    add_column :users, :score, Integer, :default => 0

    DB[:users].update(:score => 0)
  end

  down do
    # down code
  end
end
