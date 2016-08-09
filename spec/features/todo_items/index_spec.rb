require 'spec_helper'

describe "Viewing a todo item" do 
  let!(:todo_list) { TodoList.create!(title: "Clean up", description: "Clean up the house")}
  
  def visit_todo_list(list) 
    visit todo_lists_path

    within "#todo_list_#{todo_list.id}" do
      click_link "List Items"
    end 
  end 		

  it "displays the title of the todo list" do	
  	visit_todo_list(todo_list)
    within("h1") do
      expect(page).to have_content(todo_list.title)
    end 	
  end	

  it "displays no item when todo list is empty" do
    visit_todo_list(todo_list)
    expect(page.all("ul.todo_items Li").size).to eq(0)
  end	

  it "displays items content when todo list has items" do
    todo_list.todo_items.create(content: "Kitchen")
    todo_list.todo_items.create(content: "Bathroom")

    visit_todo_list(todo_list)
    expect(page.all("ul.todo_items Li").size).to eq(2)

    within "ul.todo_items" do
      expect(page).to have_content("Kitchen")
      expect(page).to have_content("Bathroom")
    end  
  end	
end