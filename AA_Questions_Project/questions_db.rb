require 'sqlite3'
require 'singleton'


class QuestionsDatabase < SQLite3::Database
    include Singleton

    def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Question

    attr_accessor :title, :body, :user_id

    def self.find_by_author_id(user_id)
       user = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT
            *
        FROM
            users
        WHERE
            id = ?
        SQL
        
    end

    def self.find_by_id(id)
        question = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            questions
        WHERE
            id = ?
        SQL

        return nil unless question.length > 0
        Question.new(question.first)
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @user_id = options['user_id']
    end

end

class User
    attr_accessor :fname, :lname

    def self.find_by_id(id)
        user = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            users
        WHERE
            id = ?
        SQL

        return nil unless user.length > 0
        User.new(user.first)
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

end

class QuestionFollow

    attr_accessor :question_id, :user_id

    def self.find_by_id(id)
        question = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            question_follows
        WHERE
            id = ?
        SQL

        return nil unless question.length > 0
        QuestionFollow.new(question.first)
    end

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @user_id = options['user_id']
    end

end

class Reply

    attr_accessor :body, :user_id, :reply_id, :question_id

    def self.find_by_user_id(user_id)
        user = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT
            *
        FROM
            users
        WHERE
            id = ?
        SQL
        
    end

    def self.find_by_question_id(question_id)
        question = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
            *
        FROM
            questions
        WHERE
            id = ?
        SQL
        
    end

    def self.find_by_id(id)
        reply = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            replies
        WHERE
            id = ?
        SQL

        return nil unless reply.length > 0
        Reply.new(reply.first)
    end

    def initialize(options)
        @body = options['body']
        @reply_id = options['reply_id']
        @question_id = options['question_id']
        @user_id = options['user_id']
    end

end

class QuestionLike

    attr_accessor :like_b, :question_id, :user_id

    def self.find_by_id(id)
        like = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            question_likes
        WHERE
            id = ?
        SQL

        return nil unless like.length > 0
        QuestionLike.new(like.first)
    end

    def initialize(options)
        @like_b = options['like_b']
        @question_id = options['question_id']
        @user_id = options['user_id']
    end

end