require 'spec_helper'

describe "Adding a todo item" do 
  let!(:todo_list) { TodoList.create!(title: "Clean up", description: "Clean up the house")}
  
  def visit_todo_list(list) 
    visit todo_lists_path

    within "#todo_list_#{todo_list.id}" do
      click_link "List Items"
    end 
  end 

  it "is successfull with valid content" do
    visit_todo_list(todo_list)
    click_link "New Todo Item"

    fill_in "Content", with: "Kitchen"
    click_button "Save"

    expect(page).to have_content("Added todo list item.")

    within("ul.todo_items") do
      expect(page).to have_content("Kitchen")
    end	
  end

end  		

