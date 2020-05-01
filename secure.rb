def user_exist?(username)
  users = File.open('./users.txt', 'r')
  while (line=users.gets)
    return true if line.include?(username)
  end
  users.close
  return false
end

def add_user(username, password)
  users = File.open './users.txt','a'
  users.puts "#{username}=>#{password}"
  users.close
end
