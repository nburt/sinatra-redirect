require 'rspec'
require 'tasks_repository'


describe 'it manages tasks' do
  before do
    DB = Sequel.connect('postgres://gschool_user:password@localhost:5432/tasks_manager')
    DB.create_table! :tasks do
      primary_key :id
      String :name
    end
  end
  it 'allows a user to insert information into a database' do
    tasks = TasksRepository.new(DB)
    tasks.insert({:name => 'Get milk'})
    tasks.insert({:name => 'Get eggs'})
    expect(tasks.display_all).to eq [{:name => 'Get milk'},{:name => 'Get eggs'}]
  end
end
