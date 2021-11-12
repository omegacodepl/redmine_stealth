module IssueStealthPatch
  def self.included(base)
    unloadable
    base.class_eval do
      alias_method :send_notification_without_stealth, :send_notification
      alias_method :send_notification, :send_notification_with_stealth
    end
  end

  def send_notification_with_stealth
    return if RedmineStealth.cloaked?
    send_notification_without_stealth
  end

  class Initializer < Rails::Railtie
    config.before_initialize do
      Issue.send(:include, IssueStealthPatch)
    end
  end
end

