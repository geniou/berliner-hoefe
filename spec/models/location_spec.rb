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

  describe 'perform_massoperation' do
    let(:now){ double }
    let(:ids){ double }

    before { Time.stub( now: now ) }

    context 'unknown comand' do
      it 'do not calls update_all' do
        Location.should_not_receive(:update_all)
        described_class.perform_massoperation('unknown_operation', ids)
      end
    end

    context 'publish' do
      it 'sets publish time to current time' do
        Location.should_receive(:update_all)
          .with({ published_on: now }, [ "id IN (?)", ids ])
        described_class.perform_massoperation('publish', ids)
      end
    end

    context 'unpublish' do
      it 'unsets publish time' do
        Location.should_receive(:update_all)
          .with({ published_on: nil }, [ "id IN (?)", ids ])
        described_class.perform_massoperation('unpublish', ids)
      end
    end

    context 'show_detail' do
      it 'sets publish time and show detail to true' do
        Location.should_receive(:update_all)
          .with({ published_on: now, show_detail: true }, [ "id IN (?)", ids ])
        described_class.perform_massoperation('show_detail', ids)
      end
    end

    context 'hide_detail' do
      it 'sets show detail to false' do
        Location.should_receive(:update_all)
          .with({ show_detail: false }, [ "id IN (?)", ids ])
        described_class.perform_massoperation('hide_detail', ids)
      end
    end

    context 'show_on_map' do
      it 'sets publish time and show on map to true' do
        Location.should_receive(:update_all)
          .with({ published_on: now, on_map: true }, [ "id IN (?)", ids ])
        described_class.perform_massoperation('show_on_map', ids)
      end
    end

    context 'hide_on_map' do
      it 'sets show on map to false' do
        Location.should_receive(:update_all)
          .with({ on_map: false }, [ "id IN (?)", ids ])
        described_class.perform_massoperation('hide_on_map', ids)
      end
    end
  end
end
