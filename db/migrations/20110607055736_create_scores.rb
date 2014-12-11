Sequel.migration do
  change do
    create_table :scores do
      primary_key :id
      integer :user_id
      integer :current, :default => 0
      integer :minimum, :default => 0
      integer :maximum, :default => 0
    end
  end
end
