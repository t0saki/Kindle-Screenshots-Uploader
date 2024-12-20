# Kindle Screenshots Uploader

[English](readme.md) | [简体中文](readme_zh.md)

A simple tool to upload your Kindle screenshots to a WebDAV server or image hosting service directly from your Kindle device.

## Features

- **Upload and Delete**: Automatically upload your screenshots and remove them from your Kindle.
- **Upload Only**: Upload screenshots without deleting them from your device.
- **Delete All Screenshots**: Remove all screenshots from your Kindle without uploading.

_All deletions also remove the corresponding `wininfo_*.txt` files._

## Screenshots

![screenshot_2024_12_20T05_57_55+0800](readme.assets/screenshot_2024_12_20T05_57_55+0800.png)

![image-20241220060756970](readme.assets/image-20241220060756970.png)

## Installation

1. **Jailbreak Your Kindle**:
   - Ensure your Kindle is jailbroken. If not, follow a reputable guide to jailbreak your specific Kindle model.
   
2. **Install KUAL (Kindle Unified Application Launcher)**:
   - Download and install [KUAL](https://wiki.mobileread.com/wiki/KUAL) on your jailbroken Kindle to manage extensions and custom applications.

3. **Download the Uploader**:
   - Clone or download this repository.
   - Locate the `kindle-ss-uploader` folder within the project.

4. **Copy to Extensions Folder**:
   - Connect your Kindle to your computer via USB.
   - Navigate to the `extensions` directory on your Kindle.
   - Copy the `kindle-ss-uploader` folder into the `extensions` directory.

## Configuration

Before using the uploader, you need to configure the upload URL and authentication code within the `upload_screenshots.sh` script, based on your preferred upload method(WebDAV or Image Hosting Service).

### WebDAV Server

If you don't have a image hosting service, the WebDAV method is recommended.

```sh
USE_WEBDAV=1

# WebDAV settings
WEBDAV_URL="https://webdav.hostname:[port]/path"
USERNAME="webdav_user"
PASSWORD="webdav_password"
```

- **USE_WEBDAV**: Set to `1` to use a WebDAV server for uploading screenshots.
- **WEBDAV_URL**: The URL of your WebDAV server.
- **USERNAME**: The username for your WebDAV server.
- **PASSWORD**: The password for your WebDAV server.

### Image Hosting Service

```sh
# Image hosting service settings
UPLOAD_URL="https://some_img_hosting.com/upload"
AUTH_CODE="some_auth_code"
```

- **USE_WEBDAV**: Set to `0` to use an image hosting service for uploading screenshots.
- **UPLOAD_URL**: The endpoint of your image hosting service.
- **AUTH_CODE**: The authentication code required by your upload service.

    **Important**: Since this tool uses a self-hosted image hosting service, you need to set up your own image hosting server and provide the corresponding `UPLOAD_URL` and `AUTH_CODE` in the script. Depending on your server's API requirements, you may need to modify the `curl` command in the `upload_file` function to match the expected format.

    I'm self-hosting a free and open-source Cloudflare Pages site based on [CloudFlare-ImgBed](https://github.com/MarSeventh/CloudFlare-ImgBed) for my image hosting service. You can set up your own instance or use any other image hosting service that supports direct image uploads via API.

## License

This project is licensed under the [MIT License](LICENSE).

## Acknowledgements

- Thanks to the [KUAL community](https://wiki.mobileread.com/wiki/KUAL) for their invaluable resources and support.
- Inspired by various Kindle customization tools available on MobileRead forums.

---

*Happy screenshotting!*
