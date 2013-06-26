class CompetitionsController < ApplicationController

  def index
    @competitions = wca.competitions
  end

  def show
    @competition = wca.get_competition params[:id]
  end

  def new
    @competition = wca.new_competition
  end

  def create
    competition = wca.new_competition params[:competition]
    competition.publish!
    redirect_to competitions_path
  end

  private
  def wca
    WCA
  end
end
