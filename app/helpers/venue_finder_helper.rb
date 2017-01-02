module VenueFinderHelper
  require 'csv'
  require 'time'

  def get_all_venues
    return open_file
  end

  def convert_date_time_to_number_time(time)
    t = time.strftime('%H%M')
    if t[0] == '0'
      n =  t[1..(t.length-1)]
      return n.to_i
    else
      return t.to_i
    end
  end
  def convert_simple_time_to_number_time(time)
    t =  time.delete(':')
    if t[0] == '0'
      n =  t[1..(t.length-1)]
      return n.to_i
    else
      return t.to_i
    end
  end

  def get_open_venues(all_venues, time)
    d = Time.at(Time.now)
    day = d.wday
    time = d.strftime("%H%M")
    puts '---------------------------------------000'
    puts time.to_i
    puts day
    puts convert_time_to_code(time.to_i, day)
    puts '---------------------------------------000'

    unless convert_time_to_code(time.to_i, day).nil?
      get_open_venue_for_codes(all_venues, convert_time_to_code(time.to_i, day))
    end
  end

  # def ready(time)
  #   time = convert_date_time_to_number_time(time)
  #   get_open_venues(get_all_venues, time)
  # end



private

  def convert_time_to_do_mon(time)
    puts 'In here'
    if time >= 1000 and time <= 1045
      return ['O1']

    elsif time > 1045 and time <= 1135
        return ['02']
    elsif time > 1135 and time <= 1225 # monday starts here
      return ['Z1']
    elsif time > 1025 and time <= 1315
      puts 'In here00000000000000000000'
      return ['Z2']
    elsif time > 1315 and time <= 1405
      return ['K1 P1']
    elsif time > 1405 and time <= 1455
      return ['K2 P2']
    elsif time > 1455 and time <= 1545
      return ['H1 P3']
    elsif time > 1545 and time <= 1635
      return ['H2 P4']
    elsif time > 1635 and time <= 1725
      return ['R3']
    elsif time > 1725 and time <= 1815
      return ['R4']
    else
      nil
    end
  end
# day can be 1=mon 2=tue 3=wed 4=thurs 5=fri
  def convert_time_to_code(time, day)
    if time >= 800 and time <= 845
      if day == 1
        return convert_time_to_do_mon(time)
      end
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
      if day == 1
        return convert_time_to_do_mon(time)
      end
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
      if day == 1
        return convert_time_to_do_mon(time)
      end
      if day == 2 # tues
        return ['N2']
      end
      if day == 3 # wed
        return ['M4 P12']
      end
      if day == 4 # thurs
        return ['R1 p21']
      end
      if day == 5 # fri
        return ['Q3']
      end
    elsif time > 1025 and time <= 1115
      if day == 1
        return convert_time_to_do_mon(time)
      end
      if day == 2 # tues
        return ['M1']
      end
      if day == 3 # wed
        return ['T1 P13']
      end
      if day == 4 # thurs
        return ['R2 P22']
      end
      if day == 5 # fri
        return ['Q4']
      end
    elsif time > 1115 and time <= 1205
      if day == 1
        return convert_time_to_do_mon(time)
      end
      if day == 2 # tues
        return ['M2']
      end
      if day == 3 # wed
        return ['T2 P14']
      end
      if day == 4 # thurs
        return ['T3 P23']
      end
      if day == 5 # fri
        return ['Q4']
      end
    elsif time > 1205 and time <= 1255
      if day == 1
        return convert_time_to_do_mon(time)
      end
      if day == 2 # tues
        return ['Q1']
      end
      if day == 3 # wed
        return ['S1 P15']
      end
      if day == 4 # thurs
        return ['T4 P24']
      end
      if day == 5 # fri
        return []
      end
    elsif time > 1255 and time <= 1345
      if day == 1
        return convert_time_to_do_mon(time)
      end
      if day == 2 # tues
        return ['Q2']
      end
      if day == 3 # wed
        return ['S2 P16']
      end
      if day == 4 # thurs
        return ['H3 P25']
      end
      if day == 5 # fri
        return []
      end
    elsif time > 1345 and time <= 1435
      if day == 1
        return convert_time_to_do_mon(time)
      end
      if day == 2 # tues
        return ['I1 P6']
      end
      if day == 3 # wed
        return ['J1 P17']
      end
      if day == 4 # thurs
        return ['H4 P26']
      end
      if day == 5 # fri
        return ['J3 P29']
      end
    elsif time > 1435 and time <= 1525
      if day == 1
       return convert_time_to_do_mon(time)
      end
      if day == 2 # tues
        return ['L2 P7']
      end
      if day == 3 # wed
        return ['J2 P18']
      end
      if day == 4 # thurs
        return ['I3 P27']
      end
      if day == 5 # fri
        return ['J4 P30']
      end
    elsif time > 1525 and time <= 1615
      if day == 1
       return convert_time_to_do_mon(time)
      end
      if day == 2 # tues
        return ['K3 P8']
      end
      if day == 3 # wed
        return ['C1 P19']
      end
      if day == 4 # thurs
        return ['I3 P28']
      end
      if day == 5 # fri
        return ['C3 P31']
      end
    elsif time > 1615 and time <= 1705
      if day == 1
        return convert_time_to_do_mon(time)
      end
      if day == 2 # tues
        return ['K4 P9']
      end
      if day == 3 # wed
        return ['C2 P20']
      end
      if day == 4 # thurs
        return ['O3']
      end
      if day == 5 # fri
        return ['C4 P32']
      end
    elsif time > 1705 and time <= 1755
      if day == 1
       return convert_time_to_do_mon(time)
      end
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
      if day == 1
        return convert_time_to_do_mon(time)
      end
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
      nil
    end
  end


  def get_venue_for_code(venue_array_of_hashes, time_code)
    # arr = Array.new # todo not required
    arr_no = []
    puts 'yyyyyyyy'
    venue_array_of_hashes.each do |h|
      v_hash = h    #this a single hash in the array
      v_hash.values.compact.each do |v|

        f = v.strip # remove white space f is the time slot values
        puts '======================================='
        puts '======================================='
        if time_code[2] == ' ' #check if it has more that one element
          b = time_code.split(' ') # split time code into array
          b.each do |j| #j is each time
            if j == f
              arr_no.push(h)
            end
          end
        else
          puts 'yyoyoyoyoyo'
          puts '---------------------'
          puts f
          puts time_code
          puts f == time_code
          puts '---------------------'

          if f == time_code
            puts 'yyoyoyoyoyo100000000'
            arr_no.push(h)
          end
        end
      end
    end
    return  arr_no
  end

  def subtract(arr_all, arr_happening)
    if arr_happening.count > 0
      return (arr_all - arr_happening)
    else
      []
    end
  end

  def get_open_venue_for_codes(venue_hashes, times)
    puts 'hhhhhhhhhhhhhhhhhhhhh'
    arr_not_in_use_venue = []
    in_use = get_venue_for_code(venue_hashes, times[0])

    puts '-----------hghghgh-----------------------'
    puts times

    puts in_use
    puts '----------------------------------'

    b = subtract(venue_hashes, in_use)
    arr_not_in_use_venue.push(b)
    u = arr_not_in_use_venue.uniq!  #can retrn nil if the list is already unique
    if !u.nil?
      return u
    else
      return arr_not_in_use_venue
    end

  end

  def open_file
    data = CSV.read("/home/divine/RubymineProjects/store/lib/tasks/Extraction.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})
    return venue_hashes = data.map { |d| d.to_hash }
  end
end
