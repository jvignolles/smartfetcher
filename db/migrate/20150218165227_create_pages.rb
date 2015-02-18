class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string   :page_id, :limit => 128,                 :null => false
      t.timestamps
    end
  end
end
