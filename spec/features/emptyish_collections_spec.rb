require 'spec_helper'

feature 'Emptyish Collections:' do
  let(:inner_collection) { create(:course_collection, title: "Inner Collection") }
  let(:outer_collection) { create(:course_collection, members: [inner_collection], title: "Outer Collection") }

  let(:an_image) { create(:image, displays: ['trove']) }
  let(:inner_collection2) { create(:course_collection, members: [an_image], title: "Inner Collection 2") }
  let(:outer_collection2) { create(:course_collection, members: [inner_collection2], title: "Outer Collection 2") }

  context 'a non-admin user' do
    let(:user) { create(:user) }
    before { sign_in user }

    scenario 'browses a collection containing only an empty collection' do
      visit course_collection_path(outer_collection)
      expect(page).to have_content(outer_collection.title)
      expect(page).to have_content(inner_collection.title)
      expect(page).to_not have_link("View as slideshow")
    end

    scenario 'browses a collection containing a non-empty collection' do
      visit course_collection_path(outer_collection2)
      expect(page).to have_content(outer_collection2.title)
      expect(page).to have_content(inner_collection2.title)
      expect(page).to have_link("View as slideshow")
    end
  end

end
