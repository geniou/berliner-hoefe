require 'spec_helper'

describe LocationsController do
  describe 'GET show' do
    let(:location) { double(:location) }

    before do
      Location.should_receive(:find)
        .with('123')
        .and_return(location)
      location.should_receive(:nearbys_for_map)
    end

    it 'finds location' do
      get :show, id: '123'
    end
  end
end
