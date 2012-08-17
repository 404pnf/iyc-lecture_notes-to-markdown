sed -e 's/>/\n/' Investments-cn.xml |grep '^<'|grep -vi '<imagedata' |grep -vi '<bookmark'|grep -vi 'destination'|sort -u >> tags.txt


