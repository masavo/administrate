require "spec_helper"
require "administrate/field/boolean"
require "support/field_matchers"

describe Administrate::Field::Boolean do
  include FieldMatchers

  describe "#to_partial_path" do
    it "returns a partial based on the page being rendered" do
      page = :show
      boolean = double
      field = Administrate::Field::Boolean.new(:price, boolean, page)

      path = field.to_partial_path

      expect(path).to eq("/fields/boolean/#{page}")
    end
  end

  it { should_permit_param(:foo, for_attribute: :foo) }

  describe "#to_s" do
    it "prints true or false" do
      t = Administrate::Field::Boolean.new(:quantity, true, :show)
      f = Administrate::Field::Boolean.new(:quantity, false, :show)

      expect(t.to_s).to eq("true")
      expect(f.to_s).to eq("false")
    end

    context "when data is nil" do
      it "returns a dash" do
        boolean = Administrate::Field::Boolean.new(:boolean, nil, :page)

        expect(boolean.to_s).to eq("-")
      end
    end
  end


  describe "true/false option" do
    context "when defined true: and false: options" do
      subject do
        Administrate::Field::Boolean
          .with_options(true: "o", false: "x")
          .new(:quantity, boolean, :show)
      end

      context "when true" do
        let(:boolean) { true }
        it { expect(subject.to_s).to eq("o") }
      end

      context "when false" do
        let(:boolean) { false }
        it { expect(subject.to_s).to eq("x") }
      end
    end


    context "when not defined true: and false: options" do
      subject do
        Administrate::Field::Boolean
          .with_options([{true: "o"}, {false: "x"}].sample)
          .new(:quantity, boolean, :show)
      end

      context "when true" do
        let(:boolean) { true }
        it { expect(subject.to_s).to eq("true") }
      end

      context "when false" do
        let(:boolean) { false }
        it { expect(subject.to_s).to eq("false") }
      end
    end
  end
end
