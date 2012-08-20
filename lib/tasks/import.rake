require 'csv'

namespace :import do
  desc "Import old locations" 
  task :locations => :environment do
    file = File.open(File.join(Rails.root, "data", "import", "locations.csv"), "r")
    csv = CSV.parse(file, :headers => true)
    csv.each do |line|
      location = Location.new(line.to_hash)
      location.slug = ""
      location.classification = "industry"
      location.save
    end
  end
end
