require 'otr-activerecord'
require 'active_record/fixtures'
ActiveRecord::Base.logger = nil

if ENV["TEST_DATABASE_URL"].to_s != ""
  OTR::ActiveRecord.configure_from_url!(ENV["TEST_DATABASE_URL"])
  OTR::ActiveRecord.establish_connection!
else
  ENV["RACK_ENV"] = "test"
  OTR::ActiveRecord.configure_from_file!(File.expand_path("../database.yml", __FILE__))
  ActiveRecord::Base.establish_connection :main
  ActiveRecord::Base.establish_connection :main_replica
end

Dir.glob('./test/support/active_record/*.rb').each { |file| require file }
