#!/bin/sh

DIRECTORY=/Users/username/BAO/Code/lights4fun
IMAGE_CDN_URL=https://store-name.myshopify.com/cdn/shop/files/
#VIDEO_CDN_URL=https://cdn.shopify.com/videos/c/vp/

FILES=$(find $DIRECTORY -maxdepth 2 -mindepth 2 -iname "*.json" -not -path "*/locales/*" -not -path "*/assets/*" -type f)

declare -a URLS

for FILE in $FILES
do
  LINES=`cat $FILE`

  for LINE in $LINES
  do

    if [[ "$LINE" == *"shopify:\/\/shop_images"* ]]; then
      LINE=${LINE//"shopify:\/\/shop_images\/"/}
      LINE=${LINE//'"'/}
      LINE=${LINE//','/}
      LINE="$IMAGE_CDN_URL$LINE"

      if [[ ! ${URLS[@]} =~ $LINE ]]
      then
        URLS=("${URLS[@]}" $LINE)
      fi
    fi

    #if [[ "$LINE" == *"shopify:\/\/files\/videos"* ]]; then
    #  LINE=${LINE//"shopify:\/\/files\/videos\/"/}
    #  LINE=${LINE//'"'/}
    #  LINE=${LINE//','/}
    #  LINE="$VIDEO_CDN_URL$LINE"
    #  URLS=("${URLS[@]}" $LINE)
    #fi
  done
done

for URL in ${URLS[@]}
do
  wget -P "./downloads" "$URL"
done


