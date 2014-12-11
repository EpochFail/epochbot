Sequel.migration do
  up do
    drop_table :todo
  end

  down do
    # down code
  end
end
