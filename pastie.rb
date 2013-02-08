require 'sinatra'

before do
  puts '[Params]'
  p params
end

get '/' do
 erb :paste
end

get '/show/:id/?:render' do
  paste_id = params[:id]
  begin
    File.open("/tmp/#{paste_id}","r"){ |f| @paste = f.read }
  rescue
    @paste = "Unable to find"
  end

  if params[:render]
    @render = true
  end
  erb :show
end

post '/pasteit' do
  id = rand(10000000000000)

  content = params["content"]
  content = sanitize content

  puts "Got content: #{content}"

  File.open("/tmp/#{id}","w") { |f| f.write content }
  redirect "/show/#{id}"
end
