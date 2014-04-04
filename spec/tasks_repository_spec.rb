require 'rspec'
require 'tasks_repository'


describe 'it manages tasks' do

  before do
    db ||= Sequel.connect('postgres://gschool_user:password@localhost:5432/tasks_manager')
    db.create_table! :tasks do
      primary_key :id
      String :name
      FalseClass :completed
    end
    db.set_column_default :tasks, :completed, false
    @tasks = TasksRepository.new(db)
    @tasks.insert({:name => 'Get milk'})
    @tasks.insert({:name => 'Get eggs'})
  end

  it 'allows a user to insert information into a database' do
    expect(@tasks.display_all).to eq [
                      {:id => 1, :name => 'Get milk', :completed => false},
                      {:id => 2, :name => 'Get eggs', :completed => false}
                                    ]
  end

  it 'allows a user to update tasks' do
    @tasks.update(1, {:name =>'Get bread'})
    @tasks.update(2, {:name =>'Get cereal', :completed => true})
    expect(@tasks.display_all).to eq [
                      {:id => 1, :name => 'Get bread', :completed => false},
                      {:id => 2, :name => 'Get cereal', :completed => true}
                                    ]
  end

  it 'allows a user to delete tasks' do
    @tasks.delete(1)
    expect(@tasks.display_all).to eq [
                      {:id => 2, :name => 'Get eggs', :completed => false}
                                    ]
  end

  it 'allows a user to views tasks by id' do
    expect(@tasks.display_task_by_id(1)).to eq({:id => 1, :name => 'Get milk', :completed => false})
  end

  it 'allows a user to find all the tasks in the table' do
    expect(@tasks.display_all_tasks).to eq [
                      {:name => 'Get milk'},
                      {:name => 'Get eggs'}
                                          ]
  end
end