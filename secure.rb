def user_exist?(user_name)
  readfile = File.open "./users.txt", "r"
  while (line=readfile.gets)
	cred = line.split("=>")
	if cred[0]==user_name.strip
		readfile.close
		return true		
	end
  end
  return false
end

def add_user(user_name, password)
  users = File.open "./users.txt", "a"
  users.puts "#{user_name.strip}=>#{password.chomp}"
  users.close
end

def check_password?(user_name, pass_word)
  readfile = File.open "./users.txt", "r"
  while (line=readfile.gets)
	cred = line.split("=>")
	if cred[0]==user_name.strip && cred[1]==pass_word.chomp
		readfile.close
		return true		
	end
  end
	readfile.close
  return false
end

