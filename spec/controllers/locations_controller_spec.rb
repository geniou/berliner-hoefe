require 'spec_helper'

describe LocationsController, type: :controller do
  describe 'GET show' do
    let(:location) { double(:location) }

    before do
      expect(Location).to receive(:find_by!)
        .with(slug: 'foo')
        .and_return(location)
      expect(location).to receive(:nearbys_for_map)
    end

    it 'finds location' do
      get :show, id: 'foo'
    end
  end
end
