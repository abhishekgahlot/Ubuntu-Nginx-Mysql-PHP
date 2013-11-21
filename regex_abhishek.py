import re
string=open('/etc/nginx/sites-available/default').read()
update='''\n\tlocation ~ \\.php$ {\n\t#\tfastcgi_split_path_info ^(.+\\.php)(/.+)$;\n\t#\t#\tNOTE: You should have "cgi.fix_pathinfo = 0;" in php.ini\n\t#\n\t#\t# With php5-cgi alone:\n\t#\tfastcgi_pass 127.0.0.1:9000;\n\t#\t# With php5-fpm:\n\t\tfastcgi_pass unix:/var/run/php5-fpm.sock;\n\t\tfastcgi_index index.php;\n\t\tinclude fastcgi_params;\n\t}\n'''
updated=re.sub(r'#location ~ \\.php.*?#}', update, string,flags=re.MULTILINE|re.DOTALL)
file=open('/etc/nginx/sites-available/default','w').write(updated)
