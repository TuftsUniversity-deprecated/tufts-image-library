require 'spec_helper'

describe CatalogHelper do
  let(:image) { TuftsImage.create(pid: 'tufts:777', title: 'foo', displays: ['trove']) }

  describe "#featured_records" do
    it "shouldn't crash with missing or malformed pids" do
      allow(FeatureDataSettings).to receive(:[]).and_return([image.pid, 'malformed::1', 'missing:1'])
      expect(featured_records).to eq [image]
    end
  end
end
