class Mediator
  def notify(sender, event)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class AuthenticationDialog < Mediator
  def initialize(title, login_or_register_checkbox, login_username, login_password, registration_username,
                 registration_password, registration_email, ok_button, cancel_button)
    @title = title
    @login_or_register_checkbox = login_or_register_checkbox
    @login_or_register_checkbox.mediator = self
    @login_username = login_username
    @login_username.mediator = self
    @login_password = login_password
    @login_password.mediator = self
    @registration_username = registration_username
    @registration_username.mediator = self
    @registration_password = registration_password
    @registration_password.mediator = self
    @registration_email = registration_email
    @registration_email.mediator = self
    @ok_button = ok_button
    @ok_button.mediator = self
    @cancel_button = cancel_button
    @cancel_button.mediator = self
  end

  def notify(sender, event)
    if sender == @login_or_register_checkbox && event == 'check'
      if @login_or_register_checkbox.checked?
        @title = 'Log in'
        # 1. Show login form components.
        # 2. Hide registration form components.
      else
        @title = "Register"
        # 1. Show registration form components.
        # 2. Hide login form components
      end
    end

    if sender == @ok_button && event == 'click'
      if @login_or_register_checkbox.checked?
        # Try to find a user using login credentials.
        unless found
          # Show an error message above the login
          # field.
        end
      else
        # 1. Create a user account using data from the
        # registration fields.
        # 2. Log that user in.
        # ...
      end
    end
  end
end

class Component
  attr_accessor :mediator

  def initialize(mediator = nil)
    @mediator = mediator
  end

  def click
    @mediator.notify(self, 'click')
  end

  def key_press
    @mediator.notify(self, 'keypress')
  end
end

class Button < Component
  # ...
end

class Textbox < Component
  # ...
end

class Checkbox < Component
  def check
    @mediator.notify(self, 'check')
  end
end