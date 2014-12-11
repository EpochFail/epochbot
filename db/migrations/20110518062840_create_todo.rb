Sequel.migration do
  change do
    create_table :todo do
      primary_key :id
      string :task
	  string :assignedTo
	  integer :completed
	end
  end
end

