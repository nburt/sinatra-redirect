require 'rspec'
require 'tasks_repository'


describe 'it manages tasks' do

  before do
    DB ||= Sequel.connect('postgres://gschool_user:password@localhost:5432/tasks_manager')
    DB.create_table! :tasks do
      primary_key :id
      String :name
      FalseClass :completed
    end
    DB.set_column_default :tasks, :completed, false
    @tasks = TasksRepository.new(DB)
  end

  it 'allows a user to insert information into a database' do
    @tasks.insert({:name => 'Get milk'})
    @tasks.insert({:name => 'Get eggs'})
    expect(@tasks.display_all).to eq [
                      {:id => 1, :name => 'Get milk', :completed => false},
                      {:id => 2, :name => 'Get eggs', :completed => false}
                                    ]
  end

  it 'allows a user to update tasks' do
    @tasks.insert({:name => 'Get milk'})
    @tasks.insert({:name => 'Get eggs'})
    @tasks.update(1, {:name =>'Get bread'})
    @tasks.update(2, {:name =>'Get cereal', :completed => true})
    expect(@tasks.display_all).to eq [
                      {:id => 1, :name => 'Get bread', :completed => false},
                      {:id => 2, :name => 'Get cereal', :completed => true}
                                    ]
  end

  it 'allows a user to delete tasks' do
    @tasks.insert({:name => 'Get milk'})
    @tasks.insert({:name => 'Get eggs'})
    @tasks.delete(1)
    expect(@tasks.display_all).to eq [
                      {:id => 2, :name => 'Get eggs', :completed => false}
                                    ]
  end
end