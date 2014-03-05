require 'spec_helper'

describe LocationsController do
  describe 'GET show' do
    let(:location) { double(:location) }

    before do
      Location.should_receive(:find_by!)
        .with(slug: 'foo')
        .and_return(location)
      location.should_receive(:nearbys_for_map)
    end

    it 'finds location' do
      get :show, id: 'foo'
    end
  end
end
