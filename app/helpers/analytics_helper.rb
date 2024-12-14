module AnalyticsHelper
  def google_analytics
    tag.script(:src => "https://www.googletagmanager.com/gtag/js?id=#{ENV['GOOGLE_ANALYTICS_URCHIN']}", :async => true) +
    javascript_tag do <<-SCRIPT
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());
      
      gtag('config', '#{ENV['GOOGLE_ANALYTICS_URCHIN']}');
      SCRIPT
      .html_safe
    end
  end
end
