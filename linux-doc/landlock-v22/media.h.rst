.. -*- coding: utf-8; mode: rst -*-

media.h
=======

.. parsed-literal::

    \/\* SPDX-License-Identifier\: GPL-2.0 WITH Linux-syscall-note \*\/
    \/\*
     \* Multimedia device API
     \*
     \* Copyright (C) 2010 Nokia Corporation
     \*
     \* Contacts\: Laurent Pinchart \<laurent.pinchart@ideasonboard.com\>
     \*           Sakari Ailus \<sakari.ailus@iki.fi\>
     \*
     \* This program is free software; you can redistribute it and\/or modify
     \* it under the terms of the GNU General Public License version 2 as
     \* published by the Free Software Foundation.
     \*
     \* This program is distributed in the hope that it will be useful,
     \* but WITHOUT ANY WARRANTY; without even the implied warranty of
     \* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     \* GNU General Public License for more details.
     \*\/

    \#ifndef \_\_LINUX\_MEDIA\_H
    \#define \_\_LINUX\_MEDIA\_H

    \#ifndef \_\_KERNEL\_\_
    \#include \<stdint.h\>
    \#endif
    \#include \<linux\/ioctl.h\>
    \#include \<linux\/types.h\>

    struct media_device_info \{
            char driver[16];
            char model[32];
            char serial[40];
            char bus\_info[32];
            \_\_u32 media\_version;
            \_\_u32 hw\_revision;
            \_\_u32 driver\_version;
            \_\_u32 reserved[31];
    \};

    \/\*
     \* Base number ranges for entity functions
     \*
     \* NOTE\: Userspace should not rely on these ranges to identify a group
     \* of function types, as newer functions can be added with any name within
     \* the full u32 range.
     \*
     \* Some older functions use the MEDIA\_ENT\_F\_OLD\_\*\_BASE range. Do not
     \* change this, this is for backwards compatibility. When adding new
     \* functions always use MEDIA\_ENT\_F\_BASE.
     \*\/
    \#define MEDIA\_ENT\_F\_BASE                        0x00000000
    \#define MEDIA\_ENT\_F\_OLD\_BASE                    0x00010000
    \#define MEDIA\_ENT\_F\_OLD\_SUBDEV\_BASE             0x00020000

    \/\*
     \* Initial value to be used when a new entity is created
     \* Drivers should change it to something useful.
     \*\/
    \#define \ :ref:`MEDIA_ENT_F_UNKNOWN <media-ent-f-unknown>`                     MEDIA\_ENT\_F\_BASE

    \/\*
     \* Subdevs are initialized with \ :ref:`MEDIA_ENT_F_V4L2_SUBDEV_UNKNOWN <media-ent-f-v4l2-subdev-unknown>` in order
     \* to preserve backward compatibility. Drivers must change to the proper
     \* subdev type before registering the entity.
     \*\/
    \#define \ :ref:`MEDIA_ENT_F_V4L2_SUBDEV_UNKNOWN <media-ent-f-v4l2-subdev-unknown>`         MEDIA\_ENT\_F\_OLD\_SUBDEV\_BASE

    \/\*
     \* DVB entity functions
     \*\/
    \#define \ :ref:`MEDIA_ENT_F_DTV_DEMOD <media-ent-f-dtv-demod>`                   (MEDIA\_ENT\_F\_BASE + 0x00001)
    \#define \ :ref:`MEDIA_ENT_F_TS_DEMUX <media-ent-f-ts-demux>`                    (MEDIA\_ENT\_F\_BASE + 0x00002)
    \#define \ :ref:`MEDIA_ENT_F_DTV_CA <media-ent-f-dtv-ca>`                      (MEDIA\_ENT\_F\_BASE + 0x00003)
    \#define \ :ref:`MEDIA_ENT_F_DTV_NET_DECAP <media-ent-f-dtv-net-decap>`               (MEDIA\_ENT\_F\_BASE + 0x00004)

    \/\*
     \* I\/O entity functions
     \*\/
    \#define \ :ref:`MEDIA_ENT_F_IO_V4L <media-ent-f-io-v4l>`                      (MEDIA\_ENT\_F\_OLD\_BASE + 1)
    \#define \ :ref:`MEDIA_ENT_F_IO_DTV <media-ent-f-io-dtv>`                      (MEDIA\_ENT\_F\_BASE + 0x01001)
    \#define \ :ref:`MEDIA_ENT_F_IO_VBI <media-ent-f-io-vbi>`                      (MEDIA\_ENT\_F\_BASE + 0x01002)
    \#define \ :ref:`MEDIA_ENT_F_IO_SWRADIO <media-ent-f-io-swradio>`                  (MEDIA\_ENT\_F\_BASE + 0x01003)

    \/\*
     \* Sensor functions
     \*\/
    \#define \ :ref:`MEDIA_ENT_F_CAM_SENSOR <media-ent-f-cam-sensor>`                  (MEDIA\_ENT\_F\_OLD\_SUBDEV\_BASE + 1)
    \#define \ :ref:`MEDIA_ENT_F_FLASH <media-ent-f-flash>`                       (MEDIA\_ENT\_F\_OLD\_SUBDEV\_BASE + 2)
    \#define \ :ref:`MEDIA_ENT_F_LENS <media-ent-f-lens>`                        (MEDIA\_ENT\_F\_OLD\_SUBDEV\_BASE + 3)

    \/\*
     \* Digital TV, analog TV, radio and\/or software defined radio tuner functions.
     \*
     \* It is a responsibility of the master\/bridge drivers to add connectors
     \* and links for MEDIA\_ENT\_F\_TUNER. Please notice that some old tuners
     \* may require the usage of separate I2C chips to decode analog TV signals,
     \* when the master\/bridge chipset doesn't have its own TV standard decoder.
     \* On such cases, the IF-PLL staging is mapped via one or two entities\:
     \* \ :ref:`MEDIA_ENT_F_IF_VID_DECODER <media-ent-f-if-vid-decoder>` and\/or MEDIA\_ENT\_F\_IF\_AUD\_DECODER.
     \*\/
    \#define \ :ref:`MEDIA_ENT_F_TUNER <media-ent-f-tuner>`                       (MEDIA\_ENT\_F\_OLD\_SUBDEV\_BASE + 5)

    \/\*
     \* Analog TV IF-PLL decoder functions
     \*
     \* It is a responsibility of the master\/bridge drivers to create links
     \* for \ :ref:`MEDIA_ENT_F_IF_VID_DECODER <media-ent-f-if-vid-decoder>` and MEDIA\_ENT\_F\_IF\_AUD\_DECODER.
     \*\/
    \#define \ :ref:`MEDIA_ENT_F_IF_VID_DECODER <media-ent-f-if-vid-decoder>`              (MEDIA\_ENT\_F\_BASE + 0x02001)
    \#define \ :ref:`MEDIA_ENT_F_IF_AUD_DECODER <media-ent-f-if-aud-decoder>`              (MEDIA\_ENT\_F\_BASE + 0x02002)

    \/\*
     \* Audio entity functions
     \*\/
    \#define \ :ref:`MEDIA_ENT_F_AUDIO_CAPTURE <media-ent-f-audio-capture>`               (MEDIA\_ENT\_F\_BASE + 0x03001)
    \#define \ :ref:`MEDIA_ENT_F_AUDIO_PLAYBACK <media-ent-f-audio-playback>`              (MEDIA\_ENT\_F\_BASE + 0x03002)
    \#define \ :ref:`MEDIA_ENT_F_AUDIO_MIXER <media-ent-f-audio-mixer>`                 (MEDIA\_ENT\_F\_BASE + 0x03003)

    \/\*
     \* Processing entity functions
     \*\/
    \#define \ :ref:`MEDIA_ENT_F_PROC_VIDEO_COMPOSER <media-ent-f-proc-video-composer>`         (MEDIA\_ENT\_F\_BASE + 0x4001)
    \#define \ :ref:`MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER <media-ent-f-proc-video-pixel-formatter>`  (MEDIA\_ENT\_F\_BASE + 0x4002)
    \#define \ :ref:`MEDIA_ENT_F_PROC_VIDEO_PIXEL_ENC_CONV <media-ent-f-proc-video-pixel-enc-conv>`   (MEDIA\_ENT\_F\_BASE + 0x4003)
    \#define \ :ref:`MEDIA_ENT_F_PROC_VIDEO_LUT <media-ent-f-proc-video-lut>`              (MEDIA\_ENT\_F\_BASE + 0x4004)
    \#define \ :ref:`MEDIA_ENT_F_PROC_VIDEO_SCALER <media-ent-f-proc-video-scaler>`           (MEDIA\_ENT\_F\_BASE + 0x4005)
    \#define \ :ref:`MEDIA_ENT_F_PROC_VIDEO_STATISTICS <media-ent-f-proc-video-statistics>`       (MEDIA\_ENT\_F\_BASE + 0x4006)
    \#define \ :ref:`MEDIA_ENT_F_PROC_VIDEO_ENCODER <media-ent-f-proc-video-encoder>`          (MEDIA\_ENT\_F\_BASE + 0x4007)
    \#define \ :ref:`MEDIA_ENT_F_PROC_VIDEO_DECODER <media-ent-f-proc-video-decoder>`          (MEDIA\_ENT\_F\_BASE + 0x4008)

    \/\*
     \* Switch and bridge entity functions
     \*\/
    \#define \ :ref:`MEDIA_ENT_F_VID_MUX <media-ent-f-vid-mux>`                     (MEDIA\_ENT\_F\_BASE + 0x5001)
    \#define \ :ref:`MEDIA_ENT_F_VID_IF_BRIDGE <media-ent-f-vid-if-bridge>`               (MEDIA\_ENT\_F\_BASE + 0x5002)

    \/\*
     \* Video decoder\/encoder functions
     \*\/
    \#define \ :ref:`MEDIA_ENT_F_ATV_DECODER <media-ent-f-atv-decoder>`                 (MEDIA\_ENT\_F\_OLD\_SUBDEV\_BASE + 4)
    \#define \ :ref:`MEDIA_ENT_F_DV_DECODER <media-ent-f-dv-decoder>`                  (MEDIA\_ENT\_F\_BASE + 0x6001)
    \#define \ :ref:`MEDIA_ENT_F_DV_ENCODER <media-ent-f-dv-encoder>`                  (MEDIA\_ENT\_F\_BASE + 0x6002)

    \/\* Entity flags \*\/
    \#define \ :ref:`MEDIA_ENT_FL_DEFAULT <media-ent-fl-default>`                    (1 \<\< 0)
    \#define \ :ref:`MEDIA_ENT_FL_CONNECTOR <media-ent-fl-connector>`                  (1 \<\< 1)

    \/\* OR with the entity id value to find the next entity \*\/
    \#define \ :ref:`MEDIA_ENT_ID_FLAG_NEXT <media-ent-id-flag-next>`                  (1U \<\< 31)

    struct media_entity_desc \{
            \_\_u32 id;
            char name[32];
            \_\_u32 type;
            \_\_u32 revision;
            \_\_u32 flags;
            \_\_u32 group\_id;
            \_\_u16 pads;
            \_\_u16 links;

            \_\_u32 reserved[4];

            union \{
                    \/\* Node specifications \*\/
                    struct \{
                            \_\_u32 major;
                            \_\_u32 minor;
                    \} dev;

    \#if !defined(\_\_KERNEL\_\_)
                    \/\*
                     \* TODO\: this shouldn't have been added without
                     \* actual drivers that use this. When the first real driver
                     \* appears that sets this information, special attention
                     \* should be given whether this information is 1) enough, and
                     \* 2) can deal with udev rules that rename devices. The struct
                     \* dev would not be sufficient for this since that does not
                     \* contain the subdevice information. In addition, struct dev
                     \* can only refer to a single device, and not to multiple (e.g.
                     \* pcm and mixer devices).
                     \*\/
                    struct \{
                            \_\_u32 card;
                            \_\_u32 device;
                            \_\_u32 subdevice;
                    \} alsa;

                    \/\*
                     \* **DEPRECATED**\: previous node specifications. Kept just to
                     \* avoid breaking compilation. Use media\_entity\_desc.dev
                     \* instead.
                     \*\/
                    struct \{
                            \_\_u32 major;
                            \_\_u32 minor;
                    \} v4l;
                    struct \{
                            \_\_u32 major;
                            \_\_u32 minor;
                    \} fb;
                    int dvb;
    \#endif

                    \/\* Sub-device specifications \*\/
                    \/\* Nothing needed yet \*\/
                    \_\_u8 raw[184];
            \};
    \};

    \#define \ :ref:`MEDIA_PAD_FL_SINK <media-pad-fl-sink>`                       (1 \<\< 0)
    \#define \ :ref:`MEDIA_PAD_FL_SOURCE <media-pad-fl-source>`                     (1 \<\< 1)
    \#define \ :ref:`MEDIA_PAD_FL_MUST_CONNECT <media-pad-fl-must-connect>`               (1 \<\< 2)

    struct media_pad_desc \{
            \_\_u32 entity;           \/\* entity ID \*\/
            \_\_u16 index;            \/\* pad index \*\/
            \_\_u32 flags;            \/\* pad flags \*\/
            \_\_u32 reserved[2];
    \};

    \#define \ :ref:`MEDIA_LNK_FL_ENABLED <media-lnk-fl-enabled>`                    (1 \<\< 0)
    \#define \ :ref:`MEDIA_LNK_FL_IMMUTABLE <media-lnk-fl-immutable>`                  (1 \<\< 1)
    \#define \ :ref:`MEDIA_LNK_FL_DYNAMIC <media-lnk-fl-dynamic>`                    (1 \<\< 2)

    \#define \ :ref:`MEDIA_LNK_FL_LINK_TYPE <media-lnk-fl-link-type>`                  (0xf \<\< 28)
    \#  define \ :ref:`MEDIA_LNK_FL_DATA_LINK <media-lnk-fl-data-link>`                (0 \<\< 28)
    \#  define \ :ref:`MEDIA_LNK_FL_INTERFACE_LINK <media-lnk-fl-interface-link>`           (1 \<\< 28)

    struct media_link_desc \{
            struct media_pad_desc source;
            struct media_pad_desc sink;
            \_\_u32 flags;
            \_\_u32 reserved[2];
    \};

    struct media_links_enum \{
            \_\_u32 entity;
            \/\* Should have enough room for pads elements \*\/
            struct media_pad_desc \_\_user \*pads;
            \/\* Should have enough room for links elements \*\/
            struct media_link_desc \_\_user \*links;
            \_\_u32 reserved[4];
    \};

    \/\* Interface type ranges \*\/

    \#define MEDIA\_INTF\_T\_DVB\_BASE                   0x00000100
    \#define MEDIA\_INTF\_T\_V4L\_BASE                   0x00000200

    \/\* Interface types \*\/

    \#define \ :ref:`MEDIA_INTF_T_DVB_FE <media-intf-t-dvb-fe>`                     (MEDIA\_INTF\_T\_DVB\_BASE)
    \#define \ :ref:`MEDIA_INTF_T_DVB_DEMUX <media-intf-t-dvb-demux>`                  (MEDIA\_INTF\_T\_DVB\_BASE + 1)
    \#define \ :ref:`MEDIA_INTF_T_DVB_DVR <media-intf-t-dvb-dvr>`                    (MEDIA\_INTF\_T\_DVB\_BASE + 2)
    \#define \ :ref:`MEDIA_INTF_T_DVB_CA <media-intf-t-dvb-ca>`                     (MEDIA\_INTF\_T\_DVB\_BASE + 3)
    \#define \ :ref:`MEDIA_INTF_T_DVB_NET <media-intf-t-dvb-net>`                    (MEDIA\_INTF\_T\_DVB\_BASE + 4)

    \#define \ :ref:`MEDIA_INTF_T_V4L_VIDEO <media-intf-t-v4l-video>`                  (MEDIA\_INTF\_T\_V4L\_BASE)
    \#define \ :ref:`MEDIA_INTF_T_V4L_VBI <media-intf-t-v4l-vbi>`                    (MEDIA\_INTF\_T\_V4L\_BASE + 1)
    \#define \ :ref:`MEDIA_INTF_T_V4L_RADIO <media-intf-t-v4l-radio>`                  (MEDIA\_INTF\_T\_V4L\_BASE + 2)
    \#define \ :ref:`MEDIA_INTF_T_V4L_SUBDEV <media-intf-t-v4l-subdev>`                 (MEDIA\_INTF\_T\_V4L\_BASE + 3)
    \#define \ :ref:`MEDIA_INTF_T_V4L_SWRADIO <media-intf-t-v4l-swradio>`                (MEDIA\_INTF\_T\_V4L\_BASE + 4)
    \#define \ :ref:`MEDIA_INTF_T_V4L_TOUCH <media-intf-t-v4l-touch>`                  (MEDIA\_INTF\_T\_V4L\_BASE + 5)

    \#define MEDIA\_INTF\_T\_ALSA\_BASE                  0x00000300
    \#define \ :ref:`MEDIA_INTF_T_ALSA_PCM_CAPTURE <media-intf-t-alsa-pcm-capture>`           (MEDIA\_INTF\_T\_ALSA\_BASE)
    \#define \ :ref:`MEDIA_INTF_T_ALSA_PCM_PLAYBACK <media-intf-t-alsa-pcm-playback>`          (MEDIA\_INTF\_T\_ALSA\_BASE + 1)
    \#define \ :ref:`MEDIA_INTF_T_ALSA_CONTROL <media-intf-t-alsa-control>`               (MEDIA\_INTF\_T\_ALSA\_BASE + 2)

    \#if defined(\_\_KERNEL\_\_)

    \/\*
     \* Connector functions
     \*
     \* For now these should not be used in userspace, as some definitions may
     \* change.
     \*
     \* It is the responsibility of the entity drivers to add connectors and links.
     \*\/
    \#define \ :ref:`MEDIA_ENT_F_CONN_RF <media-ent-f-conn-rf>`                     (MEDIA\_ENT\_F\_BASE + 0x30001)
    \#define \ :ref:`MEDIA_ENT_F_CONN_SVIDEO <media-ent-f-conn-svideo>`                 (MEDIA\_ENT\_F\_BASE + 0x30002)
    \#define \ :ref:`MEDIA_ENT_F_CONN_COMPOSITE <media-ent-f-conn-composite>`              (MEDIA\_ENT\_F\_BASE + 0x30003)

    \#endif

    \/\*
     \* MC next gen API definitions
     \*\/

    \/\*
     \* Appeared in 4.19.0.
     \*
     \* The media\_version argument comes from the media\_version field in
     \* struct media\_device\_info.
     \*\/
    \#define MEDIA\_V2\_ENTITY\_HAS\_FLAGS(media\_version) \\
            ((media\_version) \>= ((4 \<\< 16) \| (19 \<\< 8) \| 0))

    struct media_v2_entity \{
            \_\_u32 id;
            char name[64];
            \_\_u32 function;         \/\* Main function of the entity \*\/
            \_\_u32 flags;
            \_\_u32 reserved[5];
    \} \_\_attribute\_\_ ((packed));

    \/\* Should match the specific fields at media\_intf\_devnode \*\/
    struct media_v2_intf_devnode \{
            \_\_u32 major;
            \_\_u32 minor;
    \} \_\_attribute\_\_ ((packed));

    struct media_v2_interface \{
            \_\_u32 id;
            \_\_u32 intf\_type;
            \_\_u32 flags;
            \_\_u32 reserved[9];

            union \{
                    struct media_v2_intf_devnode devnode;
                    \_\_u32 raw[16];
            \};
    \} \_\_attribute\_\_ ((packed));

    \/\*
     \* Appeared in 4.19.0.
     \*
     \* The media\_version argument comes from the media\_version field in
     \* struct media\_device\_info.
     \*\/
    \#define MEDIA\_V2\_PAD\_HAS\_INDEX(media\_version) \\
            ((media\_version) \>= ((4 \<\< 16) \| (19 \<\< 8) \| 0))

    struct media_v2_pad \{
            \_\_u32 id;
            \_\_u32 entity\_id;
            \_\_u32 flags;
            \_\_u32 index;
            \_\_u32 reserved[4];
    \} \_\_attribute\_\_ ((packed));

    struct media_v2_link \{
            \_\_u32 id;
            \_\_u32 source\_id;
            \_\_u32 sink\_id;
            \_\_u32 flags;
            \_\_u32 reserved[6];
    \} \_\_attribute\_\_ ((packed));

    struct media_v2_topology \{
            \_\_u64 topology\_version;

            \_\_u32 num\_entities;
            \_\_u32 reserved1;
            \_\_u64 ptr\_entities;

            \_\_u32 num\_interfaces;
            \_\_u32 reserved2;
            \_\_u64 ptr\_interfaces;

            \_\_u32 num\_pads;
            \_\_u32 reserved3;
            \_\_u64 ptr\_pads;

            \_\_u32 num\_links;
            \_\_u32 reserved4;
            \_\_u64 ptr\_links;
    \} \_\_attribute\_\_ ((packed));

    \/\* ioctls \*\/

    \#define \ :ref:`MEDIA_IOC_DEVICE_INFO <media_ioc_device_info>`   \_IOWR('\|', 0x00, struct media_device_info\ )
    \#define \ :ref:`MEDIA_IOC_ENUM_ENTITIES <media_ioc_enum_entities>` \_IOWR('\|', 0x01, struct media_entity_desc\ )
    \#define \ :ref:`MEDIA_IOC_ENUM_LINKS <media_ioc_enum_links>`    \_IOWR('\|', 0x02, struct media_links_enum\ )
    \#define \ :ref:`MEDIA_IOC_SETUP_LINK <media_ioc_setup_link>`    \_IOWR('\|', 0x03, struct media_link_desc\ )
    \#define \ :ref:`MEDIA_IOC_G_TOPOLOGY <media_ioc_g_topology>`    \_IOWR('\|', 0x04, struct media_v2_topology\ )
    \#define \ :ref:`MEDIA_IOC_REQUEST_ALLOC <media_ioc_request_alloc>` \_IOR ('\|', 0x05, int)

    \/\*
     \* These ioctls are called on the request file descriptor as returned
     \* by MEDIA\_IOC\_REQUEST\_ALLOC.
     \*\/
    \#define \ :ref:`MEDIA_REQUEST_IOC_QUEUE <media_request_ioc_queue>`         \_IO('\|',  0x80)
    \#define \ :ref:`MEDIA_REQUEST_IOC_REINIT <media_request_ioc_reinit>`        \_IO('\|',  0x81)

    \#ifndef \_\_KERNEL\_\_

    \/\*
     \* Legacy symbols used to avoid userspace compilation breakages.
     \* Do not use any of this in new applications!
     \*
     \* Those symbols map the entity function into types and should be
     \* used only on legacy programs for legacy hardware. Don't rely
     \* on those for MEDIA\_IOC\_G\_TOPOLOGY.
     \*\/
    \#define MEDIA\_ENT\_TYPE\_SHIFT                    16
    \#define MEDIA\_ENT\_TYPE\_MASK                     0x00ff0000
    \#define MEDIA\_ENT\_SUBTYPE\_MASK                  0x0000ffff

    \#define MEDIA\_ENT\_T\_DEVNODE\_UNKNOWN             (MEDIA\_ENT\_F\_OLD\_BASE \| \\
                                                     MEDIA\_ENT\_SUBTYPE\_MASK)

    \#define MEDIA\_ENT\_T\_DEVNODE                     MEDIA\_ENT\_F\_OLD\_BASE
    \#define MEDIA\_ENT\_T\_DEVNODE\_V4L                 \ :ref:`MEDIA_ENT_F_IO_V4L <media-ent-f-io-v4l>`
    \#define MEDIA\_ENT\_T\_DEVNODE\_FB                  (MEDIA\_ENT\_F\_OLD\_BASE + 2)
    \#define MEDIA\_ENT\_T\_DEVNODE\_ALSA                (MEDIA\_ENT\_F\_OLD\_BASE + 3)
    \#define MEDIA\_ENT\_T\_DEVNODE\_DVB                 (MEDIA\_ENT\_F\_OLD\_BASE + 4)

    \#define MEDIA\_ENT\_T\_UNKNOWN                     \ :ref:`MEDIA_ENT_F_UNKNOWN <media-ent-f-unknown>`
    \#define MEDIA\_ENT\_T\_V4L2\_VIDEO                  \ :ref:`MEDIA_ENT_F_IO_V4L <media-ent-f-io-v4l>`
    \#define MEDIA\_ENT\_T\_V4L2\_SUBDEV                 \ :ref:`MEDIA_ENT_F_V4L2_SUBDEV_UNKNOWN <media-ent-f-v4l2-subdev-unknown>`
    \#define MEDIA\_ENT\_T\_V4L2\_SUBDEV\_SENSOR          \ :ref:`MEDIA_ENT_F_CAM_SENSOR <media-ent-f-cam-sensor>`
    \#define MEDIA\_ENT\_T\_V4L2\_SUBDEV\_FLASH           \ :ref:`MEDIA_ENT_F_FLASH <media-ent-f-flash>`
    \#define MEDIA\_ENT\_T\_V4L2\_SUBDEV\_LENS            \ :ref:`MEDIA_ENT_F_LENS <media-ent-f-lens>`
    \#define MEDIA\_ENT\_T\_V4L2\_SUBDEV\_DECODER         \ :ref:`MEDIA_ENT_F_ATV_DECODER <media-ent-f-atv-decoder>`
    \#define MEDIA\_ENT\_T\_V4L2\_SUBDEV\_TUNER           \ :ref:`MEDIA_ENT_F_TUNER <media-ent-f-tuner>`

    \#define MEDIA\_ENT\_F\_DTV\_DECODER                 \ :ref:`MEDIA_ENT_F_DV_DECODER <media-ent-f-dv-decoder>`

    \/\*
     \* There is still no full ALSA support in the media controller. These
     \* defines should not have been added and we leave them here only
     \* in case some application tries to use these defines.
     \*
     \* The ALSA defines that are in use have been moved into \_\_KERNEL\_\_
     \* scope. As support gets added to these interface types, they should
     \* be moved into \_\_KERNEL\_\_ scope with the code that uses them.
     \*\/
    \#define \ :ref:`MEDIA_INTF_T_ALSA_COMPRESS <media-intf-t-alsa-compress>`             (MEDIA\_INTF\_T\_ALSA\_BASE + 3)
    \#define \ :ref:`MEDIA_INTF_T_ALSA_RAWMIDI <media-intf-t-alsa-rawmidi>`              (MEDIA\_INTF\_T\_ALSA\_BASE + 4)
    \#define \ :ref:`MEDIA_INTF_T_ALSA_HWDEP <media-intf-t-alsa-hwdep>`                (MEDIA\_INTF\_T\_ALSA\_BASE + 5)
    \#define \ :ref:`MEDIA_INTF_T_ALSA_SEQUENCER <media-intf-t-alsa-sequencer>`            (MEDIA\_INTF\_T\_ALSA\_BASE + 6)
    \#define \ :ref:`MEDIA_INTF_T_ALSA_TIMER <media-intf-t-alsa-timer>`                (MEDIA\_INTF\_T\_ALSA\_BASE + 7)

    \/\* Obsolete symbol for media\_version, no longer used in the kernel \*\/
    \#define MEDIA\_API\_VERSION                       ((0 \<\< 16) \| (1 \<\< 8) \| 0)

    \#endif

    \#endif \/\* \_\_LINUX\_MEDIA\_H \*\/
