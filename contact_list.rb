require_relative 'contact'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.
  def intialize
	  
	end

  class << self
	  def print_menu
	  	puts "Here is a list of avaliable commands:"
	  	puts "	new     - Create a new contact"
	  	puts "	list    - list all contacts"
	  	puts "	show    - show a contact"
	  	puts "	search  - search a contacts" 
	  end

	  def list
	  	contact_list=Contact.all
	  	contact_list.each do |contact|
	  		puts "#{contact.id}: #{contact.name} (#{contact.email})"
	  	end
	  	puts "#{contact_list.length} records found"
	  end

	  def new_contact
	  	print "Name of contact: "
	  	name = STDIN.gets.chomp
	  	print "Email Address: "
	  	email= STDIN.gets.chomp
	  	contact_list = Contact.all
	  	id = (contact_list.length + 1)
			Contact.create(id, name, email)
		end

		def search_index(index)
			found = Contact.find(index)
			puts "#{found.id}: #{found.name} (#{found.email})"
		end

		def search
			print "search: " 
			search = STDIN.gets.chomp
			found =  Contact.search(search)
				found.each do |contact|
				puts "#{contact.id}: #{contact.name} (#{contact.email})"
			end
			puts "#{found.length} record total"
		end

end

end
	

	puts ARGV
	command = ARGV[0]
	index = ARGV[1]

  if !command
  	ContactList.print_menu
  elsif command == 'list'
  	ContactList.list
  elsif command == 'new'
  	ContactList.new_contact
	elsif command == 'show'
		 ContactList.search_index(index)
	elsif command == 'search'
		ContactList.search
  end
