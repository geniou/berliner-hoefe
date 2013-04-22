require 'spec_helper'

describe Location do

  describe 'should_generate_new_friendly_id?' do
    context 'slug is empty' do
      before { subject.stub( slug: '' ) }
      its(:should_generate_new_friendly_id?) { should be_true }
    end

    context 'slug is not empty' do
      before { subject.stub( slug: 'not empty' ) }
      its(:should_generate_new_friendly_id?) { should be_false }
    end
  end
end
