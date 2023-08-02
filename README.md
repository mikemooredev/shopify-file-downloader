# shopify-file-downloader

Requires `wget` to be installed.

Amend the `DIRECTORY` and `IMAGE_CDN_URL` variables on lines 3 and 4.

```
DIRECTORY=/Users/username/BAO/Code/projectname
IMAGE_CDN_URL=https://store-name.myshopify.com/cdn/shop/files/
```

Download `script.sh` and execute the command `bash script.sh` in terminal.

The script will create a `downloads` directory at the same path from which it's executed. 
Run the script from your home directory (`~/`) and images will be downloaded to `~/downloads`.
