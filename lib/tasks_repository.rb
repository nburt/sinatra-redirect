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
    @tasks_table.all
  end

  def display_task_by_id(task_id)
    @tasks_table[:id => task_id]
  end

  def display_all_tasks
    @tasks_table.select(:name).to_a
  end

  def update(task_id, info_to_update)
    @tasks_table.where(:id => task_id).update(info_to_update)
  end

  def delete(task_id)
    @tasks_table.where(:id => task_id).delete
  end
end
