require 'spec_helper'

describe Admin::LocationsController do

  describe 'massoperation' do

    it 'calls perform_massoperation on Location' do
      Location.should_receive(:perform_massoperation)
        .with('operation', 'ids')
      get :massoperation, do: 'operation', massoperation: 'ids'
    end
  end
end
