# -*- coding: utf-8 -*-
task :ask => :environment do
  users = User.all
  twilio = TwilioClient.new

  users.each do |u|
    unless u.mute
      begin
        twilio.send_wednesday_sms(u)
        puts "msg sent to: " + u.full_name
      rescue
        puts "FAILED sending to: " + u.full_name
      end
    end
  end
end

task :msg_hong => :environment do
  TwilioClient.new.send_sms("+12155880230","A TALE OF TWO CITIES")
  puts "message sent to hong"
end

task :msg_hunter => :environment do
  TwilioClient.new.send_sms("+16502913866","A TALE OF TWO CITIES")
  puts "message sent to hunter"
end
