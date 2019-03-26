require_relative 'address_book'
require_relative 'contact'

def print_main_menu
  puts 'Address Book'
  puts 'a: Add Contact'
  puts 'r: Remove Contact'
  puts 's: Search'
  puts 'p: Print Address Book'
  puts 'q: Quit'
  puts 'Enter your choice: '
end

def print_add_menu
  puts 'Add phone number or address? '
  puts 'p: Add phone number'
  puts 'a: Add address'
  puts '(Any other key to skip)'
end

def print_search_menu
  puts 'Search by which category?'
  puts 'n: Name'
  puts 'p: Phone Number'
  puts 'a: Address'
  puts '(Any other key to return)'
end

def make_new_contact
  puts 'First name: '
  first_name = gets.chomp
  puts 'Middle name: '
  middle_name = gets.chomp
  puts 'Last name: '
  last_name = gets.chop

  middle_name = nil if middle_name.empty?

  contact = Contact.new(first_name: first_name,
                        middle_name: middle_name,
                        last_name: last_name)
end

def remove_contact(address_book)
  puts 'First name: '
  first_name = gets.chomp
  puts 'Last name: '
  last_name = gets.chomp

  contact = address_book.get_contact(first_name, last_name)
  address_book.contacts.delete(contact)
end

def make_new_address(contact)
  puts 'Kind of address: '
  kind = gets.chomp
  puts 'Street address: '
  street_1 = gets.chomp
  puts 'Apartment/suite: '
  street_2 = gets.chomp
  puts 'City: '
  city = gets.chomp
  puts 'State: '
  state = gets.chomp
  puts 'Postal Code: '
  postal_code = gets.chomp

  street_2 = nil if street_2.empty?

  contact.add_address(kind, street_1, street_2,
                      city, state, postal_code)
end

def make_new_phone_number(contact)
  puts 'Kind of phone: '
  kind = gets.chomp
  puts 'Phone number: '
  number = gets.chomp
  contact.add_phone_number(kind, number)
end

def add_data_to_contact(contact)
  loop do
    print_add_menu
    response = gets.chomp.downcase
    case response
    when 'p'
      make_new_phone_number(contact)
    when 'a'
      make_new_address(contact)
    else
      break
    end
  end
end

def search_by_type(address_book)
  loop do
    print_search_menu
    response = gets.chomp.downcase
    case response
    when 'n'
      puts 'Enter search name: '
      name = gets.chomp
      address_book.find_by_name(name)
    when 'p'
      puts 'Enter search number: '
      number = gets.chomp
      address_book.find_by_phone_number(number)
    when 'a'
      puts 'Enter search address: '
      query = gets.chomp
      address_book.find_by_address(query)
    else
      break
    end
  end
end

def run(address_book)
  loop do
    print_main_menu
    input = gets.chomp.downcase

    case input
    when 'a'
      contact = make_new_contact
      add_data_to_contact(contact)
      address_book.contacts.push(contact)
    when 'r'
      remove_contact(address_book)
    when 's'
      search_by_type(address_book)
    when 'p'
      address_book.print_contacts_list
    when 'q'
      address_book.save
      break
    end
  end
  "\n"
end

address_book = AddressBook.new

run(address_book)