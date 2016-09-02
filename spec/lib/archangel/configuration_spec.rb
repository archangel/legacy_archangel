require "rails_helper"

module Archangel
  RSpec.describe Configuration, type: :library do
    describe "#initialize" do
      it "initializes with a hash" do
        hash = { something: "nothing", yesno: { yes: "no" } }
        config = Archangel::Configuration.new(hash)

        expect(config.something).to be_a_kind_of(String)
        expect(config.yesno).to be_a_kind_of(Archangel::Configuration)
      end
    end

    describe "#add" do
      it "adds an integer value" do
        Archangel.configuration.add(:abc, 123)

        expect(Archangel.configuration.abc).to be_a_kind_of(Integer)
      end

      it "adds a string value" do
        Archangel.configuration.add(:abc, "123")

        expect(Archangel.configuration.abc).to be_a_kind_of(String)
      end

      it "adds a hash value" do
        hash = { foo: "bar", sponge_bob: "square pants" }

        Archangel.configuration.add(:abc, hash)

        expect(Archangel.configuration.abc).to be_a_kind_of(Archangel::Configuration)
      end
    end

    describe "#missing_method" do
      it "returns default (nil) value for key not found" do
        expect(Archangel.configuration.unavailable_key).to eq nil
      end

      it "checks for availability of unavailable key" do
        expect(Archangel.configuration.bar?).to be_falsey
      end

      it "checks for availability of nil key" do
        Archangel.configuration.add(:foo, "bar")

        expect(Archangel.configuration.foo?).to be_truthy
      end
    end
  end
end
