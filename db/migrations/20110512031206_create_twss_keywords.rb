Sequel.migration do
  change do
    create_table :twss_keywords do
      primary_key :id
      string :word
    end
  end
end
