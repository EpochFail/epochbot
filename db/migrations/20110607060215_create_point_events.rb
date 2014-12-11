Sequel.migration do
  change do
    create_table :point_events do
      primary_key :id
      integer :user_id
      integer :delta
      string :reason
    end
  end
end
