class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      # 2 Keys here:
      # Foreign key: question_id will be the foreign key in this table
      # Primary Key: The auto generated id column that will be created after running this migration for answer table will act as a primary key in this answer table
      t.text :body

      # t.references :question, null: false, foreign_key: true
      t.references :question, foreign_key: true

      # Prevent you from adding an answer whose question_id doesnt 
      # exsist
      
      # dependent: :destroy
      # It also stops you to delete a question whose answer are yet not deleted

      t.timestamps
    end
  end
end
