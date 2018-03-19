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
end
