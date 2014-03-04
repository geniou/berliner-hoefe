require 'spec_helper'

describe OgmHelper do
  describe 'ogm_image' do
    subject { Capybara.string(helper.ogm_image(image_url)) }
    let(:request_url) { double('request_url') }
    let(:image_url) { double('image_url') }

    before do
      URI.should_receive(:join)
        .with(request_url, image_url)
        .and_return('absolute_image_url')
      helper.stub_chain(:request, url: request_url)
    end

    it 'returns meta tag with property attribute' do
      subject.should have_selector('meta[property="og:image"]', visible: false)
    end

    it 'returns absolute path of image' do
      subject.should have_selector('meta[content="absolute_image_url"]', visible: false)
    end
  end
end
