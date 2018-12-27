require "spec_helper"

describe "#double" do
  let(:fake_object) { double("fake_object", fake_function: "fake function") }

  it "is mock object with the RSpec::Mocks::Double class " do
    expect(fake_object.class).to eq(RSpec::Mocks::Double)
  end

  it "can have stubbed functions" do
    expect(fake_object.fake_function).to eq("fake function")
  end

  it "acts a lot like a struct, but require less code" do
    struct = Struct.new(:fake_function).new("fake function")
    expect(fake_object.fake_function).to eq(struct.fake_function)
  end
end

describe "#allow" do
  let(:object) do
    klass = Class.new do
      def no_arguments()
        raise "not implemented"
      end

      def multiple_arguments(arg1, arg2)
        raise "not implemented"
      end
    end

    klass.new
  end

  it "can stub a function with no arguments" do
    allow(object).to receive(:no_arguments) { "no arguments" }
    expect(object.no_arguments).to eq("no arguments")
  end

  it "can stub a function with multiple arguments" do
    allow(object).to receive(:multiple_arguments).with("fake arg 1", "fake arg 2") do
      "multiple arguments"
    end
    expect(object.multiple_arguments("fake arg 1", "fake arg 2"))
      .to eq("multiple arguments")
  end
end