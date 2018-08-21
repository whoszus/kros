base_path="/home/tinker/docker"

killall -9 nginx ;
nginx -c $base_path/file-server/nginx-entry.conf;
nginx -c $base_path/file-server/nginx-zuul.conf;
nginx -c $base_path/file-server/nginx-18801.conf;
nginx -c $base_path/file-server/nginx-18802.conf;
nginx -c $base_path/file-server/nginx-18803.conf;
echo 'restart nginx server success! enjoy yourself!'
