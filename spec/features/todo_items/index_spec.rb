require 'spec_helper'

describe "Viewing a todo item" do 
  let!(:todo_list) { TodoList.create(title: "Clean up", description: "Clean up the house")}

  it "displays no item when todo list is empty" do
    visit todo_lists_path

    within "#todo_list_#{todo_list.id}" do
      click_link "List Items"
    end 	

    expect(page).to have_content("TodoItems#index")
  end	
end