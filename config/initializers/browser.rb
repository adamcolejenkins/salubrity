Rails.configuration.middleware.use Browser::Middleware do
  redirect_to '/upgrade.html' unless (browser.modern? && browser.ie9? != true) || request.env['PATH_INFO'] == '/'
end