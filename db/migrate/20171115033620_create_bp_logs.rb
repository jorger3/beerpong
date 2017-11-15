class CreateBpLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :bp_logs do |t|
      t.belongs_to :user, index: true
      t.string :table
      t.integer :data_id
      t.string :action
      t.string :controller

      t.timestamps
    end
  end
end
