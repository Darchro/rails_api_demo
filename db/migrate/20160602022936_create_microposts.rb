class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.references :user, index: true
      t.text :content
      t.timestamps null: false
    end
  end
end
