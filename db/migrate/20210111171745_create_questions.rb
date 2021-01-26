class CreateQuestions < ActiveRecord::Migration[6.1]
  # rails g model question title:string body:text
  def change
    create_table :questions do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end

=begin
-   `:binary`
-   `:boolean`
-   `:date`
-   `:datetime`
-   `:decimal`
-   `:float`
-   `:integer`
-   `:bigint`
-   `:primary_key`
-   `:references`
-   `:string`
-   `:text`
-   `:time`
-   `:timestamp`
=end