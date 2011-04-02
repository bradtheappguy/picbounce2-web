require 'rubygems'
require 'httpclient'


def upload_sample_photo_to_facebook_and_twitter_via_localhost
  resp = HTTPClient.post 'http://localhost:3000/photos', {
    :twitter_oauth_token => '212380406-keVeLOh2nEXd5iJPlo22n4Vtl0YyJnTmtjU06B7Y',
    :twitter_oauth_secret => 'Gl40F6xLtvhBboKdPAN5FtRYOKn3p50x5JZsSEXyIis',
    :facebook_access_token => '125208417509976|e80f4fed1bec3e9bd23ae270-100000038722716|ItThmgr8i0_2PZXDNKASuFAyuVE',
    :device_id => 'b57f70eb7a279c9671323f74867cfa4afbdd488b',
    :system_name => 'iPhoneOS',
    :system_version => '4.0.1',
    :system_model => 'iPhone',
    :photo => File.new('test/fixtures/photo_sample.jpg') }
  puts resp.body.dump
end

start_time = Time.now
puts "Beginning Benchmarks at #{start_time}"
puts ""

total_seconds = 0
count = 1
(1..count).each do |i|
  t1 = Time.now
  print "Uploading (#{i} of #{count}) "
  upload_sample_photo_to_facebook_and_twitter_via_localhost
  total_seconds = total_seconds + (Time.now - t1)
  print "Done in #{Time.now - t1} seconds"
end

puts ""
puts "Bechmark Done. #{total_seconds / count} seconds average"

