# ResqueDelivery

This gem is a library that lets you easily integrate ActionMailer with Resque.  It allows you to replace your application's delivery method with a Resque backed asynchronous job.

This allows you to avoid mail delivery exception handling throughout your app.  Additionally, you can retry delivery programatically via `resque-retry` or manually.

## Installation

In your Gemfile:

``` ruby
gem 'resque_delivery'
```

In your `config/environments/[RAILS_ENV].rb:`

``` ruby
config.action_mailer.resque_delivery_settings = {
	:delivery_method => :smtp # your real delivery method
}
```

It's that simple.  Your Mailer.mail_name(params).deliver will now queue the Resque job for sending that email.

## Additional Configuration

You can configure 2 additional options in your resque_delivery_settings hash:

* :queue - which resque queue to place the job in
* :job_class - (String or Class) - The job that will be queued. It is recommended that you inherit from the `ResqueDelivery::SendMail` class.

## Notes

We serialize the Mail::Message object (via to_yaml and from_yaml) so that you can pass objects to your Mailer classes.  Other similar
implementations of asynchronous mailing, queue the Mailer name with the mail parameters, building the email parts at send time. This 
implementation allows our workers to be unaware of any data models or views that are required to build the email.  Additionally, no further 
code changes are required to make your mails asynchronous (well, assuming you already have Resque configured).

## Changelog

* 0.0.1 - Initial Version
