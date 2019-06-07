require 'date'

text = File.open('input.txt').read
text.gsub!(/\r\n?/, "\n")

actions = []

# Separating action per line
text.each_line do |line|
  # Parsing line to take each variable
  parsed_line = line.match(/\[(\d+)-(\d+)-(\d+)\s(\d+):(\d+)\]\s+(.+)/)

  date = DateTime.new(parsed_line[1].to_i, parsed_line[2].to_i, parsed_line[3].to_i,
                      parsed_line[4].to_i, parsed_line[5].to_i)

  actions << {
    date: date,
    action: parsed_line[6]
  }
end

actions.sort! { |a, b| a[:date] <=> b[:date] }

actual_guard = ''
guard_count = 0
shifts_by_guard = {}
last_minute_stamp = 0
time_slept_by_guard = {}
guard_sleep_schedule = {}

actions.each do |action|
  if action[:action].start_with?("Guard")
    guard_number = action[:action].match(/#(\d+)/)[1]
    if shifts_by_guard[guard_number].nil?
      guard_count += 1
      shifts_by_guard[guard_number] = {}
      time_slept_by_guard[guard_number] = 0
      guard_sleep_schedule[guard_number] = {}
    end
    actual_guard = guard_number
  elsif action[:action].start_with?("falls")
    last_minute_stamp = action[:date].minute
  elsif action[:action].start_with?("wakes")
    new_slept = action[:date].minute - last_minute_stamp
    time_slept_by_guard[actual_guard] += new_slept
    (last_minute_stamp..(action[:date].minute)).each do |index|
      if guard_sleep_schedule[actual_guard][index].nil?
        guard_sleep_schedule[actual_guard][index] = 0
      end
      guard_sleep_schedule[actual_guard][index] += 1
    end
  end

  day = action[:date].strftime("%Y%m%d")

  if shifts_by_guard[actual_guard][day].nil?
    shifts_by_guard[actual_guard][day] = []
  end

  shifts_by_guard[actual_guard][day] << action

  last_action = action[:action]
end

guard_sleep_schedule.reject { |k, v| v.empty? }

anwser_guard = ''
minute_slept = 0
max_slept = 0

guard_sleep_schedule.each do |guard, minutes|
  minutes.each do |minute, time|
    if time > max_slept
      minute_slept = minute
      anwser_guard = guard
      max_slept = time
    end
  end
end

puts anwser_guard, minute_slept
