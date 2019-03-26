require 'yaml'

# Address book class for Contact
class AddressBook
  attr_reader :contacts

  def initialize
    @contacts = []
    open
  end

  def open
    @contacts = YAML.load_file('contacts.yml') if File.exist?('contacts.yml')
  end

  def save
    File.open('contacts.yml', 'w') do |file|
      file.write(contacts.to_yaml)
    end
  end

  def print_contact(contact)
    puts contact.to_s('full_name')
    contact.print_phone_numbers
    contact.print_addresses
  end

  def print_contacts_list
    if contacts.empty?
      puts 'Contact List is empty.'
      return
    end

    puts 'Contact List:'
    contacts.each do |contact|
      puts contact.to_s('last_first')
    end
  end

  def print_search_results(label, search, results)
    puts "#{label} search results (#{search}):"
    puts "\n"

    results.each do |contact|
      print_contact(contact)
      puts "\n"
    end
  end

  def get_contact(first_name, last_name)
    result = ''
    contacts.each do |contact|
      if contact.first_name.casecmp(first_name).zero? &&
         contact.last_name.casecmp(last_name).zero?
        result = contact
      end
    end
    result
  end

  def find_by_name(name)
    results = []
    search = name.downcase

    contacts.each do |contact|
      results.push(contact) if contact.full_name.downcase.include?(search)
    end

    print_search_results('Name', name, results)
  end

  def find_by_phone_number(number)
    results = []
    search = number.delete('-')

    contacts.each do |contact|
      contact.phone_numbers.each do |num|
        unless results.include?(contact)
          results.push(contact) if num.number.delete('-').include?(search)
        end
      end
    end

    print_search_results('Phone', number, results)
  end

  def find_by_address(query)
    results = []
    search = query.downcase

    contacts.each do |contact|
      contact.addresses.each do |address|
        unless results.include?(contact)
          results.push(contact) if address.to_s.downcase.include?(search)
        end
      end
    end

    print_search_results('Address', query, results)
  end
end
