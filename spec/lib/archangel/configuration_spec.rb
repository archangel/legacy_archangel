require "rails_helper"

module Archangel
  RSpec.describe Configuration, type: :library do
    describe "#initialize" do
      it "initializes with a hash" do
        config = Archangel::Configuration.new(
          something: "nothing",
          yesno: {
            yes: "no"
          }
        )

        expect(config.something).to be_a_kind_of(String)
        expect(config.yesno).to be_a_kind_of(Archangel::Configuration)
      end

      it "initializes without a hash" do
        config = Archangel::Configuration.new

        expect(config).to be_a_kind_of(Archangel::Configuration)
      end
    end

    describe "#add" do
      let(:config) do
        hash = { something: "nothing", yesno: { yes: "no" } }

        Archangel::Configuration.new(hash)
      end

      it "adds an integer value" do
        config.add(:abc, 123)

        expect(config.abc).to be_a_kind_of(Integer)
      end

      it "adds a string value" do
        config.add(:abc, "123")

        expect(config.abc).to be_a_kind_of(String)
      end

      it "adds a hash value" do
        hash = { foo: "bar", sponge_bob: "square pants" }

        config.add(:abc, hash)

        expect(config.abc).to be_a_kind_of(Archangel::Configuration)
      end
    end

    describe "#missing_method" do
      let(:config) { Archangel::Configuration.new }

      it "returns default (nil) value for key not found" do
        expect(config.unavailable_key).to eq nil
      end

      it "checks for availability of unavailable key" do
        expect(config.bar?).to be_falsey
      end

      it "checks for availability of nil key" do
        config.add(:foo, "bar")

        expect(config.foo?).to be_truthy
      end
    end
  end
end
