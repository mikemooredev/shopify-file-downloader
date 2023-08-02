#!/bin/sh

DIRECTORY=/Users/username/BAO/Code/projectname
IMAGE_CDN_URL=https://store-name.myshopify.com/cdn/shop/files/
#VIDEO_CDN_URL=https://cdn.shopify.com/videos/c/vp/

# Get json files which could reference images
FILES=$(find $DIRECTORY -maxdepth 2 -mindepth 2 -iname "*.json" -not -path "*/locales/*" -not -path "*/assets/*" -type f)

# Declare an array to store URLS
declare -a URLS

# Loop through the found files
for FILE in $FILES
do
  # Store the lines of the files in an array
  LINES=`cat $FILE`

  # Loop through the lines of the files
  for LINE in $LINES
  do

    # If the line contains "shopify:\/\/shop_images" build a URL and append it to the URLS array
    if [[ "$LINE" == *"shopify:\/\/shop_images"* ]]; then
      LINE=${LINE//"shopify:\/\/shop_images\/"/}
      LINE=${LINE//'"'/}
      LINE=${LINE//','/}
      LINE="$IMAGE_CDN_URL$LINE"

      # Only append the URL to the array when it's not already in the array
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

# Make a downloads directory if one doesn't already exist
mkdir -p ./downloads

# Loop through the URLS array and downloas each image using wget
for URL in ${URLS[@]}
do
  wget -P "./downloads" "$URL"
done


