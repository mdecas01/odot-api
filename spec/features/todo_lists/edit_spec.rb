require 'spec_helper'

describe "Editing todo lists" do
  let!(:todo_list) {todo_list = TodoList.create(title: "Clean up", description: "Clean up the house")}
  
  def update_todo_list(options={})
  	options[:title] ||= "My todo list"
    options[:description] ||= "This is my todo list."

    todo_list = options[:todo_list]

    visit todo_lists_path

  	within "#todo_list_#{todo_list.id}" do
      click_link "Edit"
    end

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]

    click_button "Update Todo list"
  end	

  it "updates todo lists" do
    update_todo_list todo_list: todo_list,
                     title: "New task",
                     description: "This is a new task"
    

    todo_list.reload

    expect(page).to have_content("Todo list was successfully updated")
    expect(todo_list.title).to eq("New task")
    expect(todo_list.description).to eq("This is a new task")
  end
end