require 'csv'
require 'pry'

# Represents a person in an address book.
# The ContactList class will work with Contact objects instead of interacting with the CSV file directly
class Contact

  @@all_contacts = []

  attr_accessor :name, :email, :id
  
  # Creates a new contact object
  # @param name [String] The contact's name
  # @param email [String] The contact's email address
  def initialize(name, email)
    # TODO: Assign parameter values to instance variables.
    @name = name
    @email = email
    @id = ((CSV.read('contacts.csv')).length) + 1
  end

  def create

  end

  # Provides functionality for managing contacts in the csv file.
  class << self

    # Opens 'contacts.csv' and creates a Contact object for each line in the file (aka each contact).
    # @return [Array<Contact>] Array of Contact objects
    def all
      # TODO: Return an Array of Contact instances made from the data in 'contacts.csv'.
      all_contacts = []
      CSV.foreach('contacts.csv') do |row|
        all_contacts << row
      end
      all_contacts
    end

    # Creates a new contact, adding it to the csv file, returning the new contact.
    # @param name [String] the new contact's name
    # @param email [String] the contact's email
    def create(name, email)
      contact = Contact.new(name, email)
      contacts = CSV.read('contacts.csv')
      contacts << [contact.id.to_s ,contact.name, contact.email]
      CSV.open('contacts.csv', 'w') do |contact_list|
        contacts.each do |row_array|
          contact_list<<row_array
        end
      end
      contact
      # TODO: Instantiate a Contact, add its data to the 'contacts.csv' file, and return it.
    end
    
    # Find the Contact in the 'contacts.csv' file with the matching id.
    # @param id [Integer] the contact id
    # @return [Contact, nil] the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      # TODO: Find the Contact in the 'contacts.csv' file with the matching id.
      found = []
      contact_list=CSV.read('contacts.csv')
      contact_list.each do |row|
        if row[0] == id.to_s
         found << row
        else
         nil
        end
      end
      found
    end
    
    # Search for contacts by either name or email.
    # @param term [String] the name fragment or email fragment to search for
    # @return [Array<Contact>] Array of Contact objects.
    def search(term)
      # TODO: Select the Contact instances from the 'contacts.csv' file whose name or email attributes contain the search term.
      all_found = []
      CSV.foreach('contacts.csv') do |row|
        row.each do |segment|
          if segment.include?(term)
            all_found<<row
          end
        end
      end
      all_found
    end

  end

end
Contact.search('yes')



