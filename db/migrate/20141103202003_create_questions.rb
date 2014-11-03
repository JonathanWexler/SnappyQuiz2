class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :quiz, index: true
      t.integer :numer
      t.string :text

      t.timestamps
    end
  end
end
