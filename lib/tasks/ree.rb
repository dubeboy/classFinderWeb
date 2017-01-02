require 'csv'
require 'time'
class Ree
  @@data = CSV.read("Extraction.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})
  @@venue_hashes = data.map { |d| d.to_hash }

# day can be 1=mon 2=tue 3=wed 4=thurs 5=fri
  def self.convert_time_to_code(time, day)
    if time > 800 and time <= 845
      if day == 2
        return ['G1']
      end
      if day == 3
        return ['G2']
      end
      if day == 4
        return ['L1']
      end
      if day == 5
        return ['Z3']
      end

    elsif time > 845 and time <= 935
      if day == 2
        return ['N1']
      end
      if day == 3
        return ['M3']
      end
      if day == 4
        return ['L2']
      end
      if day == 5
        return ['Z4']
      end
    elsif time > 935 and time <= 1025 # monday starts here
      if day == 2 # tues
        return ['N2']
      end
      if day == 3 # wed
        return ['M4', 'P12']
      end
      if day == 4 # thurs
        return ['R1', 'p21']
      end
      if day == 5 # fri
        return ['Q3']
      end
    elsif time > 1025 and time <= 1115
      if day == 2 # tues
        return ['M1']
      end
      if day == 3 # wed
        return ['T1', 'P13']
      end
      if day == 4 # thurs
        return ['R2', 'P22']
      end
      if day == 5 # fri
        return ['Q4']
      end
    elsif time > 1115 and time <= 1205
      if day == 2 # tues
        return ['M2']
      end
      if day == 3 # wed
        return ['T2', 'P14']
      end
      if day == 4 # thurs
        return ['T3', 'P23']
      end
      if day == 5 # fri
        return ['Q4']
      end
    elsif time > 1205 and time <= 1255

      if day == 2 # tues
        return ['Q1']
      end
      if day == 3 # wed
        return ['S1', 'P15']
      end
      if day == 4 # thurs
        return ['T4', 'P24']
      end
      if day == 5 # fri
        return []
      end
    elsif time > 1255 and time <= 1345
      if day == 2 # tues
        return ['Q2']
      end
      if day == 3 # wed
        return ['S2', 'P16']
      end
      if day == 4 # thurs
        return ['H3', 'P25']
      end
      if day == 5 # fri
        return []
      end
    elsif time > 1345 and time <= 1435

      if day == 2 # tues
        return ['I1', 'P6']
      end
      if day == 3 # wed
        return ['J1', 'P17']
      end
      if day == 4 # thurs
        return ['H4', 'P26']
      end
      if day == 5 # fri
        return ['J3','P29']
      end
    elsif time > 1435 and time <= 1525
      if day == 2 # tues
        return ['L2', 'P7']
      end
      if day == 3 # wed
        return ['J2', 'P18']
      end
      if day == 4 # thurs
        return ['I3', 'P27']
      end
      if day == 5 # fri
        return ['J4','P30']
      end
    elsif time > 1525 and time <= 1615
      if day == 2 # tues
        return ['K3', 'P8']
      end
      if day == 3 # wed
        return ['C1', 'P19']
      end
      if day == 4 # thurs
        return ['I3', 'P28']
      end
      if day == 5 # fri
        return ['C3','P31']
      end
    elsif time > 1615 and time <= 1705
      if day == 2 # tues
        return ['K4', 'P9']
      end
      if day == 3 # wed
        return ['C2', 'P20']
      end
      if day == 4 # thurs
        return ['O3']
      end
      if day == 5 # fri
        return ['C4','P32']
      end
    elsif time > 1705 and time <= 1755
      if day == 2 # tues
        return ['L3']
      end
      if day == 3 # wed
        return ['N3']
      end
      if day == 4 # thurs
        return ['G3']
      end
      if day == 5 # fri
        return ['S3']
      end
    elsif time > 1755 and time <= 1845  # else its part time man
      if day == 2 # tues
        return ['L4']
      end
      if day == 3 # wed
        return ['N4']
      end
      if day == 4 # thurs
        return ['G4']
      end
      if day == 5 # fri
        return ['S4']
      end
    else
      []
    end
  end

  def self.get_venue_for_code(venue_hashes, time_code)
    # arr = Array.new # todo not required
    arr_no = Array.new
    venue_hashes.each do |h|
      v_hash = h
      puts v_hash
      v_hash.select do |k, v|
        if v == time_code
          # arr.push(v_hash)
        else
          arr_no.push(v_hash)
        end
      end
    end
    {:not_in_use => arr_no}

  end

  def self.get_open_venue_for_codes(venue_hashes, times)
    arr_not_in_use_venue = Array.new
    times.each { |t|
      h  =  get_venue_for_code(venue_hashes, t)
      arr_not_in_use_venue.push(h[:not_in_use])
    }
    arr_not_in_use_venue
  end

  def self.convert_time_to_number(time)

  end
end