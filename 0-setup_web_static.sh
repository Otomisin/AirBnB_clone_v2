 script to install and conf nginx

#install nginx if not installed
sudo apt-get update
sudo apt-get install nginx -y

#create repositories if not installed
sudo mkdir -p /data/web_static/releases/test/
sudo mkdir -p /data/web_static/shared/

#create a dummy html page with HS
echo "<!DOCTYPE html>
<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" | sudo tee /data/web_static/releases/test/index.html

#create a symbolic link
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

#change directory name
sudo chown -R ubuntu:ubuntu /data/

#set up the page to be served
sudo sed -i '/server_name _;/a \ \tlocation /hbnb_static {\n\t\talias /data/web_static/current;\n\t}\n' /etc/nginx/sites-available/default

#restart the server
sudo service nginx restart
