require 'time'
class VenueFinderController < ApplicationController
  def index
    d = Time.at(Time.now)
    #day = d.wday
     day = 3
    #  day = 6
    time = params['time'].nil? ? d.strftime("%H%M") : params['time'].delete!(":")
    if day == 6 or day == 0
      @open_venues = []
    elsif time.to_i < 800 or time.to_i > 1845
         @open_venues = []
    else
      @open_venues = get_free(time.to_i, day)
    end
  end
  end
