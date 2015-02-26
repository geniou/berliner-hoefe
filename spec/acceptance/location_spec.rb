require 'spec_helper'
include ActionDispatch::TestProcess

feature 'Location' do
  scenario 'Create location' do
    go_to_admin_page
    create_new_location
    new_location_exists
  end

  scenario 'View location' do
    go_to_location_page
    see_location
  end

  let(:location) do
    Location.create(
      name: 'Foo Location',
      description: 'Foo Description',
      annotations: 'Foo Annotations',
      published_on: Time.now,
      slug: 'foo',
      header_image: Image::Header.new,
      slideshow_images: [slideshow_image]
    )
  end
  let(:slideshow_image) do
    Image::Slideshow.create.tap do |image|
      image.update_attributes(
        image: fixture_file_upload(Rails.root + 'spec/fixtures/images/example.jpg', 'image/jpg'),
        title: 'Foo Image'
      )
    end
  end

  def go_to_admin_page
    visit admin_root_path
  end

  def go_to_location_page
    visit location.url
  end

  def create_new_location
    click_link 'New Location'
    fill_in 'Name', with: 'Foo Location'
    fill_in 'Description', with: 'Foo Description'
    fill_in 'Annotations', with: 'Foo Annotations'
    fill_in 'URL', with: 'foo'
    find(:xpath, '//input[@id="location_latitude"]').set '52.000'
    find(:xpath, '//input[@id="location_longitude"]').set '13.000'
    check 'On map'
    check 'Published'
    click_button 'Create location'
  end

  def new_location_exists
    Location.find_by(slug: 'foo').tap do |location|
      expect(location.name).to eq 'Foo Location'
      expect(location.description).to eq 'Foo Description'
      expect(location.annotations).to eq 'Foo Annotations'
      expect(location.latitude).to eq 52.000
      expect(location.longitude).to eq 13.000
      expect(location.published_on).not_to be_nil
      expect(location.on_map).to be_truthy
    end
  end

  def see_location
    within('#content') do
      expect(page).to have_selector('h1', text: 'Foo Location')
      expect(page).to have_selector('.description', text: 'Foo Description')
      expect(page).to have_selector('.annotations', text: 'Foo Annotations')
      expect(page).to have_selector('.images a[title="Foo Image"] img[alt="Foo Image"]')
    end
  end
end
