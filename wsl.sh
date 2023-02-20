# use windows proxy
hostip=$(cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }')
git config --global https.proxy "socks5://$hostip:7500"
git config --global http.proxy "socks5://$hostip:7500"
# export http_proxy="http://$hostip:7500"
# export https_proxy="http://$hostip:7500"
