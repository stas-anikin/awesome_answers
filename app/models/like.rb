# rails g model like --skip
# --skip flag will help you not to generate a migration for creating a table which is already there(basically it will skip all the files which already exsist)
class Like < ApplicationRecord
    belongs_to :user
    belongs_to :question

    validates(
        :question_id,
        uniqueness:{
            scope: :user_id,
            message: 'has already been liked'
        }
    )
# INVALID DATA
    # like_id| user_id | question_id
    #   1    | 30      | 14  # Compbination of 30  AND 14 can never repeat
    #   2    |  30      | 14
    # VALID DATA
    # like_id| user_id | question_id
    #   1    | 30      | 14  
    #   2    |  31      | 14 # other user can like the same question

end
