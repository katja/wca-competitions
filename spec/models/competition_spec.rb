require_relative "../../app/models/competition"

describe Competition do
  it "belongs to a cubing association" do
    ca = stub(:cubing_association)
    subject.cubing_association = ca
    expect(subject.cubing_association).to eq(ca)
  end

  it "has a name" do
    c = Competition.new(name: "Karlsruher Open 2020")
    expect(c.name).to eq("Karlsruher Open 2020")
  end

  it "has a date" do
    c = Competition.new(date: Date.new(2020, 5, 20))
    expect(c.date).to eq(Date.new(2020, 5, 20))
  end

  it "has a location" do
    c = Competition.new(location: "Karlsruhe")
    expect(c.location).to eq("Karlsruhe")
  end

  describe "#publish!" do
    it "adds itself to the cubing association" do
      ca = stub(:cubing_association)
      subject.cubing_association = ca
      ca.should_receive(:add_competition).with(subject)
      subject.publish!
    end
  end

  describe "#to_param" do
    subject { Competition.new(name: name).to_param }

    context "given no name" do
      let(:name) { nil }

      it { should eq nil }
    end

    context "given 'Hessen Open 2013' as a name" do
      let(:name) { "Hessen Open 2013" }

      it { should eq "hessen-open-2013" }
    end
  end
end
