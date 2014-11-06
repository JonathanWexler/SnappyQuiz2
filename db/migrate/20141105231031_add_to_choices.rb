class AddToChoices < ActiveRecord::Migration
  def change
  	add_column :choices, :text, :string
  	add_column :choices, :correct, :boolean
  	add_column :choices, :question_id, :integer
  end
end
