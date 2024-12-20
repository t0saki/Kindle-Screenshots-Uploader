#!/bin/sh

USE_WEBDAV=0

# Image hosting service settings
UPLOAD_URL="https://some_img_hosting.com/upload"
AUTH_CODE="some_auth_code"
SCREENSHOT_DIR="/mnt/us"

# WebDAV settings
WEBDAV_URL="https://webdav.hostname:[port]/path"
USERNAME="webdav_user"
PASSWORD="webdav_password"

ACTION="$1"

X=12
START_Y=32
LINE_OFFSET=0

eips_msg() {
    local MSG="$1"
    eips $X $((START_Y + LINE_OFFSET)) "$MSG"
    LINE_OFFSET=$((LINE_OFFSET + 1))
}

upload_file() {
    PNG_FILE="$1"

    if [ $USE_WEBDAV -eq 1 ]; then
        CURL_OUTPUT=$(curl --fail --location --silent --show-error \
             --user "${USERNAME}:${PASSWORD}" \
             --upload-file "$PNG_FILE" "${WEBDAV_URL}/" 2>&1)
    else
        CURL_OUTPUT=$(curl --fail --location --silent --show-error \
            --request POST "${UPLOAD_URL}?authCode=${AUTH_CODE}" \
            --header "User-Agent: UploadScript/1.0" \
            --form "file=@$PNG_FILE" 2>&1)
    fi

    if [ $? -ne 0 ]; then
        eips_msg "Upload failed: $CURL_OUTPUT"
        return 1
    else
        return 0
    fi
}


delete_screenshot() {
    PNG_FILE="$1"
    BASENAME=$(basename "$PNG_FILE")
    NAME=${BASENAME%.png}
    TXT_FILE="$SCREENSHOT_DIR/wininfo_${NAME}.txt"

    rm -f "$PNG_FILE" "$TXT_FILE"
}

case "$ACTION" in
  upload_and_delete)
    eips_msg "Starting upload and delete..."
    for PNG_FILE in "$SCREENSHOT_DIR"/screenshot_*.png; do
        [ -e "$PNG_FILE" ] || continue
        if upload_file "$PNG_FILE"; then
            eips_msg "Uploaded and deleted: $PNG_FILE"
            delete_screenshot "$PNG_FILE"
        else
            eips_msg "Upload failed: $PNG_FILE"
        fi
    done
    ;;

  upload)
    eips_msg "Starting upload..."
    for PNG_FILE in "$SCREENSHOT_DIR"/screenshot_*.png; do
        [ -e "$PNG_FILE" ] || continue
        if upload_file "$PNG_FILE"; then
            eips_msg "Uploaded: $PNG_FILE"
        else
            eips_msg "Upload failed: $PNG_FILE"
        fi
    done
    ;;

  delete)
    eips_msg "Starting delete..."
    for PNG_FILE in "$SCREENSHOT_DIR"/screenshot_*.png; do
        [ -e "$PNG_FILE" ] || continue
        delete_screenshot "$PNG_FILE"
        eips_msg "Deleted: $PNG_FILE and corresponding TXT file"
    done
    ;;

  *)
    eips_msg "Usage: $0 {upload_and_delete|upload|delete}"
    exit 1
    ;;
esac
