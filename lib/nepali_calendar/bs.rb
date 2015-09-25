module NepaliCalendar
  BS = {}
  File.open(File.dirname(__FILE__) + '/bs.txt') do |f|
    f.each_line do |line|
      key, value = line.split(' => ')
      BS[key.to_i] = value[1..-3].split(', ').map(&:to_i)
    end
  end
end
