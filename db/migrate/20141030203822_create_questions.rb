class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :text
      t.string :correct_answer
      t.timestamps
    end
  end
end
