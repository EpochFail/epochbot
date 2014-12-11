Sequel.migration do
  change do
    create_table :twss_exclude do
      primary_key :id
      string :word
    end
  end
end
