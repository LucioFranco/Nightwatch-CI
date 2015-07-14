if [ -z $TRAVIS ]
  then
    pkill -f selenium
fi
if [ $SHOW_LOG ]
  then
    cat selenium.log
fi
rm -f selenium.log
