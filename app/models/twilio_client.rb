# -*- coding: utf-8 -*-
class TwilioClient
  def initialize
    @client ||= Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"]
  end

  def send_sms(to, body, save = true)
    sms = { from: "+12156134878", to: to, body: body }
    @client.account.messages.create(sms)
    to_user = User.find_by_phone_number(to)
    sms[:to_user_id] = to_user.id if to_user
    sms[:body] = "FFC bot message." if body.length > 400
    if save
      Sms.create(sms)
    end
  end

  def respond_to_yes(to)
    # promo_str = "Btw, if you know anyone else who’d dig Free At Noon, get them in the group so we can make more matches!"
    promo_str = ""
    potential_msgs =
      [ "Hell yea! Thursday evening the system will put you in a GroupMe with another member who’s also free this week so you can pick a place to meet. Should be fun.",
        "ERMAHGERD YESSSS! Thursday evening the system will put you in a GroupMe with another member who’s also free this week so you can pick a place to meet. Should be fun.",
        "Yes? Yes! Woohoo! Thursday evening the system will put you in a GroupMe with another member who’s also free this week so you can pick a place to meet. Should be fun.",
        "We were hoping you’d say yes! Thursday evening the system will put you in a GroupMe with another member who’s also free this week so you can pick a place to meet. Should be fun.",
        "Booyah! Thursday evening the system will put you in a GroupMe with another member who’s also free this week so you can pick a place to meet. Should be fun.",
        "Wahoo!! Thursday evening the system will put you in a GroupMe with another member who’s also free this week so you can pick a place to meet. Should be fun.",
        "YAYYYYY. Great news. Thursday evening the system will put you in a GroupMe with another member who’s also free this week so you can pick a place to meet. Should be fun.",
        "Fantastic! Thursday evening the system will put you in a GroupMe with another member who’s also free this week so you can pick a place to meet. Should be fun.",
        "Great, thanks! Thursday evening the system will put you in a GroupMe with another member who’s also free this week so you can pick a place to meet. Should be fun."]
    msg = "%s %s" % [potential_msgs[rand(8)], promo_str]
    send_sms(to, msg)
  end

  def send_wednesday_sms(user)
    msg = "Hey #{user.first_name}! Are you free this Friday at some point between 1:00 and 3:00 to grab coffee/tea with another member of the FreeForCoffee group in the DP?

(Pls text back “yes” or “no”.)"
    send_sms(user.phone_number,msg)
    user.response = nil
    user.save
  end

  def send_welcome_sms(user)
    msg = "Hey #{user.first_name}! Welcome to FreeForCoffee (FFC) group within the DP. Here’s what’s next: each Wednesday evening we’ll shoot you a text asking if you’re free for coffee with another member that Friday between 1:00-3:00. You simply text back a “yes” or a “no.” If you send a “yes”, on Thursday evening you’ll be introduced to another member through GroupMe. Then all you have to do is pick the place to meet sometime between 1-3 Friday. If you say “no” we’ll leave you alone. If you say “no” three weeks in a row the system will pause your membership so we aren’t spamming you and because the group only works if people make time for it.

That’s all for now. Glad to have you as part of the FreeForCoffee group in the DP! Hope you enjoy meeting people."
    send_sms(user.phone_number, msg, false)
  end

  def send_policy_because_couldnt_match(user)
    msg = "Hi #{user.first_name}! Bad news. We can’t match you for coffee this week. An odd number of people were free and the system pairs groups of 2 so one person couldn’t be paired. It has nothing to do with you specifically. Regardless, we’re sorry to let you down this time. Hope you’ll say “yes” again next week."
    send_sms(user.phone_number,msg)
  end

  def send_deactivate_because_no_three_times_sms(user)
    msg = "Hi #{user.first_name}! It looks like you’ve said “no” to meeting another member of the FreeForCoffee group in the DP the past three weeks. No problem, you’re busy. We’re pausing your membership so you’ll stop receiving invitations. If you have time to particiapte in the future and would like to re-activate your membership shoot us an email: freeforcoffeeteam@gmail.com"
    send_sms(user.phone_number,msg)
  end
end
