# Address class for Contacts
class Address
  attr_accessor :kind, :street_1, :street_2, :city, :state, :postal_code

  def initialize(args = nil)
    @kind = if args[:kind].nil?
              'Default'
            else
              args[:kind]
            end

    @street_1 = args[:street_1]
    @street_2 = args[:street_2]
    @city = args[:city]
    @state = args[:state]
    @postal_code = args[:postal_code]
  end

  def to_s(format = 'short')
    address = ''
    case format
    when 'long'
      address += street_1 + "\n"
      address += street_2 + "\n" unless street_2.nil?
      address += "#{city}, #{state} #{postal_code}"
    when 'short'
      address += "#{kind}: "
      address += street_1
      address += ' ' + street_2 unless street_2.nil?
      address += ", #{city}, #{state} #{postal_code}"
    else
      address += "#{kind}: "
      address += street_1
    end
    address
  end
end
