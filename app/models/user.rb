class User < ApplicationRecord
    has_many :questions, dependent: :nullify
    has_many :answers, dependent: :nullify

    has_many :job_posts, dependent: :nullify
    # many to many association
    has_many :likes
    has_many :liked_questions, through: :likes, source: :question


    # has_and_belongs_to_many(
    #     :liked_questions, # This is a name of association
    #     {
    #         class_name: 'Question', # This is the name of the model which we are associating to
    #         join_table: 'likes', # This is the name of the join table 
    #         association_foreign_key: 'question_id', # this is the name of the key that will act as a foreign key
    #         foreign_key: 'user_id'

    #     }
    # )
    # Docs:
    # has_and_belongs_to_many(name, scope=nil, {options},&extension)
    # The options are as follows:
    # name 👈🏻 This can be any name 
    # class_name 👈🏻 The model that ehe association points to
    # join_table👈🏻 the name of the join table used for this association
    # foreign_key 👈🏻 on the join table, which key points to the current table
    # association_foreign_key 👈🏻 ont the join tablem which foreign key points to the associated table
    
    has_secure_password
    # Provide user authentication feature on the model that it is called in
    # It requires a password_digest as a column in db and a gem bcrypt as well
    # it will add a presence validation for the password field
    # 👇🏻Sign up
    # it cross verify the password with password confirmation text field
    # 👇🏻Sign In
    # it creates method 'authenticate' to verify password. if called with correct password it will retrun 'true' else 'false'
    def full_name
        "#{first_name} #{last_name}"
    end
end
