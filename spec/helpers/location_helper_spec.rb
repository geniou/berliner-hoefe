require 'spec_helper'

describe LocationHelper do

  describe 'location_path' do
    subject { helper.location_path(location) }
    let(:location) { double('location', slug: 'the-slug') }

    it 'returns location path with slug' do
      subject.should == '/the-slug'
    end
  end
end
