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
      location.name.should eq 'Foo Location'
      location.description.should eq 'Foo Description'
      location.annotations.should eq 'Foo Annotations'
      location.latitude.should eq 52.000
      location.longitude.should eq 13.000
      location.published_on.should_not be_nil
      location.on_map.should be_true
    end
  end

  def see_location
    within('#content') do
      page.should have_selector('h1', text: 'Foo Location')
      page.should have_selector('.description', text: 'Foo Description')
      page.should have_selector('.annotations', text: 'Foo Annotations')
      page.should have_selector('.images a[title="Foo Image"] img[alt="Foo Image"]')
    end
  end
end
