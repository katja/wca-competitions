require "active_model"

class Competition
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :cubing_association, :name, :date, :location

  def initialize(attributes = {})
    attributes.each do |key, value|
      send("#{key}=", value)
    end
  end

  def publish!
    cubing_association.add_competition self
  end

  def persisted?
    false
  end

  def to_param
    name.downcase.gsub(" ", "-") if name
  end
end
