# Phone number class for Contacts
class PhoneNumber
  attr_accessor :kind, :number

  def initialize(args = nil)
    @kind = if args[:kind].nil?
              'Default'
            else
              args[:kind]
            end

    @number = args[:number]
  end

  def to_s
    "#{kind}: #{number}"
  end
end
