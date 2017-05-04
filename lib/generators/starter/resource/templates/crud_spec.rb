require "rails_helper"

feature "<%= plural_table_name.humanize.upcase %>" do
<% attributes.each do |attribute| -%>
  context "index" do
    it "has the <%= attribute.human_name.downcase %> of every row", points: 5 do
      test_<%= plural_table_name %> = create_list(:<%= singular_table_name %>, 5)

      visit "/<%= plural_table_name %>"

      test_<%= plural_table_name %>.each do |current_<%= singular_table_name %>|
        expect(page).to have_content(current_<%= singular_table_name %>.<%= attribute.name %>)
      end
    end
  end

<% end -%>
  context "index" do
    it "has a link to the details page of every row", points: 5 do
      test_<%= plural_table_name %> = create_list(:<%= singular_table_name %>, 5)

      visit "/<%= plural_table_name %>"

      test_<%= plural_table_name %>.each do |current_<%= singular_table_name %>|
        expect(page).to have_css("a[href*='#{current_<%= singular_table_name %>.id}']", text: "Show details")
      end
    end
  end

<% attributes.each do |attribute| -%>
  context "details page" do
    it "has the correct <%= attribute.human_name.downcase %>", points: 3 do
      <%= singular_table_name %>_to_show = create(:<%= singular_table_name %>)

      visit "/<%= plural_table_name %>"
      find("a[href*='#{<%= singular_table_name %>_to_show.id}']", text: "Show details").click

      expect(page).to have_content(<%= singular_table_name %>_to_show.<%= attribute.name %>)
    end
  end

<% end -%>
  context "index" do
    it "has a link to the new <%= singular_table_name.humanize.downcase %> page", points: 2 do
      visit "/<%= plural_table_name %>"

      expect(page).to have_css("a", text: "Add a new <%= singular_table_name.humanize.downcase %>")
    end
  end

<% attributes.each do |attribute| -%>
  context "new form" do
    it "saves the <%= attribute.human_name.downcase %> when submitted", points: 2, hint: h("label_for_input") do
      visit "/<%= plural_table_name %>"
      click_on "Add a new <%= singular_table_name.humanize.downcase %>"

      test_<%= attribute.name %> = "A fake <%= attribute.human_name.downcase %> I'm typing at #{Time.now}"
      fill_in "<%= attribute.human_name %>", with: test_<%= attribute.name %>
      click_on "Create <%= singular_table_name.humanize %>"

      last_<%= singular_table_name %> = <%= singular_name.camelize %>.order(created_at: :asc).last
      expect(last_<%= singular_table_name %>.<%= attribute.name %>).to eq(test_<%= attribute.name %>)
    end
  end

<% end -%>
  context "new form" do
    it "redirects to the index when submitted", points: 2, hint: h("redirect_vs_render") do
      visit "/<%= plural_table_name %>"
      click_on "Add a new <%= singular_table_name.humanize.downcase %>"

      click_on "Create <%= singular_table_name.humanize.downcase %>"

      expect(page).to have_current_path("/<%= plural_table_name %>")
    end
  end

  context "details page" do
    it "has a 'Delete' link", points: 2 do
      <%= singular_table_name %>_to_delete = create(:<%= singular_table_name %>)

      visit "/<%= plural_table_name %>"
      find("a[href*='#{<%= singular_table_name %>_to_delete.id}']", text: "Show details").click

      expect(page).to have_css("a", text: "Delete")
    end
  end

  context "delete link" do
    it "removes a row from the table", points: 5 do
      <%= singular_table_name %>_to_delete = create(:<%= singular_table_name %>)

      visit "/<%= plural_table_name %>"
      find("a[href*='#{<%= singular_table_name %>_to_delete.id}']", text: "Show details").click
      click_on "Delete"

      expect(<%= singular_name.camelize %>.exists?(<%= singular_table_name %>_to_delete.id)).to be(false)
    end
  end

  context "delete link" do
    it "redirects to the index", points: 3, hint: h("redirect_vs_render") do
      <%= singular_table_name %>_to_delete = create(:<%= singular_table_name %>)

      visit "/<%= plural_table_name %>"
      find("a[href*='#{<%= singular_table_name %>_to_delete.id}']", text: "Show details").click
      click_on "Delete"

      expect(page).to have_current_path("/<%= plural_table_name %>")
    end
  end

  context "details page" do
    it "has an 'Edit' link", points: 5 do
      <%= singular_table_name %>_to_edit = create(:<%= singular_table_name %>)

      visit "/<%= plural_table_name %>"
      find("a[href*='#{<%= singular_table_name %>_to_edit.id}']", text: "Show details").click

      expect(page).to have_css("a", text: "Edit")
    end
  end

<% attributes.each do |attribute| -%>
  context "edit form" do
    it "has <%= attribute.human_name.downcase %> pre-populated", points: 3, hint: h("value_attribute") do
      test_<%= attribute.name %> = "Some fake pre-existing <%= attribute.human_name.downcase %> at #{Time.now}"
      <%= singular_table_name %>_to_edit = create(:<%= singular_table_name %>, <%= attribute.name %>: test_<%= attribute.name %>)

      visit "/<%= plural_table_name %>"
      find("a[href*='#{<%= singular_table_name %>_to_edit.id}']", text: "Show details").click
      click_on "Edit"

      expect(page).to have_css("input[value='#{test_<%= attribute.name %>}']")
    end
  end

<% end -%>
<% attributes.each do |attribute| -%>
  context "edit form" do
    it "updates <%= attribute.human_name.downcase %> when submitted", points: 5, hint: h("label_for_input button_type") do
      <%= singular_table_name %>_to_edit = create(:<%= singular_table_name %>, <%= attribute.name %>: "Boring old <%= attribute.human_name.downcase %>")

      visit "/<%= plural_table_name %>"
      find("a[href*='#{<%= singular_table_name %>_to_edit.id}']", text: "Show details").click
      click_on "Edit"

      test_<%= attribute.name %> = "Exciting new <%= attribute.human_name.downcase %> at #{Time.now}"
      fill_in "<%= attribute.human_name %>", with: test_<%= attribute.name %>
      click_on "Update <%= singular_table_name.humanize.downcase %>"

      photo_as_revised = <%= singular_name.camelize %>.find(<%= singular_table_name %>_to_edit.id)

      expect(photo_as_revised.<%= attribute.name %>).to eq(test_<%= attribute.name %>)
    end
  end

<% end -%>
  context "edit form" do
    it "redirects to the details page", points: 3, hint: h("embed_vs_interpolate redirect_vs_render") do
      <%= singular_table_name %>_to_edit = create(:<%= singular_table_name %>)

      visit "/<%= plural_table_name %>"
      find("a[href*='#{<%= singular_table_name %>_to_edit.id}']", text: "Show details").click
      click_on "Edit"
      click_on "Update <%= singular_table_name.humanize.downcase %>"

      expect(page).to have_current_path(/.*#{<%= singular_table_name %>_to_edit.id}.*/)
    end
  end
end
