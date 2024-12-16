# Pin npm packages by running ./bin/importmap

pin "@hotwired/turbo-rails", to: "https://ga.jspm.io/npm:@hotwired/turbo-rails@7.3.0/app/javascript/turbo/index.js"
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.2.2/dist/stimulus.js"

# Your other pins
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.7.1/dist/jquery.js"
pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.1.2/app/assets/javascripts/rails-ujs.esm.js"
pin "jquery-validation", to: "https://ga.jspm.io/npm:jquery-validation@1.20.0/dist/jquery.validate.js"
# pin "js-routes", to: "https://ga.jspm.io/npm:js-routes@2.2.7/dist/js-routes.js"
pin "owl.carousel", to: "https://ga.jspm.io/npm:owl.carousel@2.3.4/dist/owl.carousel.js"
pin "moment", to: "https://ga.jspm.io/npm:moment@2.29.4/moment.js"

pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/javascript/behaviors", under: "behaviors"

# Add this line to pin your application.js
pin "application", preload: true
