Sequel.migration do
  up do
    drop_table :golf_players
  end

  down do
    # down code
  end
end
