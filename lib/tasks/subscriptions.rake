namespace :subscriptions do
  desc 'Retrieve Braintree id codes for each subscription'
  task :identify => :environment do
    subscriptions = Braintree::Subscription.search do |search|
      search.plan_id.is ENV['BRAINTREE_SUBSCRIPTION_PLAN']
    end
    
    subscriptions.each do |subscription|
      customer_id = subscription.transactions.last.customer_details.id rescue nil
      @member = Member.where(:braintree_id => customer_id).take
      if @member
        if @member.subscriptions.include? subscription.id
          puts "subscription #{subscription.id} known"
        else
          @member.subscriptions << subscription.id
          @member.save
          puts "subscription #{subscription.id} assigned to #{@member.email}"
        end
      end
    end
  end
  
  desc 'Determine if any subscriptions are past due'
  task :audit => :environment do
    Member.all.each do |member|
      member.verify_subscription_payments_current rescue nil
    end
  end
  
  desc 'Remind past due members'
  task :remind => :environment do
    Member.past_due.each do |member|
      time_elapsed = (Date.today - member.due_date.to_date).to_i
      case time_elapsed
      when 3
        member.notify_past_due 'unresolved'
      when 6
        member.notify_past_due 'late'
      when 7
        member.notify_past_due 'over'
        member.cancel_subscription!
      end
    end
  end
end
