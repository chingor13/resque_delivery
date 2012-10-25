class ResqueDelivery
  class SettingsError < ArgumentError; end

  attr_reader :delivery_method, :queue, :job_class

  def initialize(options)
    @delivery_method = options[:delivery_method]
    @queue = options[:queue] || :medium
    @job_class = options[:job_class] || SendMail
    @job_class = @job_class.constantize if @job_class.is_a?(String)

    @job_class.instance_variable_set(:@queue, @queue)

    raise SettingsError, "you must specify config.action_mailer.resque_delivery_settings to contain a :delivery_method" unless @delivery_method
  end

  def deliver!(mail)
    # serialize the mail object for later sending
    Resque.enqueue_to(queue, job_class, delivery_method, mail.to_yaml)
  end

  class SendMail
    @queue = :medium

    class << self
      def perform(delivery_method, mail_yaml)
        real_delivery_method(delivery_method).deliver!(build_message(mail_yaml))
      end
      protected

      # deserialize the mail object
      def build_message(mail_yaml)
        Mail::Message.from_yaml(mail_yaml)
      end

      def real_delivery_method(delivery_method)
        settings = ActionMailer::Base.send(:"#{delivery_method}_settings")
        ActionMailer::Base.delivery_methods[delivery_method.to_sym].new(settings)
      end
    end
  end

end

ActionMailer::Base.add_delivery_method(:resque_delivery, ResqueDelivery)
