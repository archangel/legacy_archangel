require "rails_helper"

module Archangel
  RSpec.describe Navigation, type: :library do
    describe "#build" do
      subject { described_class }

      binding.pry
      allow(subject).to receive(:find_navigation).and_return(nil)

      it "should be younger than a 20 year old" do
        expect(subject.build).to eq nil
      end
    end


    # describe Buy do
    #   describe '.get_days' do
    #     it { expect(subject.class.get_days('Includes a 1-weeknight stay for up to 4 people')).to eq 1 }
    #   end
    # end

    # it "has integer values" do
    #   expect(Archangel.configuration.attachment_maximum_file_size).to(
    #     be_a_kind_of(Integer)
    #   )
    # end
    #
    # it "has string values" do
    #   expect(Archangel.configuration.application).to be_a_kind_of(String)
    # end
    #
    # it "has string values" do
    #   expect(Archangel.configuration.attachment_white_list).to(
    #     be_a_kind_of(Array)
    #   )
    # end
    #
    # describe "#missing_method" do
    #   it "returns value for key" do
    #     expect(Archangel.configuration.application).to eq "archangel"
    #   end
    #
    #   it "checks for availability of key" do
    #     expect(Archangel.configuration.application?).to be_truthy
    #   end
    #
    #   it "returns default (nil) value for key not found" do
    #     expect(Archangel.configuration.unavailable_key).to eq nil
    #   end
    #
    #   it "checks for availability of unavailable key" do
    #     expect(Archangel.configuration.unavailable_key?).to be_falsey
    #   end
    # end
  end
end
