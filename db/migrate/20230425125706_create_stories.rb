# frozen_string_literal: true

class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.string :name
      t.text :description
      t.references :column, null: false, foreign_key: true

      t.timestamps
    end
  end
end
