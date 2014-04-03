require 'rspec'
require 'tasks_repository'

describe 'it manages tasks' do
  it 'allows a user to insert information into a database' do
    tasks = TasksRepository.new
    database = Sequel.connect('postgres://gschool_user:password@localhost:5432/tasks_manager')
    database.create_table! :tasks do
      primary_key :id
      String :name
    end
    tasks.insert({:name => 'Get milk'})
    tasks.insert({:name => 'Get eggs'})
    expect(tasks.display_all).to eq [{:name => 'Get milk'},{:name => 'Get eggs'}]
  end
end
