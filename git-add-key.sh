 read -p "Enter github email : " email
 if [ ! -f ~/.ssh/id_rsa ]; then
   ssh-keygen -t rsa -b 4096 -C "$email"
   ssh-add ~/.ssh/id_rsa
 fi
 pub=`cat ~/.ssh/id_rsa.pub`
 read -p "Enter github username: " githubuser
 read -s -p "Enter github password for user $githubuser: " githubpass
 echo
 read -p "Enter github OTP (press enter for none): " otp
 curl -u "$githubuser:$githubpass" -X POST -d "{\"title\":\"`hostname`\",\"key\":\"$pub\"}" --header "x-github-otp: $otp" https://api.github.com/user/keys
