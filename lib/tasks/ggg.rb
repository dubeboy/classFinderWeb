require 'csv'
CSV.foreach('/home/divine/RubymineProjects/store/lib/tasks/tab.csv') do |row|
  temp = []
  if !row[0].empty?
    v = row[0].split(',')
    venue_name = (row[(row.size() -1)])
    if(!venue_name.nil?)
      temp.push(venue_name.gsub(/[\n]/, ' '))
      v.each do |e|
        temp.push(e.gsub(/[\n]/, ' '))
      end
      puts temp.to_s + ','
    end
  end
end

