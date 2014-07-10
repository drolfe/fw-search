require 'sinatra'

$getpol = File.open("test.cfg", "r")
$fwpolicy = $getpol.read.scan(/^set\sservice.*protocol.*?\n|^set\sgroup.*address.*?\n|^set\saddress.*?\n|(?m)set\spolicy.*?exit/)
$hint = Array.new
$fwpolicy.each do |x|
w = x.gsub(/"/, '').split(" ")
$hint.push(w)
end
$hints = $hint.flatten.uniq.sort
get '/' do

erb :landing
end

post '/' do

#seach policy blocks from user input
$search_txt = nil
$search_txt = params[:search_txt]
@results = $fwpolicy.select {|pol| pol.include? $search_txt}
erb :table
end
