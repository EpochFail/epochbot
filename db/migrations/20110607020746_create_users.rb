Sequel.migration do
  change do
    create_table :users do
      primary_key :id
      string :nick
    end
  end
end
