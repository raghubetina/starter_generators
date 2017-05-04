require "rails_helper"

feature "<%= plural_table_name.upcase %>" do
<% attributes.each do |attribute| -%>
  context "index" do
    it "has the <%= singular_name %> of every row", points: 5 do
      test_<%= plural_table_name %> = create_list(:<%= singular_table_name %>, 5)

      visit "/<%= plural_table_name %>"

      test_<%= plural_table_name %>.each do |current_<%= singular_table_name %>|
        expect(page).to have_content(current_<%= singular_table_name %>.<%= attribute.name %>)
      end
    end
  end

<% end -%>


  context "index" do
    it "has the caption of every row", points: 5 do
      test_photos = create_list(:photo, 5)

      visit "/photos"

      test_photos.each do |current_photo|
        expect(page).to have_content(current_photo.caption)
      end
    end
  end

  context "index" do
    it "has a link to the details page of every row", points: 5 do
      test_photos = create_list(:photo, 5)

      visit "/photos"

      test_photos.each do |current_photo|
        expect(page).to have_css("a[href*='#{current_photo.id}']", text: "Show details")
      end
    end
  end

  context "details page" do
    it "has the correct source", points: 3 do
      photo_to_show = create(:photo)

      visit "/photos"
      click_on "Show details"

      expect(page).to have_content(photo_to_show.source)
    end
  end

  context "details page" do
    it "has the correct caption", points: 3 do
      photo_to_show = create(:photo)

      visit "/photos"
      click_on "Show details"

      expect(page).to have_content(photo_to_show.caption)
    end
  end

  context "index" do
    it "has a link to the new photo page", points: 2 do
      visit "/photos"

      expect(page).to have_css("a", text: "Add a new photo")
    end
  end

  context "new form" do
    it "saves the source when submitted", points: 2, hint: h("label_for_input") do
      visit "/photos"
      click_on "Add a new photo"

      test_source = "A fake source I'm typing at #{Time.now}"
      fill_in "Source", with: test_source
      click_on "Create Photo"

      last_photo = Photo.order(created_at: :asc).last
      expect(last_photo.source).to eq(test_source)
    end
  end

  context "new form" do
    it "saves the caption when submitted", points: 2, hint: h("label_for_input") do
      visit "/photos"
      click_on "Add a new photo"

      test_caption = "A fake caption I'm typing at #{Time.now}"
      fill_in "Caption", with: test_caption
      click_on "Create Photo"

      last_photo = Photo.order(created_at: :asc).last
      expect(last_photo.caption).to eq(test_caption)
    end
  end

  context "new form" do
    it "redirects to the index when submitted", points: 2, hint: h("redirect_vs_render") do
      visit "/photos"
      click_on "Add a new photo"

      click_on "Create Photo"

      expect(page).to have_current_path("/photos")
    end
  end

  context "details page" do
    it "has a 'Delete' link", points: 2 do
      create(:photo)

      visit "/photos"
      click_on "Show details"

      expect(page).to have_css("a", text: "Delete")
    end
  end

  context "delete link" do
    it "removes a row from the table", points: 5 do
      photo_to_delete = create(:photo)

      visit "/photos"
      click_on "Show details"
      click_on "Delete"

      expect(Photo.exists?(photo_to_delete.id)).to be(false)
    end
  end

  context "delete link" do
    it "redirects to the index", points: 3, hint: h("redirect_vs_render") do
      create(:photo)

      visit "/photos"
      click_on "Show details"
      click_on "Delete"

      expect(page).to have_current_path("/photos")
    end
  end

  context "details page" do
    it "has an 'Edit' link", points: 5 do
      create(:photo)

      visit "/photos"
      click_on "Show details"

      expect(page).to have_css("a", text: "Edit")
    end
  end

  context "edit form" do
    it "has source pre-populated", points: 3, hint: h("value_attribute") do
      test_source = "Some fake pre-existing source at #{Time.now}"
      create(:photo, source: test_source)

      visit "/photos"
      click_on "Show details"
      click_on "Edit"

      expect(page).to have_css("input[value='#{test_source}']")
    end
  end

  context "edit form" do
    it "has caption pre-populated", points: 3, hint: h("value_attribute") do
      test_caption = "Some fake pre-existing caption at #{Time.now}"
      create(:photo, caption: test_caption)

      visit "/photos"
      click_on "Show details"
      click_on "Edit"

      expect(page).to have_css("input[value='#{test_caption}']")
    end
  end

  context "edit form" do
    it "updates source when submitted", points: 5, hint: h("label_for_input button_type") do
      photo = create(:photo, source: "Boring old source", id: 42)

      visit "/photos"
      click_on "Show details"
      click_on "Edit"

      test_source = "Exciting new source at #{Time.now}"
      fill_in "Source", with: test_source
      click_on "Update Photo"

      photo_as_revised = Photo.find(42)

      expect(photo_as_revised.source).to eq(test_source)
    end
  end

  context "edit form" do
    it "updates caption when submitted", points: 5, hint: h("label_for_input button_type") do
      create(:photo, caption: "Boring old caption", id: 42)

      visit "/photos"
      click_on "Show details"
      click_on "Edit"

      test_caption = "Exciting new caption at #{Time.now}"
      fill_in "Caption", with: test_caption
      click_on "Update Photo"

      photo_as_revised = Photo.find(42)

      expect(photo_as_revised.caption).to eq(test_caption)
    end
  end

  context "edit form" do
    it "redirects to the details page", points: 3, hint: h("embed_vs_interpolate redirect_vs_render") do
      photo_to_edit = create(:photo)

      visit "/photos"
      click_on "Show details"
      click_on "Edit"
      click_on "Update Photo"

      expect(page).to have_current_path("/photos/#{photo_to_edit.id}")
    end
  end
end
