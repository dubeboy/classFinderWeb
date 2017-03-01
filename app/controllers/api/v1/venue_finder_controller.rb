class Api::V1::VenueFinderController < ApplicationController
   def index
	    d = Time.at(Time.now)
	    day = d.wday
	    time = params['time'].nil? ? d.strftime("%H%M") : params['time'].delete!(":")
	    puts '-------------------------dewewe'
	    puts time
	    puts '------------------------wewew-'
	    if day == 6 or day == 0
	      @open_venues = []
	    elsif time.to_i < 800 or time.to_i > 1845
	         @open_venues = []
	    else
	      @open_venues = get_free(time.to_i, day)
	    end
	    respond_to do |f|
	         f.json
	    end
   end
end
