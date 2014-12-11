Sequel.migration do
  up do
    alter_table :point_events do
      add_column :actor, String
      add_column :data, String, :text => true
      drop_column :reason
    end
  end

  down do
    alter_table :point_events do
      drop_column :actor
      drop_column :data
      add_column :reason, String
    end
  end
end
