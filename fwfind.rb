require 'sinatra'

get '/' do
erb :landing
end

post '/' do
#open the file for reading
getpol = File.open("test.cfg", "r")
#read and search for fw policy blocks
fwpolicy = getpol.read.scan(/^set\sservice.*protocol.*?\n|^set\sgroup.*address.*?\n|^set\saddress.*?\n|(?m)set\spolicy.*?exit/)
#seach policy blocks from user input
$search_txt = params[:search_txt]
@results = fwpolicy.select {|pol| pol.include? $search_txt}
erb :table
end
