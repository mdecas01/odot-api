require 'spec_helper'

describe "Creating todo lists" do
	it "redirects to the todo list index" do
      visit "/todo_lists"
      click_link "New Todo list"
      expect(page).to have_content("New todo_list")

      fill_in "Title", with: "todo list"
      fill_in "Description", with: "some description."

      click_button "Create Todo list"

      expect(page).to have_text("todo list")
    end	

    it "displays error if no title" do
      expect(TodoList.count).to eq(0)

      visit "/todo_lists"
      click_link "New Todo list"
      expect(page).to have_content("New todo_list")

      
      fill_in "Description", with: "some description."

      click_button "Create Todo list"

      expect(page).to have_content("error")
      expect(TodoList.count).to eq(0)

      visit "/todo_lists"
      expect(page).to_not have_content("some description")
    end	

    it "displays error if no title has less than 3 characteres" do
      expect(TodoList.count).to eq(0)

      visit "/todo_lists"
      click_link "New Todo list"
      expect(page).to have_content("New todo_list")

      fill_in "Title", with: "to"
      fill_in "Description", with: "some description."

      click_button "Create Todo list"

      expect(page).to have_content("error")
      expect(TodoList.count).to eq(0)

      visit "/todo_lists"
      expect(page).to_not have_content("some description")
    end	
end