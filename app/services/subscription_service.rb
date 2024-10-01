class SubscriptionService
    def self.cancel_past_due_subscriptions
      Braintree::Subscription.search do |search|
        search.status.is Braintree::Subscription::Status::PastDue
      end.each do |subscription|
        cancel_subscription(subscription)
      end
    end
    private
    def self.cancel_subscription(subscription)
      result = Braintree::Subscription.cancel(subscription.id)
      if result.success?
        puts "Subscription #{subscription.id} has been successfully canceled."
      else
        puts "Failed to cancel subscription #{subscription.id}. Errors: #{result.errors}"
      end
    end
end
  