class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string   :name,    null: false, limit: 128
      # `page_id` may be a bigint, need confirm
      t.string   :page_id, null: false, limit: 64
      t.timestamps
    end

    add_index :pages, :name
    add_index :pages, :page_id
  end
end
