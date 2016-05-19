require 'spec_helper'

describe "Creating todo lists" do

  def create_todo_list(options={})
    options[:title] ||= "My todo list"
    options[:description] ||= "This is my todo list."

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New todo_list")
    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]

    click_button "Create Todo list"
  end	

	it "redirects to the todo list index" do
      create_todo_list title: "todo list"

      expect(page).to have_text("todo list")
    end	

    it "displays error if no title" do
      expect(TodoList.count).to eq(0)

      create_todo_list title: ""

      expect(page).to have_content("error")
      expect(TodoList.count).to eq(0)

      visit "/todo_lists"
      expect(page).to_not have_content("some description")
    end	

    it "displays error if no title has less than 3 characteres" do
      expect(TodoList.count).to eq(0)

      create_todo_list title: "to"
      expect(page).to have_content("error")
      expect(TodoList.count).to eq(0)

      visit "/todo_lists"
      expect(page).to_not have_content("some description")
    end	

    it "displays error if no description" do
      expect(TodoList.count).to eq(0)

      create_todo_list description: ""

      expect(page).to have_content("error")
      expect(TodoList.count).to eq(0)

      visit "/todo_lists"
      expect(page).to_not have_content("some description")
    end	

    it "displays error if  description has less than 5 characteres" do
      expect(TodoList.count).to eq(0)

      create_todo_list description: "this"

      expect(page).to have_content("error")
      expect(TodoList.count).to eq(0)

      visit "/todo_lists"
      expect(page).to_not have_content("some description")
    end	

end