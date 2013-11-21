import re
string=open('/etc/nginx/sites-available/default').read()
update='''\n\tlocation ~ \\.php$ {\n        #       fastcgi_split_path_info ^(.+\\.php)(/.+)$;\n        #       # NOTE: You should have "cgi.fix_pathinfo = 0;" in php.ini\n        #\n        #       # With php5-cgi alone:\n        #       fastcgi_pass 127.0.0.1:9000;\n        #       # With php5-fpm:\n                fastcgi_pass unix:/var/run/php5-fpm.sock;\n                fastcgi_index index.php;\n                include fastcgi_params;\n        }\n'''
updated=re.sub(r'#location ~ \\.php.*?#}', update, string,flags=re.MULTILINE|re.DOTALL)
file=open('/etc/nginx/sites-available/default','w').write(updated)
