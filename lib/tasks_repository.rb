require 'sequel'

class TasksRepository
  def insert(task)
    database = Sequel.connect('postgres://gschool_user:password@localhost:5432/tasks_manager')
    tasks_table = database[:tasks]
    tasks_table.insert(task)
  end

  def display_all
    database = Sequel.connect('postgres://gschool_user:password@localhost:5432/tasks_manager')
    tasks_table = database[:tasks]
    tasks_table.select(:name).to_a
  end
end
