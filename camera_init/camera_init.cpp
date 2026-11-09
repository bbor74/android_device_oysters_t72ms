/*
   Copyright (c) 2016, The CyanogenMod Project

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are
   met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of The Linux Foundation nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

   THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
   WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
   ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
   BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
   BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
   WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
   OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
   IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#define LOG_TAG "camera_init"

#include <stdlib.h>
#include <unistd.h>

#include <android/log.h>

#define LOGI(...) __android_log_print(ANDROID_LOG_INFO, LOG_TAG, __VA_ARGS__)
#define LOGW(...) __android_log_print(ANDROID_LOG_WARN, LOG_TAG, __VA_ARGS__)
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)

#include <cutils/properties.h>

static void init_media_properties()
{
    char media_profiles[PROP_VALUE_MAX];
    char camera_cfg[PROP_VALUE_MAX];
    char const *camera_type_file = "/sys/devices/camera/type";
    char camera_type[64];
    int camera_type_len = 0;
    FILE *fp = NULL;

    LOGI("Setting media properties ...\n");

        fp = fopen(camera_type_file, "r");
        if (NULL == fp )
        {
            LOGW("fopen %s failed, waitting for 2ms time", camera_type_file);
            usleep(2000);
            fp = fopen(camera_type_file, "r");
        }

        if (NULL != fp)
        {
            camera_type_len = fread(camera_type, 1, 64, fp);
            fclose(fp);
            fp = NULL;
            sprintf(media_profiles, "/etc/camera_cfg/%s/media_profiles.xml", camera_type);
            sprintf(camera_cfg, "/etc/camera_cfg/%s/camera.cfg", camera_type);
            property_set("media.settings.xml", media_profiles);
            property_set("media.camera.cfg", camera_cfg);
            LOGI("Set media.settings.xml: %s \n", media_profiles);
            LOGI("Set media.camera.cfg: %s \n", camera_cfg);
        }
        else
        {
            LOGE("fopen %s failed", camera_type_file);
        }
}

int main(int nargs, char **args)
{
    init_media_properties();

    return 0;
}

