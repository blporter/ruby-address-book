require_relative 'phone_number'
require_relative 'address'

# Contact class containing contact information
class Contact
  attr_writer :first_name, :middle_name, :last_name
  attr_reader :first_name, :middle_name, :last_name,
              :phone_numbers,
              :addresses

  def initialize(args = nil)
    @first_name = args[:first_name]
    @middle_name = args[:middle_name]
    @last_name = args[:last_name]

    @phone_numbers = []
    @addresses = []
  end

  def add_phone_number(kind, number)
    phone_number = PhoneNumber.new(kind: kind, number: number)
    phone_numbers.push(phone_number)
  end

  def add_address(kind, street_1, street_2, city, state, postal_code)
    address = Address.new(kind: kind, street_1: street_1, street_2: street_2,
                          city: city, state: state, postal_code: postal_code)
    addresses.push(address)
  end

  def last_first
    full_name = "#{last_name}, #{first_name}"
    full_name += " #{middle_name.slice(0, 1)}." unless middle_name.nil?
    full_name
  end

  def full_name
    full_name = first_name
    full_name += if middle_name.nil?
                   " #{last_name}"
                 else
                   " #{middle_name} #{last_name}"
                 end
  end

  def first_last
    first_name + ' ' + last_name
  end

  def print_phone_numbers
    puts 'Phone Numbers: '
    phone_numbers.each(&method(:puts))
  end

  def print_addresses
    puts 'Addresses: '
    addresses.each(&method(:puts))
  end

  def to_s(format = 'full_name')
    case format
    when 'full_name'
      full_name
    when 'last_first'
      last_first
    when 'first'
      first_name
    when 'last'
      last_name
    else
      first_last
    end
  end
end
