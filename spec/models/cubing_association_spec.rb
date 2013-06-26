require_relative "../../app/models/cubing_association"
require "ostruct"

describe CubingAssociation do
  describe "attributes" do
    it "defaults to nil for name" do
      expect(CubingAssociation.new.name).to be_nil
    end

    it "has a name" do
      cubing_association = CubingAssociation.new name: "World Cube Association"
      expect(cubing_association.name).to eq("World Cube Association")
    end

    it "has initially no competitions" do
      expect(subject.competitions).to eq([])
    end
  end

  describe "#new_competition" do
    let(:competition) { OpenStruct.new }

    before do
      subject.competition_builder = lambda { |attributes| competition }
    end

    it "returns a new competition object" do
      expect(subject.new_competition).to eq(competition)
    end

    it "returns a new competition object which knows about its cubing association" do
      expect(subject.new_competition.cubing_association).to eq(subject)
    end

    it "passes arguments to competition_builder" do
      competition_builder = stub(:competition_builder)
      competition_builder.should_receive(:call).with(location: "Tiergarten").and_return(competition)
      subject.competition_builder = competition_builder

      subject.new_competition(location: "Tiergarten")
    end
  end

  describe "#add_competition" do
    it "adds a competition" do
      competition = stub(:competition)
      subject.add_competition competition
      expect(subject.competitions).to eq [competition]
    end
  end

  describe "#get_competition" do
    let(:competition_1) { stub(:competition, to_param: "go-2013") }
    let(:competition_2) { stub(:competition, to_param: "he-2011") }
    let(:competition_3) { stub(:competition, to_param: "it-2014") }
    before { subject.add_competition(competition_1); subject.add_competition(competition_2); subject.add_competition(competition_3) }

    context "when competition can't be found" do
      it "raises a CompetitionNotFound exception" do
        expect {
          subject.get_competition("it-2015")
        }.to raise_error(CompetitionNotFound)
      end
    end

    context "when competition can be found" do
      it "returns the competition" do
        expect(subject.get_competition("he-2011")).to eq(competition_2)
      end
    end
  end
end
