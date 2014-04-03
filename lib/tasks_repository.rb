require 'sequel'

class TasksRepository
  def initialize(db)
    @db = db
    @tasks_table = @db[:tasks]
  end

  def insert(task)
    @tasks_table.insert(task)
  end

  def display_all
    @tasks_table.select(:name).to_a
  end
end
