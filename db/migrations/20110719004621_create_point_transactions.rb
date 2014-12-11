Sequel.migration do
  change do
    create_table :point_transactions do
      primary_key :id
      integer :sender_id
      integer :receiver_id
      integer :amount
      string :reason
      string :data
      boolean :generated
    end
  end
end
