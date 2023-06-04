# Tutorial Code:

require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'date'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

## My code:

def clean_phone(phone)
  phone = phone.delete('().-').delete(' ')
  if phone.length == 10 
    phone
  elsif phone[0] == 1 && phone.length == 11
    phone[1..-1]
  else 
    nil
  end
end

def get_converted_dates(data, symbol)
  dates = Array.new(0)

  data.each do |row|
  date = DateTime.strptime(row[symbol], "%m/%d/%y %H:%M")
  dates << date
  end

  dates
end

def get_popularity(input_array)
  popularity_array = input_array.reduce(Hash.new(0)) do |thing, procs|
    thing[procs] += 1
    thing
  end
  popularity_array
end
# My code ends

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

=begin 
contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id,form_letter)
end
=end

# My code:

# Clean Phone: 
=begin 
contents.each do |row|
  name = row[:first_name]
  number = clean_phone(row[:homephone])

  puts "#{name} and #{number}"
end
=end
# Getting popular hours:

dates = get_converted_dates(contents, :regdate)

hours = dates.map do |date|
  date.hour
end

popular_hours = get_popularity(hours)

p popular_hours.sort_by(&:last).to_h

# Getting popular days of the week:

days_of_the_week = dates.map do |date|
  date.wday
end

popular_days = get_popularity(days_of_the_week)

p popular_days.sort_by(&:last).to_h