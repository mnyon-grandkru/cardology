namespace :subscriptions do
    desc "Cancel past due subscriptions"
    task cancel_past_due: :environment do
      SubscriptionService.cancel_past_due_subscriptions
    end
end
  