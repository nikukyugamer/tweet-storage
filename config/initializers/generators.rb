Rails.application.config.generators do |g|
  g.template_engine :erb
  g.javascripts false
  g.stylesheets true

  # Decorator を用いるならば false にする
  g.helper true

  g.test_framework :rspec,
                   fixture: true,
                   view_specs: false,
                   helper_specs: false,
                   routing_specs: false,
                   controller_specs: false,
                   request_specs: true
  g.fixture_replacement :factory_bot, dir: 'spec/factories'
end
